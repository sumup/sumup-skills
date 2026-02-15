# Node.js SDK

> Prefer the latest SumUp docs first: `https://developer.sumup.com/online-payments/sdks/nodejs/index.md`
> LLM entrypoint for discovery: `https://developer.sumup.com/llms.txt`

Use `@sumup/sdk` for backend API calls.

## Online: create checkout

```ts
const checkout = await client.checkouts.create({
  merchant_code: process.env.SUMUP_MERCHANT_CODE!,
  amount: 15.0,
  currency: "EUR",
  checkout_reference: "order-1001",
  redirect_url: "https://example.com/checkout/return",
  return_url: "https://api.example.com/sumup/webhook",
});
```

## Card-present: Cloud API checkout on Solo

```ts
await client.readers.createCheckout(merchantCode, readerId, {
  total_amount: { currency: "EUR", minor_unit: 2, value: 1500 },
});
```
