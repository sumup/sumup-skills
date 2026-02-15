# Checkouts API (Online)

> Prefer the latest SumUp docs first: `https://developer.sumup.com/online-payments/index.md`
> LLM entrypoint for discovery: `https://developer.sumup.com/llms.txt`

## Create checkout (server-to-server)

```bash
curl -X POST https://api.sumup.com/v0.1/checkouts \
  -H "Authorization: Bearer $SUMUP_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "merchant_code": "ME7RMQN3",
    "amount": 15.0,
    "currency": "EUR",
    "checkout_reference": "unique-checkout-ref-123"
  }'
```

## Use checkout ID in secure online flows

- Prefer `references/checkout-widget/README.md` for embedded payment UI.
- Use `references/webhooks-3ds/README.md` for async confirmation and 3DS handling patterns.
