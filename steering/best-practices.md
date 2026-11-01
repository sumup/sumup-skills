# SumUp Best Practices

Use this workflow for integration choices and security review.

- Choose the simplest integration that satisfies the product requirements.
- Keep merchant secrets and API keys server-side.
- Use OAuth when acting on behalf of merchants and API keys only for first-party/server-owned integrations.
- Request only the documented permissions needed by the selected endpoints; verify which credential controls the product supports.
- Retrieve payment state through the API before business effects. Apply signature checks only when the selected webhook protocol documents them.
- Log stable identifiers and status transitions, not full cardholder or secret-bearing payloads.
- Document rollback and fallback behavior before changing payment-critical flows.
