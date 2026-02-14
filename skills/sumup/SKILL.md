---
name: sumup
description: Guide for building SumUp payment integrations that cover both terminal (card-present) and online (card-not-present) checkout flows using SumUp SDKs and APIs. Use when implementing or debugging SumUp checkout creation, payment processing, reader pairing, Card Widget integrations, Cloud API reader checkouts, or authorization setup with API keys/OAuth and Affiliate Keys.
---

# SumUp Checkout Integrations

Use this skill to implement end-to-end SumUp checkouts for:

- Terminal payments (native mobile SDKs, Cloud API for Solo, or Payment Switch)
- Online payments (Card Widget and API-orchestrated checkout flow)

## Start Here

1. Classify the requested flow:
   - `terminal`: in-person card-present payment
   - `online`: e-commerce/web/app card-not-present payment
   - `hybrid`: both (for example, web checkout + in-store Solo)
2. Pick integration path:
   - `terminal/mobile`: iOS SDK or Android Reader SDK
   - `terminal/platform-agnostic`: Cloud API with Solo readers
   - `terminal/legacy-lightweight`: Payment Switch
   - `online/low-complexity`: Card Widget
   - `online/custom`: Checkouts API + 3DS + webhooks
3. Confirm credentials and environment:
   - API key or OAuth access token
   - Affiliate Key for card-present flows
   - Merchant code and currency alignment
   - Test account for non-production testing
4. Apply the implementation pattern from `references/checkout-playbook.md`.
5. Load references from `references/README.md` and select the matching entrypoint:
   - Server SDKs: `references/nodejs/README.md`, `references/go/README.md`, `references/python/README.md`, `references/java/README.md`, `references/php/README.md`, `references/rust/README.md`, `references/dotnet/README.md`
   - Terminal paths: `references/android-reader-sdk/README.md`, `references/ios-terminal-sdk/README.md`, `references/android-tap-to-pay-sdk/README.md`, `references/cloud-api/README.md`, `references/payment-switch/README.md`
   - Online paths: `references/checkout-widget/README.md`, `references/swift-checkout-sdk/README.md`, `references/react-native-sdk/README.md`, `references/checkouts-api/README.md`, `references/apm/README.md`, `references/webhooks-3ds/README.md`

## Required Rules

- Keep secret API keys and OAuth client secrets server-side only.
- Create online checkouts server-to-server.
- Prefer Card Widget and SDK-provided checkout experiences to avoid handling raw card details.
- For card-present integrations, include the Affiliate Key and ensure app identifiers match the key setup.
- Use unique transaction references (`checkout_reference`, `foreignTransactionId`, or equivalent) to prevent duplicates and improve reconciliation.
- Treat webhook events as notifications only; verify state through API reads.

## Implementation Workflow

1. Set up auth and merchant context.
2. Create checkout request with unique reference and correct currency.
3. Complete checkout via chosen channel:
   - terminal SDK checkout call
   - Cloud API reader checkout
   - Card Widget
   - direct checkout processing flow
4. Handle async outcomes:
   - SDK callback / activity result / event stream
   - 3DS `next_step` redirect flow
   - webhook delivery + API verification
5. Return normalized result (status, transaction identifiers, retry guidance).

## Validation Checklist

- Test and capture both successful payment and deliberate failure case (`amount = 11` in test mode).
- Verify behavior for duplicate transaction references.
- Verify timeout/session expiry behavior in the selected checkout path.
- Verify webhook retries and idempotent processing.
- Verify reconciliation fields are stored (checkout id, transaction id/code, merchant code, reference).

## References

- Use `references/checkout-playbook.md` for concrete flow-by-flow guidance and endpoint mapping.
- Use `references/README.md` as the main index for all SDK and integration-path entrypoints.
