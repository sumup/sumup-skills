# SumUp Testing

Use this workflow for SumUp sandbox and end-to-end test planning.

- Cover happy path, explicit failure path, cancellation, expiry, duplicate reference, and webhook retry behavior.
- Use sandbox merchants and sandbox credentials only.
- Include SumUp's forced failure scenario where `amount = 11`; for reader tests, follow the in-person guide for physical cards, sandbox login, and specific `42.xx` decline amounts.
- Test sandbox tokenization with the Payment Widget, including 3DS; this does not require extra activation.
- Verify both synchronous UI results and asynchronous webhook or status reconciliation.
- Record evidence: checkout ID, reference, status transitions, webhook event IDs, timestamps, and relevant request IDs.
- Keep tests deterministic and avoid relying only on visual UI confirmation.
