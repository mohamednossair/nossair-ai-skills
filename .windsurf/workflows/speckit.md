---
description: Feature specification, planning, tasks, validation, and clarification utilities
---

**Usage**: Use Speckit commands for structured feature development.

## Available Commands
- `/speckit.specify`: Create or update a concise feature spec. Generates a short name, persists to `.specify/feature.json`, and produces a spec-quality checklist.
- `/speckit.clarify`: Ask up to 5 targeted questions to resolve ambiguities and encode answers back into the spec.
- `/speckit.plan`: Turn the spec into an outcome-oriented implementation plan. Loads `.specify/feature.json` and cross-checks the constitution.
- `/speckit.tasks`: Generate dependency-ordered tasks grouped by user story (P1, P2...). Supports parallel markers `[P]` and reads `.specify/feature.json`.
- `/speckit.validate`: Check consistency across spec, plan, and tasks artifacts.
- `/speckit.checklist`: Generate domain-specific requirement-quality checklists (unit tests for English) under `checklists/`.
- `/speckit.analyze`: Read-only cross-artifact analysis with severity assignment (CRITICAL / HIGH / MEDIUM / LOW) and constitution alignment checks.
- `/speckit.implement`: Execute the implementation plan with constitution governance, checklist gating, and project-setup verification.
- `/speckit.taskstoissues`: Convert tasks into actionable GitHub issues (requires a GitHub remote).
- `/speckit.test-generate`: Generate spec-linked unit tests.
- `/speckit.document-generate`: Reverse-engineer BA docs from codebase.
- `/speckit.constitution`: Create cross-repository constitution.

## Minimal Workflow
1. `/speckit.specify feature="..."` — Draft the spec
2. `/speckit.clarify context="..."` — Resolve ambiguities
3. `/speckit.plan spec="..."` — Create plan
4. `/speckit.tasks plan="..."` — Generate tasks
5. `/speckit.validate spec="..." plan="..." tasks="..."` — Validate
6. `/speckit.implement tasks="..."` — Execute implementation
7. `/test-generate` and `/review` — Tests and reviews

## Checklist
- [ ] Goals, non-goals, users, constraints captured
- [ ] Acceptance criteria are concrete and testable
- [ ] Milestones are outcome-oriented (2–5)
- [ ] Tasks are dependency-ordered with clear DoD
- [ ] Gaps and ambiguities are called out
