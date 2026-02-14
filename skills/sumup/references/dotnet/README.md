# .NET SDK

Use NuGet package `SumUp`.

## Online: create checkout

```csharp
var checkout = await client.Checkouts.CreateAsync(new CheckoutCreateRequest
{
    MerchantCode = merchantCode,
    Amount = 15.0f,
    Currency = Currency.Eur,
    CheckoutReference = "order-1001",
});
```

## Card-present: Cloud API checkout

```csharp
var readerCheckout = await client.Readers.CreateCheckoutAsync(
    merchantCode,
    readerId,
    new CreateReaderCheckoutRequest
    {
        TotalAmount = new CreateReaderCheckoutRequestTotalAmount
        {
            Currency = "EUR",
            MinorUnit = 2,
            Value = 1500,
        },
    });
```
