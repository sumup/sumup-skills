# Checkout Widget (Online)

> Prefer the latest SumUp docs first: `https://developer.sumup.com/online-payments/checkouts/card-widget/index.md`
> LLM entrypoint for discovery: `https://developer.sumup.com/llms.txt`

## Server: create checkout (via server SDK)

Pick the server SDK for your backend language and create the checkout there:

- Node.js: `references/nodejs/README.md`
- Go: `references/go/README.md`
- Python: `references/python/README.md`
- Java: `references/java/README.md`
- PHP: `references/php/README.md`
- Rust: `references/rust/README.md`
- .NET: `references/dotnet/README.md`

Use cURL only for quick manual testing.

### cURL example (testing only)

```bash
curl -X POST https://api.sumup.com/v0.1/checkouts \
  -H "Authorization: Bearer $SUMUP_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "merchant_code": "MCXXXXXX",
    "amount": 15.0,
    "currency": "EUR",
    "checkout_reference": "order-1001"
  }'
```

## Client: mount widget

```html
<div id="sumup-card"></div>
<script src="https://gateway.sumup.com/gateway/ecom/card/v2/sdk.js"></script>
<script>
  SumUpCard.mount({
    id: "sumup-card",
    checkoutId: "<CHECKOUT_ID>",
    onResponse: function(type, body) {
      console.log(type, body);
    },
  });
</script>
```

Always verify checkout status on backend after client callbacks.
