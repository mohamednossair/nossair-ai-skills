---
name: speckit
description: Cross-agent feature specification, planning, and validation toolkit (spec → plan → tasks → validate → implement)
---

# Speckit Skill

Use this skill to create concise specs, convert them into actionable plans and tasks, and validate consistency across artifacts.

## When to Use
- Starting a new feature that needs a spec, plan, and task breakdown.
- When the user invokes any `/speckit.*` command.
- When cross-checking spec, plan, and tasks for consistency or traceability.
- When generating a Business Analysis document set from an existing codebase.

## Capabilities

`/speckit.specify` · `/speckit.clarify` · `/speckit.plan` · `/speckit.tasks` · `/speckit.analyze` · `/speckit.checklist` · `/speckit.implement` · `/speckit.taskstoissues` · `/speckit.document-generate` · `/speckit.test-generate` — each command's `.junie/commands/speckit.<name>.md` file is the source of truth; see the Minimal Workflow below for the chain.

## Artifact Resolution Contract (shared by all /speckit.* commands)

Resolve every artifact path (spec, plan, tasks, feature dir, current-state BA facts) using this priority — never guess:

1. Explicit command parameter (e.g. `spec="..."`).
2. `.specify/feature.json` (registered active feature).
3. Prerequisite script output (`.junie/scripts/powershell/check-prerequisites.ps1 -Json` / `.junie/scripts/bash/check-prerequisites.sh --json`).
4. Repository discovery — ONLY when exactly one candidate exists.
5. Structured missing-input error — stop and ask the user.

Missing-input error format:
```
MISSING_INPUT: <artifact> — <why it is needed>
Candidates found: <list, or none>
Fix: provide <param>="..." or run /speckit.specify first
```

When multiple candidates exist without an explicit parameter, list them and ask the user to choose — do not pick one silently.

## Stable ID Conventions

| ID | Meaning | Assigned in |
|----|---------|-------------|
| `AC-###` | Acceptance criterion (ID + statement + validation + priority + source) | specify |
| `NFR-SEC-###` / `NFR-PERF-###` / `NFR-AVL-###` / `NFR-PRV-###` / `NFR-OPS-###` | Non-functional requirement (security/performance/availability/privacy/operations) | specify |
| `BR-###` | Business rule (from the BA fact base) | document-generate |
| `TR-###` | Approved technical requirement (migration, compatibility, etc.) | plan / tasks |
| `US#` | User story with priority P1/P2/P3 | specify |
| `M#` | Plan milestone | plan |
| `T###` | Task (sequential, checklist-compatible) | tasks |
| `CHK###` | Checklist item | checklist |

IDs are stable once assigned — never renumber; deprecated items are marked, not deleted. Requirement sources are classified as: `user-requested | existing-system | business-policy | regulatory | technical-constraint | assumption`.

## Validation Evidence Contract (shared by tasks / implement / analyze)

Behavior-changing tasks declare an expectation; execution and analysis record the observation:

- Declaration (assigned in `/speckit.tasks`): `Expected result` — PASS or FAIL (default PASS; FAIL only for intentional red tests); when FAIL, `Expected failing test` and `Expected reason` are required.
- Observation (recorded by `/speckit.implement`, verified by `/speckit.analyze`): `Observed result` — PASS or FAIL; `Observed failing test` and `Observed reason` when applicable; `Matched expectation` — Yes or No. All observation fields belong in the task's `Evidence`.
- A nonzero exit code is a validation failure only when the expectation is PASS (or undeclared). An intentional red test completes successfully when the observed failing test and reason match the declaration (`Matched expectation: Yes`).

## Usage Patterns
- Keep artifacts brief and outcome-focused.
- Prefer bullet points over paragraphs.
- Capture open questions and assumptions explicitly.
- Follow the technology standards in `.junie/guidelines.md` when planning implementation details.

## Integration Map
- Requirements to Reviews: After `/speckit.specify`, run tech reviews where relevant — but standards are RESOLVED in the plan's `## Standards` section, not guessed per command:
  - `java` + `spring-boot` skills for JVM services
  - `typescript` + `angular` skills for frontend
  - `oracle` / `mysql` skills for data work
  - `security` skill when the feature touches auth, user input, or secrets
  - `performance` skill for hot paths, list endpoints, and data loading
  - `accessibility` skill for user-facing UI
  - `git` skill to validate branch and commit strategy
- Tests in the task graph: `/speckit.tasks` creates test tasks BEFORE their implementation tasks; `/speckit.test-generate` (canonical, spec/task-linked; `/test-generate` is its thin unlinked wrapper) assists writing test code during implementation — it is not a post-hoc step.
- Codebase Knowledge Graph: when `graphify-out/graph.json` exists (see the `graphify` skill), use `graphify query`/`path`/`explain` for research (plan), impact analysis and `[P]` conflict checks (tasks), and dependency checks (implement) instead of broad grep sweeps. Build the graph BEFORE `/speckit.implement` — building writes `graphify-out/`, queries are read-only.
- Validation Loop: run `/speckit.analyze` after any major spec/plan/tasks update; run `/speckit.clarify` to resolve flagged ambiguities.

## Minimal Workflow
0. BA Doc (optional, existing apps): `/speckit.document-generate module="..."` — create a business analysis doc before drafting a tech spec.
1. Draft: `/speckit.specify feature="..." mode="draft"` (no branch; `mode="feature"` creates `feature/spec/<id>-<slug>` via the create-branch helper) → `specs/NNN-short-name/` + `.specify/feature.json`
2. Clarify: `/speckit.clarify spec="..."` (preview first, then `apply="apply"`; ends with COMPLETE / PARTIAL / BLOCKED)
3. Plan: `/speckit.plan spec="..."` (plan.md includes a machine-readable `## Standards` section listing the skills any implementing agent must load)
4. Tasks: `/speckit.tasks plan="..."` (test tasks precede implementation tasks; every task maps to AC/NFR IDs)
5. Analyze: `/speckit.analyze` — resolve CRITICAL and HIGH findings before implementing
6. Implement: `/speckit.implement tasks="..." mode="plan"` (dry-run runbook), then `mode="execute"` (verifies branch, loads the plan's Standards, runs each task's `Validate` command, marks tasks `[X]`)
7. Post-implementation: `/speckit.analyze mode="post-implementation"`, then `/speckit.test-generate`, `/review`, and `/review-pr` before merging

## Cross-Agent Handoff
Artifacts are plain Markdown with exact file paths, tracked in `.specify/feature.json` — any agent can continue the chain:
- Plan with one tool (e.g., Junie), implement with another (e.g., Devin or AIR): the implementing agent reads `.specify/feature.json`, the feature's `plan.md` `## Standards` section, and the listed `.junie/skills/` files.
- Devin: invoke `/speckit <command>` — it maps to the same `.junie/commands/speckit.*.md` definitions.
- AIR: `.aiassistant/rules/project-rules.md` documents the same mapping.
- GitHub integration: `/speckit.taskstoissues` converts tasks.md into GitHub issues (requires a GitHub remote and `gh` CLI or the GitHub MCP tool).

## Checklist
- [ ] Goals, non-goals, users, constraints captured
- [ ] Acceptance criteria carry stable AC-### IDs with validation, priority, and source
- [ ] NFRs carry stable NFR-### IDs and are measurable
- [ ] Milestones are outcome-oriented (2–5)
- [ ] Tasks are dependency-ordered with `Depends on`, `Covers`, and `Validate` fields
- [ ] Test tasks precede their implementation tasks
- [ ] Gaps and ambiguities are called out with next steps
