---
description: Validate specification, plan, and task consistency using the canonical analysis contract
---

**Usage**: `/speckit.validate [spec="..."] [plan="..."] [tasks="..."] [current_state="..."]`

This command is a compatibility alias for `/speckit.analyze mode="pre"`. The analyzer's accepted mode enum is `pre | post-implementation`; this alias forwards `mode="pre"` — the analyzer's exact accepted value.

1. **Artifact resolution** — apply the shared resolution priority: explicit parameter → `.specify/feature.json` → prerequisite script (`.junie/scripts/powershell/check-prerequisites.ps1 -Json` / `.junie/scripts/bash/check-prerequisites.sh --json`) → repository discovery when exactly one candidate exists → structured missing-input error. Never guess when multiple candidates exist.
2. Forward all supplied artifact paths unchanged to `/speckit.analyze mode="pre"`; apply the shared resolution priority for omitted paths.
3. Do not implement separate validation logic; do not modify any files.
4. Return the same traceability matrix, findings, severities, semantic coverage statuses (`COMPLETE | PARTIAL | MISSING | CONFLICTING | UNVERIFIABLE`), and mutually exclusive verdict (`BLOCKED | PASS_WITH_WARNINGS | PASS`) as `/speckit.analyze`.
5. After analysis, recommend follow-ups by gap type: `/speckit.clarify` for ambiguous requirements; `/speckit.plan` for milestone or standards gaps; `/speckit.tasks` for task coverage or dependency gaps; and `/speckit.checklist` for targeted review areas when it exists — otherwise include the short checklist directly in the report.

## Delegation Failure

If `/speckit.analyze` cannot run:

- Preserve its structured error without rewriting it.
- Do not synthesize a validation verdict.
- Return BLOCKED when required input is unavailable.
- Report the unresolved artifact or failed prerequisite.
