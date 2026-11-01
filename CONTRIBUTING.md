# Contributing

Keep changes focused and use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), such as `docs: clarify sandbox testing`.

## Make Changes

- Edit skills under `skills/`. Describe when each skill applies, keep its instructions concise, and put detailed setup or scenarios in `references/`.
- Keep each skill usable on its own. Preserve payment and credential safeguards, and match the workflow to the user's request.
- Keep shared metadata in the client manifests consistent with root `plugin.json`.

The portable package uses `plugin.json`, `mcp.json`, and `skills/` at the repository root. Native clients also use `.claude-plugin/`, `.codex-plugin/`, `.cursor-plugin/`, and `gemini-extension.json`.

For MCP, `mcp.json` uses `streamable-http`, `.mcp.json` uses `http`, and Gemini uses `httpUrl`. All point to `https://mcp.sumup.com/mcp` and use OAuth.

## Plugin Documentation

| Topic | References |
| --- | --- |
| Agent Plugins | [Authoring guide](https://agent-plugins.org/plugin-authors/build-an-agent-plugin), [specification](https://agent-plugins.org/specification), [plugin manifest schema](https://agent-plugins.org/schemas/1.0.0/plugin.schema.json) |
| Bundled MCP servers | [Configuration guide](https://agent-plugins.org/plugin-authors/mcp-servers), [MCP schema](https://agent-plugins.org/schemas/1.0.0/mcp.schema.json) |
| Agent Skills | [Specification](https://agentskills.io/specification), [authoring guidance](https://agentskills.io/skill-creation/best-practices) |
| Codex / ChatGPT | [Plugin packaging and marketplaces](https://developers.openai.com/plugins/build/plugins), [submission metadata and review](https://developers.openai.com/plugins/deploy/submission#automatically-provide-submission-and-review-information) |
| Claude Code | [Plugin manifest](https://code.claude.com/docs/en/plugins-reference), [marketplace reference](https://code.claude.com/docs/en/plugins/marketplace-reference) |
| Cursor | [Plugin reference](https://cursor.com/docs/reference/plugins) |
| Gemini CLI | [Extension reference](https://geminicli.com/docs/extensions/reference/), [releases](https://geminicli.com/docs/extensions/releasing/) |
| Kiro | [Power format](https://kiro.dev/docs/powers/create/) |
| VS Code / GitHub Copilot | [Plugin authoring reference](https://code.visualstudio.com/docs/agents/reference/agent-plugin-reference) |
| Skill discovery | [Agent Skills Discovery RFC](https://github.com/cloudflare/agent-skills-discovery-rfc) |

## Validate Changes

Install just, Python 3.9+, uv, Claude Code, and Go, then run `just verify`. It checks schemas, manifest consistency, plugin files, Claude manifests, and discovery exports. For manifest-only changes, run `just verify-agent-plugin`. CI also validates every skill with `skills-ref` and checks Markdown with rumdl.

Use the [desktop verification checklist](./CURSOR_DESKTOP_VERIFICATION_CHECKLIST.md), including its [routing and scope probes](./CURSOR_DESKTOP_VERIFICATION_CHECKLIST.md#narrow-tasks-and-routing-probes), to check installation, OAuth, and actual agent behavior. Record what ran; static checks cannot prove that an agent selects or follows a skill correctly.

## Keep Content Current

Check the [SumUp documentation index](https://developer.sumup.com/llms.txt), [API reference index](https://developer.sumup.com/api/llms.txt), and [OpenAPI contract](https://developer.sumup.com/openapi.json). Compare `sumup-developer` documentation and changelog changes since the affected skill last changed. Distinguish published guidance from drafts and uncommitted work. Verify SDK examples against the relevant version.

The developer website imports skills from the revision in its `agent-skills.source.json`. After committing a skill update, update that revision and run `npm run sync:agent-skills` in `sumup-developer`. Do not hand-edit imported skills or discovery archives.

## Releases

Bump the version in these files when releasing changes, so clients can refresh cached plugins:

- `plugin.json` and `.codex-plugin/plugin.json`
- `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`
- `.cursor-plugin/plugin.json` and `.cursor-plugin/marketplace.json`
- `gemini-extension.json`

`.agents/plugins/marketplace.json` points to the plugin root and has no separate version. Run `just verify-agent-plugin` after updating release metadata.

### Prepare an OpenAI Submission

Keep listing, review, and release information in `plugin.json` under `extensions.com.openai`. Mirror review and publication fields in `.codex-plugin/plugin.json`; its listing fields stay in the top-level `interface`. The portable metadata takes precedence over the compatibility manifest as a whole.

The packaged cases are proposed scenarios, not recorded test results. Before submitting:

- Prepare a dedicated sandbox account with read access to merchant details, checkouts, transactions, and readers. Seed a checkout with reference `sumup-review-existing`; empty transaction and reader lists are valid.
- Check the deployed MCP tool names, run all five positive and three negative cases, and record the results. Local validation only checks the metadata.
- Record a walkthrough and add its reviewer-accessible URL as `review.demo_recording_url` in both manifests.
- Enter reviewer credentials and sign-in steps privately in the dashboard. Reviewers must be able to sign in without MFA, email approval, or private network access. Keep credentials out of the repository and ZIP.
- Check the imported listing, OAuth setup, commerce declaration, and country availability in the dashboard. Countries and translations are currently omitted; this preserves saved targeting rather than declaring worldwide availability.

Review cases use account queries. Taking payments through MCP is not supported; the skills help developers build payment integrations in their own applications.

Include the root manifest, MCP configuration, skills, and referenced assets in the ZIP. Public submissions cannot include app references (`apps` / `.app.json`) or lifecycle hooks. Complete the dashboard's required attestations before submitting for review.
