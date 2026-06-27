# SumUp MCP

Use this workflow when configuring or using the SumUp MCP server.

- The MCP server name is `sumup` in `mcp.json`.
- The endpoint is `https://mcp.sumup.com/mcp`.
- Prefer read-only or low-impact tool calls for the first verification step.
- If authentication is required, guide the user through the client auth flow instead of inventing credentials.
- Confirm which environment is active before using tools that create or mutate payment resources.
- Summarize tool results with stable identifiers and next actions.
