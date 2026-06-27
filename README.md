<div align="center">

# SumUp Skills

[![Documentation][docs-badge]](https://developer.sumup.com)
[![License](https://img.shields.io/github/license/sumup/sumup-go)](./LICENSE)

</div>

A collection of [Agent Skills](https://agentskills.io/home) for building SumUp payment integrations across card-present (terminal) and card-not-present (online) checkout flows.

## Installing

These skills work with agents that support the Agent Skills standard, including Claude Code, Cursor, Gemini CLI, OpenCode, OpenAI Codex, and Pi.

### Claude Code

Install using the plugin marketplace:

```bash
/plugin marketplace add sumup/sumup-skills
/plugin install sumup@sumup
```

### Cursor

Install from the Cursor Marketplace or add manually via **Settings > Rules > Add Rule > Remote Rule (Github)** with `sumup/sumup-skills`.

### Gemini CLI

Install the extension from GitHub:

```bash
gemini extensions install https://github.com/sumup/sumup-skills --ref=main
```

### OpenAI Codex

Install using the Codex plugin marketplace:

```bash
codex plugin marketplace add sumup/sumup-skills
```

### Kiro

Import this repository as a custom power from Kiro: **Powers > Add Custom Power > Import power from GitHub**.

For local testing, use **Import power from a folder** and select this repository root.

### Agent Skills Discovery

Agents and tools that support the [Agent Skills Discovery RFC](https://github.com/cloudflare/agent-skills-discovery-rfc) can discover the SumUp skills from:

`https://developer.sumup.com/.well-known/agent-skills/index.json`

Use this URL in clients that accept a discovery index or start from `https://developer.sumup.com` when the client discovers well-known skill indexes automatically.

### Clone / Copy

Clone this repo and copy the skill folders into the appropriate directory for your agent:

| Agent | Skill Directory | Docs |
|-------|-----------------|------|
| Claude Code | `~/.claude/skills/` | [docs](https://code.claude.com/docs/en/skills) |
| Cursor | `~/.cursor/skills/` | [docs](https://cursor.com/docs/context/skills) |
| Gemini CLI | `~/.gemini/extensions/` | [docs](https://geminicli.com/docs/extensions/) |
| OpenCode | `~/.config/opencode/skills/` | [docs](https://opencode.ai/docs/skills/) |
| OpenAI Codex | `~/.codex/skills/` | [docs](https://developers.openai.com/codex/skills/) |
| Pi | `~/.pi/agent/skills/` | [docs](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent#skills) |

## Skills

Install using the `npx skills` CLI:

```bash
npx skills add https://github.com/sumup/sumup-skills
```

Skills are contextual and auto-loaded based on your conversation. When a request matches a skill's triggers, the agent loads and applies that skill.

| Skill | Useful for |
|-------|------------|
| [sumup](./skills/sumup/) | Implementing SumUp checkout flows end-to-end across Checkouts API, Card Widget, Hosted Checkout, recurring tokenization, and terminal/cloud reader checkouts |
| [sumup-best-practices](./skills/sumup-best-practices/) | Choosing the right integration path and security posture across Hosted Checkout, Card Widget, Checkouts API, mobile SDKs, terminal SDKs, and Cloud API |
| [upgrade-sumup](./skills/upgrade-sumup/) | Planning and executing SumUp API/SDK upgrades and migrations across server and mobile SDK surfaces |
| [sumup-debug](./skills/sumup-debug/) | Diagnosing and fixing common integration failures such as webhook signature mismatches, scope issues, session expiry, widget mount failures, and duplicate references |
| [sumup-mcp](./skills/sumup-mcp/) | Configuring and using the SumUp MCP server (`https://mcp.sumup.com/mcp`) from MCP-capable clients |
| [sumup-testing](./skills/sumup-testing/) | Setting up sandbox test merchants, running success/failure scenarios (including `amount = 11`), and validating end-to-end checkout behavior |

## Resources

- [SumUp Developer Documentation](https://developer.sumup.com)
- [SumUp API Reference](https://developer.sumup.com/api)
- [SumUp MCP Server](https://mcp.sumup.com/mcp)

[docs-badge]: https://img.shields.io/badge/SumUp-documentation-white.svg?logo=data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgY29sb3I9IndoaXRlIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogICAgPHBhdGggZD0iTTIyLjI5IDBIMS43Qy43NyAwIDAgLjc3IDAgMS43MVYyMi4zYzAgLjkzLjc3IDEuNyAxLjcxIDEuN0gyMi4zYy45NCAwIDEuNzEtLjc3IDEuNzEtMS43MVYxLjdDMjQgLjc3IDIzLjIzIDAgMjIuMjkgMFptLTcuMjIgMTguMDdhNS42MiA1LjYyIDAgMCAxLTcuNjguMjQuMzYuMzYgMCAwIDEtLjAxLS40OWw3LjQ0LTcuNDRhLjM1LjM1IDAgMCAxIC40OSAwIDUuNiA1LjYgMCAwIDEtLjI0IDcuNjlabTEuNTUtMTEuOS03LjQ0IDcuNDVhLjM1LjM1IDAgMCAxLS41IDAgNS42MSA1LjYxIDAgMCAxIDcuOS03Ljk2bC4wMy4wM2MuMTMuMTMuMTQuMzUuMDEuNDlaIiBmaWxsPSJjdXJyZW50Q29sb3IiLz4KPC9zdmc+
