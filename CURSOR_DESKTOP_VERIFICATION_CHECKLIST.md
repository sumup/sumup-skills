# Cursor Desktop Verification Checklist

Use this checklist to verify the multi-skill marketplace refactor from the Cursor Desktop app.

## 1) Local prep

Run from repo root:

```bash
./scripts/sync-skills.sh
```

Confirm these files exist:

- `skills/sumup-best-practices/SKILL.md`
- `skills/upgrade-sumup/SKILL.md`
- `skills/sumup-debug/SKILL.md`
- `skills/sumup-mcp/SKILL.md`
- `skills/sumup-testing/SKILL.md`
- `.cursor-plugin/plugin.json`

## 2) Load in Cursor Desktop

Use one of the following:

- Add this repo as a local rules/skills source in Cursor.
- Or add remote source via **Settings -> Rules -> Add Rule -> Remote Rule (GitHub)** after pushing branch.

Then reload Cursor (or restart window) so skills are re-indexed.

## 3) Discoverability and routing checks

Open a new agent chat and run the prompts below.

### A. `sumup`

Prompt:

`Implement an end-to-end SumUp Card Widget checkout with webhook verification.`

Expected:

- Response is implementation-focused (API flow, frontend/backend/webhook sequence).

### B. `sumup-best-practices`

Prompt:

`Help me decide between Hosted Checkout, Card Widget, and Cloud API for my use case.`

Expected:

- Decision-tree/trade-off guidance and security posture recommendations.

### C. `upgrade-sumup`

Prompt:

`I need to upgrade @sumup/sdk and migrate off deprecated endpoints safely.`

Expected:

- Structured migration plan with pre-checks, breaking-change handling, validation, rollback.

### D. `sumup-debug`

Prompt:

`Webhook signature validation is failing intermittently. Help me debug this.`

Expected:

- Triage flow with hypotheses, evidence collection, deterministic fix and re-test steps.

### E. `sumup-mcp`

Prompt:

`Configure SumUp MCP in Cursor and give me a safe first verification prompt.`

Expected:

- MCP setup guidance for `https://mcp.sumup.com/mcp`, auth notes, and first safe task.

### F. `sumup-testing`

Prompt:

`Create a sandbox test plan with happy path and forced failure (amount = 11).`

Expected:

- QA matrix with success + failure + async/webhook checks and evidence requirements.

## 4) Scope-boundary regression checks

Validate scope separation with quick probes:

- Ask pure implementation question and confirm response does not pivot into upgrade/debug playbook.
- Ask pure debugging question and confirm response does not start with architecture decision-tree.
- Ask pure testing question and confirm it includes sandbox + forced-failure assertions.

If overlap is too high, tighten skill `description` frontmatter for the offending skill.

## 5) MCP wiring verification

Run prompts such as:

- `Use SumUp MCP to list available tools/actions.`
- `Use SumUp MCP with a read-only sandbox-safe first step.`

Expected:

- Agent recognizes MCP context and follows tool-based workflow.
- If auth is required, agent provides/initiates auth flow instead of generic-only guidance.

## 6) Manifest and docs sanity checks

Confirm the same release version is used in:

- `.cursor-plugin/marketplace.json`
- `.claude-plugin/marketplace.json`
- `.cursor-plugin/plugin.json`
- `.claude-plugin/plugin.json`
- `.codex-plugin/plugin.json`

Confirm root docs:

- `README.md` contains one row per skill (6 rows total).

## 7) Pass criteria

Verification is complete when all are true:

1. All six skills can be prompted and responses align with intended scope.
2. Scope boundaries hold (minimal cross-skill bleed).
3. MCP setup guidance is correct and actionable in Cursor.
4. Root plugin layout contains all new skills.
5. Manifests/docs reflect a consistent release version and multi-skill layout.
