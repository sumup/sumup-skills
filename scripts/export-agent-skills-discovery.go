package main

import (
	"archive/zip"
	"bufio"
	"bytes"
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"io/fs"
	"os"
	"path/filepath"
	"sort"
	"strings"
	"time"
)

const schemaURL = "https://schemas.agentskills.io/discovery/0.2.0/schema.json"

type index struct {
	Schema string  `json:"$schema"`
	Skills []skill `json:"skills"`
}

type skill struct {
	Name        string `json:"name"`
	Description string `json:"description"`
	Type        string `json:"type"`
	URL         string `json:"url"`
	Digest      string `json:"digest"`
}

func main() {
	outDir := flag.String("out", filepath.Join("dist", "agent-skills-discovery"), "output directory")
	baseURL := flag.String("base-url", "/.well-known/agent-skills", "base URL for archive links")
	flag.Parse()

	if err := run(*outDir, strings.TrimRight(*baseURL, "/")); err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}
}

func run(outDir, baseURL string) error {
	skillsDir := "skills"
	if err := os.RemoveAll(outDir); err != nil {
		return err
	}
	if err := os.MkdirAll(outDir, 0o755); err != nil {
		return err
	}

	entries, err := os.ReadDir(skillsDir)
	if err != nil {
		return err
	}

	discovered := make([]skill, 0, len(entries))
	for _, entry := range entries {
		if !entry.IsDir() {
			continue
		}

		skillDir := filepath.Join(skillsDir, entry.Name())
		metadata, err := readSkillMetadata(filepath.Join(skillDir, "SKILL.md"))
		if err != nil {
			return err
		}

		archiveName := metadata.Name + ".zip"
		archivePath := filepath.Join(outDir, archiveName)
		if err := writeArchive(skillDir, archivePath); err != nil {
			return err
		}

		digest, err := sha256File(archivePath)
		if err != nil {
			return err
		}

		discovered = append(discovered, skill{
			Name:        metadata.Name,
			Description: metadata.Description,
			Type:        "archive",
			URL:         baseURL + "/" + archiveName,
			Digest:      "sha256:" + digest,
		})
	}

	sort.Slice(discovered, func(i, j int) bool {
		return discovered[i].Name < discovered[j].Name
	})

	data, err := json.MarshalIndent(index{Schema: schemaURL, Skills: discovered}, "", "  ")
	if err != nil {
		return err
	}
	data = append(data, '\n')

	if err := os.WriteFile(filepath.Join(outDir, "index.json"), data, 0o644); err != nil {
		return err
	}

	fmt.Printf("Exported %d skills to %s\n", len(discovered), outDir)
	return nil
}

type skillMetadata struct {
	Name        string
	Description string
}

func readSkillMetadata(path string) (skillMetadata, error) {
	data, err := os.ReadFile(path)
	if err != nil {
		return skillMetadata{}, err
	}

	frontmatter, ok := frontmatterLines(data)
	if !ok {
		return skillMetadata{}, fmt.Errorf("%s is missing YAML frontmatter", path)
	}

	var metadata skillMetadata
	for _, line := range frontmatter {
		key, value, ok := strings.Cut(line, ":")
		if !ok {
			continue
		}
		key = strings.TrimSpace(key)
		value = strings.TrimSpace(value)
		value = strings.Trim(value, `"'`)

		switch key {
		case "name":
			metadata.Name = value
		case "description":
			metadata.Description = value
		}
	}

	if metadata.Name == "" || metadata.Description == "" {
		return skillMetadata{}, fmt.Errorf("%s must define name and description", path)
	}

	return metadata, nil
}

func frontmatterLines(data []byte) ([]string, bool) {
	scanner := bufio.NewScanner(bytes.NewReader(data))

	if !scanner.Scan() || strings.TrimSpace(scanner.Text()) != "---" {
		return nil, false
	}

	var lines []string
	for scanner.Scan() {
		line := scanner.Text()
		if strings.TrimSpace(line) == "---" {
			return lines, true
		}
		lines = append(lines, line)
	}

	return nil, false
}

func writeArchive(sourceDir, archivePath string) error {
	files, err := archiveFiles(sourceDir)
	if err != nil {
		return err
	}

	output, err := os.Create(archivePath)
	if err != nil {
		return err
	}
	defer output.Close()

	writer := zip.NewWriter(output)
	defer writer.Close()

	for _, file := range files {
		sourcePath := filepath.Join(sourceDir, file)
		info, err := os.Stat(sourcePath)
		if err != nil {
			return err
		}

		header, err := zip.FileInfoHeader(info)
		if err != nil {
			return err
		}
		header.Name = filepath.ToSlash(file)
		header.Method = zip.Store
		header.Modified = time.Date(1980, 1, 1, 0, 0, 0, 0, time.UTC)

		entry, err := writer.CreateHeader(header)
		if err != nil {
			return err
		}

		input, err := os.Open(sourcePath)
		if err != nil {
			return err
		}
		if _, err := io.Copy(entry, input); err != nil {
			input.Close()
			return err
		}
		if err := input.Close(); err != nil {
			return err
		}
	}

	return nil
}

func archiveFiles(root string) ([]string, error) {
	var files []string
	err := filepath.WalkDir(root, func(path string, entry fs.DirEntry, err error) error {
		if err != nil {
			return err
		}
		if entry.IsDir() {
			return nil
		}
		if entry.Name() == ".DS_Store" {
			return nil
		}
		relative, err := filepath.Rel(root, path)
		if err != nil {
			return err
		}
		files = append(files, relative)
		return nil
	})
	sort.Strings(files)
	return files, err
}

func sha256File(path string) (string, error) {
	file, err := os.Open(path)
	if err != nil {
		return "", err
	}
	defer file.Close()

	hash := sha256.New()
	if _, err := io.Copy(hash, file); err != nil {
		return "", err
	}

	return hex.EncodeToString(hash.Sum(nil)), nil
}
