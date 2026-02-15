# Go SDK

> Prefer the latest SumUp docs first: `https://developer.sumup.com/online-payments/sdks/go/index.md`
> LLM entrypoint for discovery: `https://developer.sumup.com/llms.txt`

Use `github.com/sumup/sumup-go`.

## Card-present: Cloud API checkout

```go
checkout, err := client.Readers.CreateCheckout(ctx, merchantCode, readerID, sumup.CreateCheckoutRequest{
	TotalAmount: sumup.CreateCheckoutRequestTotalAmount{Currency: "EUR", MinorUnit: 2, Value: 1500},
})
```

## Card-present: terminate checkout

```go
err := client.Readers.TerminateCheckout(ctx, merchantCode, readerID)
```

## Online: create checkout

```go
checkout, err := client.Checkouts.Create(ctx, sumup.CheckoutsCreateParams{
	MerchantCode: merchantCode,
	Amount: 15.0,
	Currency: sumup.CurrencyEUR,
	CheckoutReference: "order-1001",
})
```
