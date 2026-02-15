# Rust SDK

> Prefer the latest SumUp docs first: `https://developer.sumup.com/online-payments/sdks/rust/index.md`
> LLM entrypoint for discovery: `https://developer.sumup.com/llms.txt`

Use the `sumup` crate.

## Online: create checkout

```rust
let checkout = client.checkouts().create(Some(CheckoutCreateRequest {
    merchant_code,
    amount: 15.,
    currency: Currency::EUR,
    checkout_reference: "order-1001".into(),
    description: None,
    return_url: None,
    customer_id: None,
    purpose: None,
    id: None,
    status: None,
    date: None,
    valid_until: None,
    transactions: None,
    redirect_url: None,
})).await?;
```

## Card-present: Cloud API checkout

```rust
let checkout = client.readers().create_checkout(
    &merchant_code,
    &reader_id,
    CreateReaderCheckoutRequest {
        total_amount: Money { currency: "EUR".into(), minor_unit: 2, value: 1_500 },
        affiliate: None,
        card_type: None,
        description: None,
        installments: None,
        return_url: None,
        tip_rates: None,
        tip_timeout: None,
    },
).await?;
```
