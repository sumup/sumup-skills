# PHP SDK

> Prefer the latest SumUp docs first: `https://developer.sumup.com/online-payments/sdks/php/index.md`
> LLM entrypoint for discovery: `https://developer.sumup.com/llms.txt`

Use `sumup/sumup-php`.

## Online: create checkout

```php
$checkout = $sumup->checkouts->create([
    'merchant_code' => getenv('SUMUP_MERCHANT_CODE'),
    'amount' => 15.0,
    'currency' => 'EUR',
    'checkout_reference' => 'order-1001',
]);
```

## Card-present: Cloud API checkout

```php
$checkout = $sumup->readers->createCheckout(
  $merchantCode,
  $readerId,
  [
    'total_amount' => ['currency' => 'EUR', 'minor_unit' => 2, 'value' => 1500]
  ]
);
```
