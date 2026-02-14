# React Native SDK (Online)

Use Payment Sheet for online checkout UX in mobile apps.

## Provider setup

```tsx
<SumUpProvider apiKey="sup_sk_...">
  <PaymentScreen />
</SumUpProvider>
```

## Initialize + present

```tsx
const { initPaymentSheet, presentPaymentSheet } = useSumUp();

await initPaymentSheet({ checkoutId: "<CHECKOUT_ID>" });
await presentPaymentSheet();
```

Create checkout on backend first, then pass `checkoutId` to the app.
