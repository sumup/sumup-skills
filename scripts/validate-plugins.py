#!/usr/bin/env python3
"""Check consistency and referenced files across the published plugin formats.

Run check-jsonschema separately for the portable Agent Plugins schemas.
"""

import json
from pathlib import Path
import re
import sys


ROOT = Path(__file__).resolve().parent.parent


def read(path):
    return json.loads((ROOT / path).read_text())


def require(condition, message):
    if not condition:
        raise ValueError(message)


def local_path(path):
    require(isinstance(path, str), "Expected a relative path")
    resolved = (ROOT / path).resolve()
    require(not Path(path).is_absolute() and resolved.is_relative_to(ROOT),
            f"Path escapes the plugin root: {path}")
    require(resolved.exists(), f"Missing plugin resource: {path}")
    return resolved


def validate():
    portable = read("plugin.json")
    name = portable["name"]
    version = portable["version"]
    require(re.fullmatch(r"\d+\.\d+\.\d+", version), "Expected a release version")
    interface = portable["extensions"]["com.openai"]["interface"]

    for client in ("claude", "codex", "cursor"):
        path = f".{client}-plugin/plugin.json"
        manifest = read(path)
        for key in ("name", "version", "description", "author", "homepage",
                    "repository", "license", "keywords"):
            require(manifest[key] == portable[key], f"{path}: {key} differs from plugin.json")
        if "skills" in manifest:
            require(local_path(manifest["skills"]) == ROOT / "skills",
                    f"{path}: skills must point to the canonical skills directory")
        if "mcpServers" in manifest:
            require(local_path(manifest["mcpServers"]) == ROOT / ".mcp.json",
                    f"{path}: expected the native MCP configuration")
        if client == "codex":
            require(manifest["interface"] == interface, "Codex presentation metadata differs")
        if "logo" in manifest:
            local_path(manifest["logo"])

    for key in ("composerIcon", "logo"):
        local_path(interface[key])

    for client, path in (
        ("claude", ".claude-plugin/marketplace.json"),
        ("cursor", ".cursor-plugin/marketplace.json"),
        ("codex", ".agents/plugins/marketplace.json"),
    ):
        marketplace = read(path)
        require(marketplace["name"] == name, f"{path}: unexpected marketplace name")
        require(len(marketplace["plugins"]) == 1, f"{path}: expected one root plugin")
        entry = marketplace["plugins"][0]
        require(entry["name"] == name, f"{path}: unexpected plugin name")
        if "version" in entry:
            require(entry["version"] == version, f"{path}: release version differs")
        source = entry["source"]
        if client == "codex":
            require(source["source"] == "local", f"{path}: expected a local source")
            source = source["path"]
        require(local_path(source) == ROOT, f"{path}: source must point to the plugin root")
        if "logo" in entry:
            local_path(entry["logo"])

    # Native clients and Agent Plugins use different transport field names.
    endpoint = "https://mcp.sumup.com/mcp"
    for path, transport, url_field in (
        ("mcp.json", "streamable-http", "url"),
        (".mcp.json", "http", "url"),
        ("gemini-extension.json", None, "httpUrl"),
    ):
        config = read(path)
        require(set(config["mcpServers"]) == {name}, f"{path}: unexpected MCP servers")
        server = config["mcpServers"][name]
        expected = {url_field: endpoint}
        if transport:
            expected["type"] = transport
        require(server == expected, f"{path}: expected the hosted OAuth server configuration")

    gemini = read("gemini-extension.json")
    require(gemini["name"] == name and gemini["version"] == version,
            "Gemini extension identity differs from plugin.json")
    local_path(gemini["contextFileName"])

    skills = sorted((ROOT / "skills").iterdir())
    require(bool(skills), "No skills found")
    for skill in skills:
        require(skill.is_dir() and (skill / "SKILL.md").is_file(),
                f"Missing skill entry point: {skill.relative_to(ROOT)}")
    print(f"Plugin {name} {version}: manifests, MCP configurations, assets, and {len(skills)} skills agree")


if __name__ == "__main__":
    try:
        validate()
    except (OSError, ValueError, KeyError, TypeError) as error:
        print(f"Plugin validation failed: {error}", file=sys.stderr)
        sys.exit(1)
