set shell := ["bash", "-euo", "pipefail", "-c"]

default:
  @just help

# Show available commands.
help:
  @just --list --unsorted

# Verify the root plugin layout.
sync-skills:
  ./scripts/sync-skills.sh

# Validate the root Claude marketplace manifest.
validate-claude-marketplace:
  claude plugin validate .

# Validate the Claude plugin payload manifest.
validate-claude-plugin:
  claude plugin validate .

# Verify the Cursor plugin payload contains the manifest and root skill files.
verify-cursor-plugin:
  test -f .cursor-plugin/plugin.json
  test -f .cursor-plugin/marketplace.json
  test -f .mcp.json
  just verify-cursor-plugin-skills

# Verify the Codex plugin payload contains the manifest and root skill files.
verify-codex-plugin:
  test -f .codex-plugin/plugin.json
  test -f .mcp.json
  test -f .agents/plugins/marketplace.json
  just verify-codex-plugin-skills

# Verify all source skills are available to the Codex plugin payload.
verify-codex-plugin-skills:
  test -f skills/sumup/SKILL.md
  test -f skills/sumup-best-practices/SKILL.md
  test -f skills/upgrade-sumup/SKILL.md
  test -f skills/sumup-debug/SKILL.md
  test -f skills/sumup-mcp/SKILL.md
  test -f skills/sumup-testing/SKILL.md

# Verify all source skills are available to the Cursor plugin payload.
verify-cursor-plugin-skills:
  test -f skills/sumup/SKILL.md
  test -f skills/sumup-best-practices/SKILL.md
  test -f skills/upgrade-sumup/SKILL.md
  test -f skills/sumup-debug/SKILL.md
  test -f skills/sumup-mcp/SKILL.md
  test -f skills/sumup-testing/SKILL.md

# Verify the Gemini extension payload contains the manifest and context files.
verify-gemini-extension:
  test -f gemini-extension.json
  test -f GEMINI.md
  test -f skills/sumup/SKILL.md
  test -f skills/sumup-best-practices/SKILL.md
  test -f skills/upgrade-sumup/SKILL.md
  test -f skills/sumup-debug/SKILL.md
  test -f skills/sumup-mcp/SKILL.md
  test -f skills/sumup-testing/SKILL.md

# Verify the Agent Skills Discovery export can be generated deterministically.
verify-agent-skills-discovery:
  rm -rf /tmp/sumup-agent-skills-discovery
  GOCACHE=/tmp/sumup-skills-go-build go run scripts/export-agent-skills-discovery.go --out /tmp/sumup-agent-skills-discovery
  test -f /tmp/sumup-agent-skills-discovery/index.json
  test -f /tmp/sumup-agent-skills-discovery/sumup.zip
  test -f /tmp/sumup-agent-skills-discovery/sumup-best-practices.zip
  test -f /tmp/sumup-agent-skills-discovery/sumup-debug.zip
  test -f /tmp/sumup-agent-skills-discovery/sumup-mcp.zip
  test -f /tmp/sumup-agent-skills-discovery/sumup-testing.zip
  test -f /tmp/sumup-agent-skills-discovery/upgrade-sumup.zip

# Verify the Kiro power payload contains the required files.
verify-kiro-power:
  test -f POWER.md
  test -f mcp.json
  test -f steering/checkout-integrations.md
  test -f steering/best-practices.md
  test -f steering/debugging.md
  test -f steering/mcp.md
  test -f steering/testing.md
  test -f steering/upgrades.md

# Sync skills and run all available marketplace/plugin checks.
verify: sync-skills validate-claude-marketplace validate-claude-plugin verify-codex-plugin verify-cursor-plugin verify-gemini-extension verify-agent-skills-discovery verify-kiro-power
