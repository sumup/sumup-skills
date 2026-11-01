# Cursor Desktop Verification Checklist

Use this checklist to verify installation, all six skills, and the hosted MCP connection in Cursor Desktop.

## 1) Local prep

Run from repo root:

```bash
just sync-skills verify-agent-plugin verify-cursor-plugin
```

Confirm these files exist:

- `skills/sumup-best-practices/SKILL.md`
- `skills/sumup/SKILL.md`
- `skills/upgrade-sumup/SKILL.md`
- `skills/sumup-debug/SKILL.md`
- `skills/sumup-mcp/SKILL.md`
- `skills/sumup-testing/SKILL.md`
- `.cursor-plugin/plugin.json`
- `.cursor-plugin/marketplace.json`
- `plugin.json`
- `mcp.json`
- `.mcp.json`

## 2) Load in Cursor Desktop

1. In **Dashboard > Plugins & MCPs > Team Marketplaces**, select **Add Marketplace > Import from Repo** and enter `https://github.com/sumup/sumup-skills`.
2. Add and review the SumUp plugin, set marketplace access, and save.
3. In Cursor Desktop, open **Customize** in the sidebar, find SumUp, and select **Install** with project or user scope.
4. Start a new agent chat and complete SumUp OAuth authorization when prompted.

To test a branch, select it in the marketplace configuration. After pushing an update, click **Refresh** in the dashboard or use **Auto Refresh** for GitHub imports, then start a new agent. Record the Cursor version, source branch, and commit tested. See [Cursor's installation and update documentation](https://cursor.com/docs/plugins).

A standalone `npx skills add https://github.com/sumup/sumup-skills` installation checks skill routing only. Configure MCP separately for that path; it does not verify the packaged plugin.

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

`Checkout callback verification is failing intermittently. Help me debug this.`

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

### Narrow tasks and routing probes

Run these in fresh chats with the packaged skills enabled. These are manual behavior checks; schema validation does not establish skill selection or answer quality.

| Prompt | Expected behavior |
| --- | --- |
| `Which SumUp key goes in SumUpProvider?` | Answer directly: a public `sup_pk_` merchant key. Keep secret keys on the backend; no unrelated integration plan or full QA matrix. |
| `SumUp MCP tools are already connected. Show my merchant profile.` | Use the existing read-only tool. Do not reinstall the plugin, add another server, or create a checkout. |
| `Checkout creation timed out without returning an ID. Should I retry?` | Look up the original checkout reference and reconcile before another attempt. Distinguish uncertainty from a confirmed decline. |
| `Test my paired Solo without moving real funds.` | Verify the actual sandbox merchant and use reader/Virtual Solo scenarios. Do not substitute online card numbers for a physical reader card. |
| `Upgrade only @sumup/sdk to <target-version>; keep the reader SDK unchanged.` | Honor the supplied target and scope, verify release compatibility, and run checks relevant to that package. Replace the target placeholder before testing. |
| `Add wallet buttons to my website with Swift Checkout.` | Route to the browser JavaScript SDK and public merchant key, rather than native iOS setup. |
| `Configure SumUp MCP in Cursor; I installed only the sumup-mcp skill.` | Use the bundled client-setup reference without requiring another skill to be installed. |
| `Fix this CSS layout; it has no SumUp integration.` | Do not turn the task into a SumUp payment, security, migration, or test workflow. |

Record the selected skills, references read, result, and any unrelated actions or missing safeguards. Fix demonstrated routing or scope problems; do not grade solely by matching headings or wording.

## 5) MCP wiring verification

Run prompts such as:

- `Use the SumUp MCP tools to show my merchant profile.`

Expected:

- Agent recognizes MCP context and follows tool-based workflow.
- If auth is required, agent provides/initiates auth flow instead of generic-only guidance.
- The bundled server connects to `https://mcp.sumup.com/mcp` without a manually configured duplicate.

## 6) Manifest and docs sanity checks

Confirm the same release version is used in:

- `plugin.json`
- `.cursor-plugin/marketplace.json`
- `.claude-plugin/marketplace.json`
- `.cursor-plugin/plugin.json`
- `.claude-plugin/plugin.json`
- `.codex-plugin/plugin.json`
- `gemini-extension.json`

Run `just verify-agent-plugin` to check these versions and the referenced resources automatically.

Confirm root docs:

- `README.md` contains one row per skill (6 rows total).

## 7) Pass criteria

Verification is complete when all are true:

1. All six skills can be prompted and responses align with intended scope.
2. Scope boundaries hold (minimal cross-skill bleed).
3. MCP setup guidance is correct and actionable in Cursor.
4. Root plugin layout contains all new skills.
5. Manifests/docs reflect a consistent release version and multi-skill layout.
