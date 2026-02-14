# Android Reader SDK (Card-present)

## Init + login

```java
SumUpState.init(this);
SumUpLogin login = SumUpLogin.builder("sup_afk_xxx").build();
SumUpAPI.openLoginActivity(this, login, 1);
```

## Optional pre-connection

```java
SumUpAPI.prepareForCheckout();
```

## Start checkout

```java
SumUpPayment payment = SumUpPayment.builder()
  .total(new BigDecimal("12.34"))
  .currency(SumUpPayment.Currency.EUR)
  .title("Coffee")
  .foreignTransactionId(UUID.randomUUID().toString())
  .build();
SumUpAPI.checkout(this, payment, 2);
```
