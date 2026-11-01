# SumUp Debugging

Use this workflow when a SumUp integration fails or behaves inconsistently.

- Start by identifying the flow: Card Widget, Hosted Checkout, Checkouts API, webhook, mobile SDK, terminal SDK, Cloud API, or MCP.
- Collect request IDs, checkout IDs, merchant code, reference, timestamps, environment, and exact error messages.
- Identify the callback protocol first: online checkout notifications and Cloud API results have different payloads. Verify payment state through the API and make order updates idempotent; require signatures only where documented.
- Reconcile a timeout or uncertain result before retrying any payment or refund.
- For checkout expiry, compare session creation time, frontend mount timing, and user redirect timing.
- For widget mount issues, check allowed origins, CSP, browser console errors, checkout status, and frontend/backend environment mismatch.
- For Cloud API or terminal failures, inspect reader status, checkout status, network path, merchant permissions, and async state transitions.
