---
description: Generate an actionable, dependency-ordered tasks.md based on the plan
---
Act as a Project Manager. Create actionable tasks from the plan.

## Actions
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
6. Include acceptance criteria and definition of done for each.
7. Keep tasks concise; avoid repeating spec/plan text.

## Output Format
```markdown
# Tasks

## Milestone 1

### T-01: [Task name]
- **Description**: [Brief description]
- **Acceptance Criteria**: [AC refs]
- **DoD**: [Definition of Done]
- **Depends on**: [Task IDs]
- **Owner**: [If known]
```
