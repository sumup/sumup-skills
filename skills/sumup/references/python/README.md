# Python SDK

Use `sumup-py`.

## Online: create checkout

```python
checkout = client.checkouts.create(
    CreateCheckoutBody(
        merchant_code=os.environ["SUMUP_MERCHANT_CODE"],
        amount=15.00,
        currency="EUR",
        checkout_reference="order-1001",
    )
)
```

## Card-present: Cloud API

```python
await client.readers.create_checkout(
    merchant_code,
    reader_id,
    CreateReaderCheckoutBody(total_amount=CreateReaderCheckoutBodyTotalAmount(currency="EUR", minor_unit=2, value=1500)),
)
```
