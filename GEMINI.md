# SumUp for Gemini CLI

This extension provides guidance for building SumUp payment integrations.

Use the bundled skills under [skills/](skills/) when a request involves SumUp:

- SumUp checkout creation and payment processing
- Terminal and tap-to-pay flows
- Reader pairing and reader checkouts
- Card Widget, Hosted Checkout, and Checkouts API integrations
- Cloud API, SDK, API key, OAuth, or Affiliate Key setup
- Webhooks, 3DS flows, and payment status handling

Prefer these entry points:

- [skills/sumup/SKILL.md](skills/sumup/SKILL.md) for implementation.
- [skills/sumup-best-practices/SKILL.md](skills/sumup-best-practices/SKILL.md) for integration choices and security posture.
- [skills/sumup-debug/SKILL.md](skills/sumup-debug/SKILL.md) for troubleshooting.
- [skills/sumup-mcp/SKILL.md](skills/sumup-mcp/SKILL.md) for SumUp MCP setup and use.
- [skills/sumup-testing/SKILL.md](skills/sumup-testing/SKILL.md) for sandbox and end-to-end testing.
- [skills/upgrade-sumup/SKILL.md](skills/upgrade-sumup/SKILL.md) for SDK and API upgrades.

Use the references under [skills/sumup/references/](skills/sumup/references/) for the relevant platform or integration surface.

The extension configures the `sumup` MCP server at `https://mcp.sumup.com/mcp`. Use read-only or low-impact tool calls for the first verification step, and guide the user through authentication if the server requests it.
