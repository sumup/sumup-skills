# Android Tap-to-Pay SDK (Card-present on phone)

> Prefer the latest SumUp docs first: `https://developer.sumup.com/terminal-payments/sdks/android-ttp/index.md`
> LLM entrypoint for discovery: `https://developer.sumup.com/llms.txt`

## Initialize once

```kotlin
val tapToPay = TapToPayApiProvider.provide(applicationContext)
val initResult = tapToPay.init(authTokenProvider)
```

## Start payment

```kotlin
tapToPay.startPayment(
  checkoutData = CheckoutData(
    totalAmount = 1234,
    tipsAmount = null,
    vatAmount = null,
    clientUniqueTransactionId = UUID.randomUUID().toString(),
    customItems = null,
    priceItems = null,
    products = null,
    processCardAs = null,
    affiliateData = null,
  ),
  skipSuccessScreen = false
)
```

## Tear down

```kotlin
tapToPay.tearDown()
```
