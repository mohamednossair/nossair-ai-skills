---
description: Feature specification, planning, tasks, validation, and clarification utilities
---

**Usage**: Use Speckit commands for structured feature development.

## Available Commands
- `/speckit.specify`: Create or update a concise feature spec.
- `/speckit.plan`: Turn the spec into an outcome-oriented implementation plan.
- `/speckit.tasks`: Generate dependency-ordered tasks grouped by milestones.
- `/speckit.validate`: Check consistency across spec, plan, and tasks.
- `/speckit.clarify`: Ask targeted questions to resolve ambiguities.
- `/speckit.checklist`: Produce a short, verifiable review checklist.
- `/speckit.analyze`: Automated cross-artifact analysis and gap detection.
- `/speckit.implement`: Produce a dependency-ordered execution runbook.
- `/speckit.test-generate`: Generate spec-linked unit tests.
- `/speckit.document-generate`: Reverse-engineer BA docs from codebase.
- `/speckit.constitution`: Create cross-repository constitution.

## Minimal Workflow
1. `/speckit.specify feature="..."` — Draft the spec
2. `/speckit.clarify context="..."` — Resolve ambiguities
3. `/speckit.plan spec="..."` — Create plan
4. `/speckit.tasks plan="..."` — Generate tasks
5. `/speckit.validate spec="..." plan="..." tasks="..."` — Validate
6. `/speckit.implement tasks="..."` — Create runbook
7. `/test-generate` and `/review` — Tests and reviews

## Checklist
- [ ] Goals, non-goals, users, constraints captured
- [ ] Acceptance criteria are concrete and testable
- [ ] Milestones are outcome-oriented (2–5)
- [ ] Tasks are dependency-ordered with clear DoD
- [ ] Gaps and ambiguities are called out
