---
name: "sumup"
displayName: "SumUp"
description: "Build, test, upgrade, and debug SumUp payment integrations across online checkout, terminal, and Cloud API flows"
keywords: ["sumup", "payments", "checkout", "card widget", "hosted checkout", "terminal", "cloud api", "webhooks", "3ds", "sandbox", "mcp"]
author: "SumUp"
---

# Onboarding

Use this power for SumUp payment integrations. Prefer the latest SumUp Developer Documentation over stale memory:

- Docs root: `https://developer.sumup.com/`
- API reference: `https://developer.sumup.com/api`
- LLM entrypoint: `https://developer.sumup.com/llms.txt`

If tool access is needed, use the `sumup` MCP server from `mcp.json`.

## When to Load Steering Files

- Implementing online or terminal checkout flows -> `steering/checkout-integrations.md`
- Choosing an integration path or reviewing security posture -> `steering/best-practices.md`
- Troubleshooting failed SumUp integrations -> `steering/debugging.md`
- Configuring or using the SumUp MCP server -> `steering/mcp.md`
- Planning sandbox or end-to-end tests -> `steering/testing.md`
- Upgrading SumUp APIs or SDKs -> `steering/upgrades.md`

## General Rules

- Use sandbox credentials and test merchants for test flows.
- Keep secrets out of code, logs, and prompts.
- For Card Widget and Hosted Checkout, create checkouts server-side and avoid exposing privileged credentials to browsers.
- For webhooks, verify signatures before trusting event payloads.
- For terminal and Cloud API flows, account for asynchronous status transitions and idempotency.
