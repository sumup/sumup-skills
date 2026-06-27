# SumUp Upgrades

Use this workflow for SumUp API, SDK, and endpoint migrations.

- Inventory all services, apps, SDK versions, endpoint versions, credentials, and webhook handlers touched by the upgrade.
- Read the latest migration notes or SDK release notes before changing code.
- Identify breaking changes in request/response fields, auth scopes, webhook payloads, retries, idempotency, and mobile runtime requirements.
- Roll out behind feature flags or controlled deployment steps where possible.
- Keep a rollback path until payment success, failure, webhook, and reconciliation metrics are stable.
- Update tests and run sandbox verification before production rollout.
