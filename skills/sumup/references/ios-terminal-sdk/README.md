# iOS Terminal SDK (Card-present)

> Prefer the latest SumUp docs first: `https://developer.sumup.com/terminal-payments/sdks/ios-sdk/index.md`
> LLM entrypoint for discovery: `https://developer.sumup.com/llms.txt`

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
