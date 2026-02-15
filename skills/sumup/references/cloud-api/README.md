# Cloud API (Terminal / Solo)

> Prefer the latest SumUp docs first: `https://developer.sumup.com/terminal-payments/cloud-api/index.md`
> LLM entrypoint for discovery: `https://developer.sumup.com/llms.txt`

## Pair reader (high-level)

1. Generate pairing code on logged-out Solo (`Connections -> API -> Connect`).
2. Call Readers create endpoint with pairing code.
3. Store returned `reader_id`.

## Start checkout on reader

```bash
curl -X POST \
  https://api.sumup.com/v0.1/merchants/$SUMUP_MERCHANT_CODE/readers/$READER_ID/checkout \
  -H "Authorization: Bearer $SUMUP_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{
    "total_amount": { "currency": "EUR", "minor_unit": 2, "value": 1500 }
  }'
```

## Terminate checkout

```bash
curl -X POST \
  https://api.sumup.com/v0.1/merchants/$SUMUP_MERCHANT_CODE/readers/$READER_ID/terminate \
  -H "Authorization: Bearer $SUMUP_API_KEY"
```

Use webhook/API status checks for final transaction state.
