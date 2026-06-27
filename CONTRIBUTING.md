# Contributing

Thanks for contributing to `sumup-skills`.

## Development

- Add or update skill content under `skills/`.
- Keep instructions practical, current, and source-backed.
- Prefer incremental pull requests focused on one skill or one clear change.

## Conventional Commits

`sumup-skills` uses [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

Examples:

- `feat: add checkout widget troubleshooting guidance`
- `fix: correct Cloud API references in sumup skill`
- `docs: improve installation instructions in readme`

## Releases

When preparing a release, update the version in every published manifest and any release verification docs that mention the current version:

- `gemini-extension.json`
- `.cursor-plugin/marketplace.json`
- `.cursor-plugin/plugin.json`
- `.claude-plugin/marketplace.json`
- `.claude-plugin/plugin.json`
- `.agents/plugins/marketplace.json`
- `.codex-plugin/plugin.json`
- `CURSOR_DESKTOP_VERIFICATION_CHECKLIST.md`
