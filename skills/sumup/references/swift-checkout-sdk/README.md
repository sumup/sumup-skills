# Swift Checkout SDK (Online)

Use this integration path for fast online checkout experiences with Apple Pay/Google Pay support.

## Flow

1. Create checkout server-side via SumUp API.
2. Initialize Swift Checkout with returned checkout identifier.
3. Present checkout UI and handle completion callback.
4. Verify final checkout status server-side.

Also see `references/checkout-widget/README.md` and `references/webhooks-3ds/README.md`.
