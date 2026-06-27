# SumUp Debugging

Use this workflow when a SumUp integration fails or behaves inconsistently.

- Start by identifying the flow: Card Widget, Hosted Checkout, Checkouts API, webhook, mobile SDK, terminal SDK, Cloud API, or MCP.
- Collect request IDs, checkout IDs, merchant code, reference, timestamps, environment, and exact error messages.
- For webhook failures, verify raw-body handling, timestamp tolerance, signing secret, replay protection, and handler idempotency.
- For checkout expiry, compare session creation time, frontend mount timing, and user redirect timing.
- For widget mount issues, check allowed origins, CSP, browser console errors, checkout status, and frontend/backend environment mismatch.
- For Cloud API or terminal failures, inspect reader status, checkout status, network path, merchant permissions, and async state transitions.
