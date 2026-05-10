---
description: Generate dependency-ordered tasks grouped by user story
---

**Usage**: `/speckit.tasks [plan="path/to/plan.md"]`

1. **Prerequisite check** — Run `scripts/powershell/check-prerequisites.ps1 -Json` (Windows) or `scripts/bash/check-prerequisites.sh --json` (Linux/macOS). If `plan` is not provided, use `IMPL_PLAN_PATH` from the script output. If the plan does not exist, ask the user for the path.
2. Locate the active feature via `.specify/feature.json` or the provided plan path.
3. Load `plan.md` (tech stack, structure) and `spec.md` (user stories with priorities P1, P2, P3...).
4. Organize tasks by user story — each story becomes its own phase. Map models, services, and interfaces to the story that needs them.
5. Use the strict checklist format for every task:
   ```
   - [ ] T001 [P] [US1] Description with exact file path
   ```
   - `T###` — sequential task ID
   - `[P]` — include ONLY if the task can run in parallel (different files, no incomplete dependencies)
   - `[US#]` — required for user-story phases (omit for Setup, Foundational, and Polish)
6. Phase 1: Setup (project initialization). Phase 2: Foundational (blocking prerequisites). Phase 3+: One phase per user story in priority order. Final phase: Polish & cross-cutting concerns.
7. Include acceptance criteria and Definition of Done (tests/docs/review) for each.
8. Add rough estimate (S/M/L) and risk flag where applicable.
9. Keep tasks concise; avoid repeating spec/plan text.

Follow-ups:
- Generate tests with `/test-generate` after tasks with testing DoD are identified.
- Use tech reviewers: `/java-review`, `/ts-review`, `/sql-review` for risky or core tasks.
