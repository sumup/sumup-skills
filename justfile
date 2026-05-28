set shell := ["bash", "-euo", "pipefail", "-c"]

default:
  @just help

# Show available commands.
help:
  @just --list --unsorted

# Sync source skills into the Claude and Cursor plugin payloads.
sync-skills:
  ./scripts/sync-skills.sh

# Validate the root Claude marketplace manifest.
validate-claude-marketplace:
  claude plugin validate .

# Validate the Claude plugin payload manifest.
validate-claude-plugin:
  claude plugin validate providers/claude/plugin

# Verify the Cursor plugin payload contains the synced skill files.
verify-cursor-plugin:
  test -f providers/cursor/plugin/.cursor-plugin/plugin.json
  just verify-cursor-plugin-skills

# Verify all source skills are synced to the Cursor plugin payload.
verify-cursor-plugin-skills:
  test -f providers/cursor/plugin/skills/sumup/SKILL.md
  test -f providers/cursor/plugin/skills/sumup-best-practices/SKILL.md
  test -f providers/cursor/plugin/skills/upgrade-sumup/SKILL.md
  test -f providers/cursor/plugin/skills/sumup-debug/SKILL.md
  test -f providers/cursor/plugin/skills/sumup-mcp/SKILL.md
  test -f providers/cursor/plugin/skills/sumup-testing/SKILL.md

# Sync skills and run all available marketplace/plugin checks.
verify: sync-skills validate-claude-marketplace validate-claude-plugin verify-cursor-plugin
