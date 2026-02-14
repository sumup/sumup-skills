# iOS Terminal SDK (Card-present)

## Setup

```swift
SumUpSDK.setup(withAPIKey: "sup_afk_xxx")
```

## Login + prepare

```swift
SumUpSDK.presentLogin(from: self, animated: true) { success, error in }
SumUpSDK.prepareForCheckout()
```

## Start checkout

```swift
let request = CheckoutRequest(
  total: NSDecimalNumber(string: "12.34"),
  title: "Coffee",
  currencyCode: merchantCurrencyCode
)
request.foreignTransactionID = UUID().uuidString
SumUpSDK.checkout(with: request, from: self) { result, error in }
```
