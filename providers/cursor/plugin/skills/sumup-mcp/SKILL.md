---
name: sumup-mcp
description: Use the SumUp MCP server (https://mcp.sumup.com/mcp) from Cursor, Claude Code, Codex, or any MCP-capable client. Use when the user mentions SumUp MCP, needs to wire mcp.sumup.com, or wants tool-based access to SumUp APIs.
license: Apache-2.0
---

# SumUp MCP Server Guide

Use this skill when setup or usage of the SumUp MCP server is requested.

Canonical endpoint:

- `https://mcp.sumup.com/mcp`

## What this skill covers

- MCP server wiring in MCP-capable clients
- Auth handshake troubleshooting
- Prompt patterns for tool-driven SumUp API tasks
- Safe usage guardrails for production and sandbox contexts

## Minimal Setup Checklist

1. Add an MCP server entry named `sumup`.
2. Set URL to `https://mcp.sumup.com/mcp`.
3. Use streamable HTTP transport if the client requires explicit transport.
4. Complete authentication flow when prompted by the client.
5. Confirm tools are discoverable before first task prompt.

## Example MCP Server Declaration

```json
{
  "servers": {
    "sumup": {
      "url": "https://mcp.sumup.com/mcp",
      "transport": "streamable_http"
    }
  }
}
```

Adapt field names to the target client's MCP config schema.

## Prompt Patterns

- "List my SumUp merchant checkouts from the last 24 hours."
- "Create a sandbox checkout for 12.34 EUR and return the checkout id."
- "Inspect this checkout id and summarize status transitions."
- "Show what data is needed to reconcile failed payments for this reference."

## Common Failure Modes

### Server not reachable

- Confirm exact URL and transport.
- Check client allows outbound HTTPS.
- Retry from a clean session.

### Auth loop or unauthorized

- Re-run auth handshake and ensure correct account/environment.
- Confirm the token/session has required scopes.

### Tools not appearing

- Refresh/reload MCP server in client.
- Confirm server alias matches the expected name in prompts/config.

## Safety and Reliability Rules

- Never expose secrets or raw tokens in prompts or logs.
- Prefer sandbox for new workflows and regression tests.
- For payment-critical actions, verify final checkout status through deterministic reads.
- Record checkout ids/references for auditability and reconciliation.

## Required Response Contract

When answering MCP setup/use requests, include:

1. Exact server configuration snippet.
2. Authentication steps and where failures usually happen.
3. One verification command/prompt to confirm setup.
4. A safe first task in sandbox before production usage.
