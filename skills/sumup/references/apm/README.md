# Alternative Payment Methods (Online)

APMs are surfaced primarily through checkout UIs (especially Card Widget).

## Available methods (market dependent)

Apple Pay, Google Pay, Bancontact, Blik, Boleto, EPS, iDeal, MyBank, PIX, Przelewy24, Satispay.

## Integration notes

- Enable APMs with SumUp onboarding/contact flow.
- Card Widget supports APM rendering and can filter methods via `onPaymentMethodsLoad`.
- Country/merchant setup determines method availability.
