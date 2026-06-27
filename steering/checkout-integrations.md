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
- Persist and reconcile checkout status using webhook events or explicit API reads.
- Treat `checkout_reference` as an idempotency and reconciliation key; avoid duplicate references.
