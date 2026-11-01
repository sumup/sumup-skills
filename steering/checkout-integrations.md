# SumUp Checkout Integrations

Use this workflow when implementing SumUp checkout flows end-to-end.

- Online payments:
  - Hosted Checkout is best when redirect UX is acceptable and implementation speed matters.
  - Card Widget is best when the app needs embedded checkout with low PCI scope.
  - Checkouts API orchestration is required for custom flows, 3DS handling, and webhook-driven fulfillment.
- Terminal payments:
  - Use native terminal SDKs when the mobile app controls the reader directly.
  - Use Cloud API when a backend or non-native POS controls compatible readers.
  - Use Payment Switch only when legacy SumUp app handoff is explicitly required.
- Always create checkout resources on the server.
- Treat webhooks as notifications and verify checkout or transaction status through API reads before fulfillment.
- Use `checkout_reference` to identify and reconcile each attempt; do not assume it provides server-enforced idempotency. Resolve the previous result before starting another attempt.
