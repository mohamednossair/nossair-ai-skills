---
name: speckit
description: Speckit toolkit orchestrator — lists all /speckit-* subcommands; each also has its own skill (/speckit-specify, /speckit-plan, /speckit-tasks, /speckit-implement, ...)
allowed-tools:
  - read
  - grep
  - glob
triggers:
  - user
  - model
---

You invoked the Speckit orchestrator without a specific subcommand.

## Available Subcommands (each has its own skill — type `/speckit-<name>`)

| Command | What it does |
|---------|--------------|
| `/speckit-specify feature="..." [mode="draft|feature|refine"]` | Create/update the feature spec (draft = no branch); persist `.specify/feature.json` |
| `/speckit-clarify context="..."` | Ask up to 5 targeted questions; encode answers into the spec |
| `/speckit-plan spec="..."` | Turn the spec into milestones + research + data model + contracts + machine-readable `## Standards` |
| `/speckit-tasks plan="..."` | Generate dependency-ordered tasks (`T### [P] [US#]` + `Depends on`/`Covers`/`Validate`); tests in the task graph |
| `/speckit-validate spec="..." plan="..." tasks="..."` | Cross-artifact consistency and traceability |
| `/speckit-analyze ... [current_state="..."] [mode="pre|post-implementation"]` | Read-only analysis with severities and a PASS / PASS_WITH_WARNINGS / BLOCKED verdict |
| `/speckit-checklist domain="..."` | Domain requirement-quality checklist under `checklists/` |
| `/speckit-implement tasks="..." [mode="plan|execute"]` | `plan` = dry-run runbook (default); `execute` = gated execution with `[X]` tracking |
| `/speckit-taskstoissues tasks="..."` | Convert tasks into GitHub issues (GitHub remote required) |
| `/speckit-document-generate module="..."` | Generate the lean 6-file AI BA set (`docs/ba/<module>/`) — AI index + facts JSON + code map + graphs |
| `/speckit-test-generate file="..."` | Spec-linked unit tests with AC traceability |

## What to Do

1. If the user's request clearly matches one subcommand (e.g., "create a spec for X" → specify), read and follow `.junie/commands/speckit.<name>.md` directly.
2. Otherwise, show the table above and ask the user which subcommand to run.
3. Every subcommand resolves artifacts via the shared Artifact Resolution Contract (see `.junie/skills/speckit/SKILL.md`): explicit parameter → `.specify/feature.json` → prerequisite checker (`scripts/powershell/check-prerequisites.ps1 -Json` / `scripts/bash/check-prerequisites.sh --json`) → single-candidate discovery → structured missing-input error. Never guess when multiple candidates exist.
4. If `graphify-out/graph.json` exists (see the `/graphify` skill), use `graphify query`/`path`/`explain` for codebase research during plan/tasks/implement instead of broad grep sweeps; build the graph BEFORE `/speckit-implement` (building writes `graphify-out/`, queries are read-only).

## Artifact Chain (cross-agent handoff)

```
.specify/feature.json ──► specs/NNN-<short-name>/
                            ├── spec.md        (specify)
                            ├── checklists/    (specify/checklist)
                            ├── research.md    (plan)
                            ├── data-model.md  (plan)
                            ├── contracts/     (plan)
                            ├── quickstart.md  (plan)
                            ├── plan.md        (plan, includes ## Standards)
                            └── tasks.md       (tasks; [X]-tracked by implement)
```

Artifacts are plain Markdown with exact file paths — any agent (Junie, AIR, Devin, or another tool) can continue the chain at any stage.
