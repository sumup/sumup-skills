# Contributing

Thanks for contributing to `sumup-skills`.

## Development

- Add or update skill content under `skills/`.
- Keep instructions practical, current, and source-backed.
- Prefer incremental pull requests focused on one skill or one clear change.

## Plugin validation

The portable package uses root `plugin.json`, `mcp.json`, and `skills/`. Client manifests under `.claude-plugin/`, `.codex-plugin/`, and `.cursor-plugin/` preserve native integrations. Keep their shared metadata consistent with `plugin.json`.

`mcp.json` uses the Agent Plugins `streamable-http` transport. `.mcp.json` uses the native `http` transport for Claude Code and the compatibility manifests; Gemini uses `httpUrl` in `gemini-extension.json`. All three configurations must point to the same hosted OAuth endpoint.

Run `just verify` with Python 3.9+, uv, Claude Code, and Go installed. `just verify-agent-plugin` checks the portable JSON schemas, shared manifest metadata, marketplace sources, MCP configuration, and referenced resources. The validation workflow also runs these checks and validates every skill with `skills-ref`.

Use the [Cursor verification checklist](./CURSOR_DESKTOP_VERIFICATION_CHECKLIST.md) for installation, skill routing, and OAuth checks that require the desktop client.

Format references:

- [Agent Plugins specification](https://agent-plugins.org/specification)
- [OpenAI plugin packaging](https://developers.openai.com/plugins/build/plugins)
- [Cursor plugin reference](https://cursor.com/docs/reference/plugins)
- [Claude plugin manifest reference](https://code.claude.com/docs/en/plugins-reference)
- [Gemini extension reference](https://geminicli.com/docs/extensions/reference/)
- [Kiro power format](https://kiro.dev/docs/powers/create/)

## Keeping integration guidance current

Keep skill descriptions focused on the task that should select them. Put decisions and payment safeguards in `SKILL.md`; link client-specific setup or scenario data from `references/` with a clear loading condition. Keep each skill usable when installed on its own. Preserve exact credential and payment-state rules, while scaling workflow and response detail to the user's request.

Use the [routing and scope probes](./CURSOR_DESKTOP_VERIFICATION_CHECKLIST.md#narrow-tasks-and-routing-probes) to check changes with real agent runs. Record the selected skill, references, actions, and outcome. Static validation checks structure and packaging, not whether an agent selects or follows a skill correctly. See the [Agent Skills authoring guidance](https://agentskills.io/skill-creation/best-practices) for context and scope decisions.

Use the current [SumUp documentation index](https://developer.sumup.com/llms.txt), [API reference index](https://developer.sumup.com/api/llms.txt), and [OpenAPI contract](https://developer.sumup.com/openapi.json) as sources. Compare `sumup-developer` content and changelog commits since the affected skill or reference last changed, rather than using the latest dependency or plugin-setup commit as the content baseline. Distinguish committed documentation from local work and draft pages.

Keep references, top-level skills, and legacy Kiro steering consistent. Prefer current SDK documentation over duplicated language snippets when the installed SDK's request types or service names matter.

The developer website imports these skills from the revision pinned in its `agent-skills.source.json`. After committing a skill update, refresh that source through the website's `npm run sync:agent-skills` workflow; do not hand-edit imported copies or discovery archives.

## Conventional Commits

`sumup-skills` uses [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

Examples:

- `feat: add checkout widget troubleshooting guidance`
- `fix: correct Cloud API references in sumup skill`
- `docs: improve installation instructions in readme`

## Releases

When preparing a release, bump the version in every published manifest and marketplace entry that declares one. Hosted clients cache versioned plugins, so pushing changed files without a version bump can leave users on an older payload:

- `plugin.json`
- `gemini-extension.json`
- `.cursor-plugin/marketplace.json`
- `.cursor-plugin/plugin.json`
- `.claude-plugin/marketplace.json`
- `.claude-plugin/plugin.json`
- `.codex-plugin/plugin.json`

`.agents/plugins/marketplace.json` points to the plugin root and does not declare a separate version. Run `just verify-agent-plugin` after changing release metadata.
