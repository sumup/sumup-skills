# SumUp Best Practices

Use this workflow for integration choices and security review.

- Choose the simplest integration that satisfies the product requirements.
- Keep merchant secrets and API keys server-side.
- Use OAuth when acting on behalf of merchants and API keys only for first-party/server-owned integrations.
- Use restricted keys where available and scope credentials to the minimum required operations.
- Validate webhook signatures before processing business effects.
- Log stable identifiers and status transitions, not full cardholder or secret-bearing payloads.
- Document rollback and fallback behavior before changing payment-critical flows.
