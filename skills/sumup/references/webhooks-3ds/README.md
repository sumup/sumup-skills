# Webhooks and 3DS

## 3DS flow

1. Include `redirect_url` on checkout creation.
2. Process checkout and inspect `next_step`.
3. Redirect/post customer to `next_step.url` with full `next_step.payload`.
4. After challenge, verify status using retrieve-checkout API.

## Webhooks

- Subscribe by setting `return_url` at checkout creation.
- Expect checkout status change events.
- Respond quickly with empty `2xx`.
- Treat webhook as signal; re-fetch and verify checkout state from API.
- Implement idempotent processing for retries.
