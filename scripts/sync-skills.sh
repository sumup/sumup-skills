#!/bin/bash
# Copies skills/ to provider plugin directories.
# Run this after editing any file in skills/.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"
TARGETS=(
  "$REPO_ROOT/providers/claude/plugin/skills"
  "$REPO_ROOT/providers/cursor/plugin/skills"
)

for target in "${TARGETS[@]}"; do
  if [ -L "$target" ] || [ -f "$target" ]; then
    rm -f "$target"
  fi

  mkdir -p "$target"

  # Remove old synced contents before copying the source set again.
  find "$target" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

  for skill_dir in "$SKILLS_DIR"/*; do
    [ -d "$skill_dir" ] || continue
    cp -R "$skill_dir" "$target/"
  done

  echo "Synced skills to $target"
done
