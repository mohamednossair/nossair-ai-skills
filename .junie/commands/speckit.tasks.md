---
description: Generate dependency-ordered tasks grouped by user story
---

**Usage**: `/speckit.tasks plan="path/to/plan.md"`

1. Locate the active feature via `.specify/feature.json` or the provided plan path.
2. Load `plan.md` (tech stack, structure) and `spec.md` (user stories with priorities P1, P2, P3...).
3. Organize tasks by user story — each story becomes its own phase. Map models, services, and interfaces to the story that needs them.
4. Use the strict checklist format for every task:
   ```
   - [ ] T001 [P] [US1] Description with exact file path
   ```
   - `T###` — sequential task ID
   - `[P]` — include ONLY if the task can run in parallel (different files, no incomplete dependencies)
   - `[US#]` — required for user-story phases (omit for Setup, Foundational, and Polish)
5. Phase 1: Setup (project initialization). Phase 2: Foundational (blocking prerequisites). Phase 3+: One phase per user story in priority order. Final phase: Polish & cross-cutting concerns.
6. Include acceptance criteria and Definition of Done (tests/docs/review) for each.
7. Add rough estimate (S/M/L) and risk flag where applicable.
8. Keep tasks concise; avoid repeating spec/plan text.

Follow-ups:
- Generate tests with `/test-generate` after tasks with testing DoD are identified.
- Use tech reviewers: `/java-review`, `/ts-review`, `/sql-review` for risky or core tasks.
