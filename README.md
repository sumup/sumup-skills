# SumUp Skills

A collection of [Agent Skills](https://agentskills.io/home) for building SumUp payment integrations across card-present (terminal) and card-not-present (online) checkout flows.

## Installing

These skills work with agents that support the Agent Skills standard, including Claude Code, Cursor, OpenCode, OpenAI Codex, and Pi.

### Claude Code

Install using the plugin marketplace:

```bash
/plugin marketplace add sumup/sumup-skills
```

### Cursor

Install from the Cursor Marketplace or add manually via **Settings > Rules > Add Rule > Remote Rule (Github)** with `sumup/sumup-skills`.

### npx skills

Install using the `npx skills` CLI:

```bash
npx skills add https://github.com/sumup/sumup-skills
```

### Clone / Copy

Clone this repo and copy the skill folders into the appropriate directory for your agent:

| Agent | Skill Directory | Docs |
|-------|-----------------|------|
| Claude Code | `~/.claude/skills/` | [docs](https://code.claude.com/docs/en/skills) |
| Cursor | `~/.cursor/skills/` | [docs](https://cursor.com/docs/context/skills) |
| OpenCode | `~/.config/opencode/skills/` | [docs](https://opencode.ai/docs/skills/) |
| OpenAI Codex | `~/.codex/skills/` | [docs](https://developers.openai.com/codex/skills/) |
| Pi | `~/.pi/agent/skills/` | [docs](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent#skills) |

## Skills

Skills are contextual and auto-loaded based on your conversation. When a request matches a skill's triggers, the agent loads and applies that skill.

| Skill | Useful for |
|-------|------------|
| sumup | Building SumUp checkout integrations for terminal and online payment flows, including SDK and API-based implementations |

## Resources

- [SumUp Developer Documentation](https://developer.sumup.com)
- [SumUp API Reference](https://developer.sumup.com/api)
- [SumUp MCP Server](https://mcp.sumup.com/mcp)
