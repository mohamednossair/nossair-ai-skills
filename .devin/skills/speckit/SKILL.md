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
| `/speckit-specify feature="..."` | Create/update the feature spec, create the feature branch, persist `.specify/feature.json` |
| `/speckit-clarify context="..."` | Ask up to 5 targeted questions; encode answers into the spec |
| `/speckit-plan spec="..."` | Turn the spec into milestones + research + data model + contracts |
| `/speckit-tasks plan="..."` | Generate dependency-ordered tasks (`T### [P] [US#]`) |
| `/speckit-validate spec="..." plan="..." tasks="..."` | Cross-artifact consistency and traceability |
| `/speckit-analyze spec="..." plan="..." tasks="..."` | Read-only analysis with severity assignment |
| `/speckit-checklist domain="..."` | Domain requirement-quality checklist under `checklists/` |
| `/speckit-implement tasks="..."` | Execute the plan: branch check, checklist gate, `[X]` tracking |
| `/speckit-taskstoissues tasks="..."` | Convert tasks into GitHub issues (GitHub remote required) |
| `/speckit-document-generate module="..."` | Generate the 11-file BA document set under `docs/ba/<module>/` |
| `/speckit-test-generate file="..."` | Spec-linked unit tests with AC traceability |

## What to Do

1. If the user's request clearly matches one subcommand (e.g., "create a spec for X" → specify), read and follow `.junie/commands/speckit.<name>.md` directly.
2. Otherwise, show the table above and ask the user which subcommand to run.
3. Every subcommand starts with the prerequisite checker:
   - Windows: `scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `scripts/bash/check-prerequisites.sh --json`

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
