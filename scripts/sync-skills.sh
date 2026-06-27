#!/bin/bash
# Verifies the canonical root plugin layout.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"

test -d "$SKILLS_DIR"
test -f "$REPO_ROOT/.claude-plugin/plugin.json"
test -f "$REPO_ROOT/.claude-plugin/marketplace.json"
test -f "$REPO_ROOT/.codex-plugin/plugin.json"
test -f "$REPO_ROOT/.cursor-plugin/plugin.json"
test -f "$REPO_ROOT/.cursor-plugin/marketplace.json"
test -f "$REPO_ROOT/.mcp.json"
test -f "$REPO_ROOT/scripts/export-agent-skills-discovery.go"
test -f "$REPO_ROOT/gemini-extension.json"
test -f "$REPO_ROOT/GEMINI.md"
test -f "$REPO_ROOT/POWER.md"
test -f "$REPO_ROOT/mcp.json"
test -d "$REPO_ROOT/steering"

echo "Root plugin layout is ready"
