---
description: Execute the implementation plan with governance, gating, and setup verification
---

**Usage**: `/speckit.implement tasks="path/to/tasks.md"`

1. **Checklist gate** — Scan `checklists/` under the feature directory. If any checklist has incomplete items, display a status table and ask whether to proceed before continuing.
2. **Load governance context** — Read `/memory/constitution.md` and enforce MUST principles during implementation.
3. **Project-setup verification** — Detect the tech stack from `plan.md` and create/verify ignore files (`.gitignore`, `.dockerignore`, `.eslintignore`, `.prettierignore`, etc.) with essential patterns for the detected technology.
4. **Parse tasks.md** — Extract phases (Setup, Tests, Core, Integration, Polish), task IDs, parallel markers `[P]`, and dependencies.
5. **Execute phase-by-phase**:
   - Respect dependencies: sequential tasks in order, parallel `[P]` tasks together.
   - Follow TDD: test tasks before their corresponding implementation tasks.
   - File-based coordination: tasks touching the same files must run sequentially.
   - Mark completed tasks as `[X]` in `tasks.md`.
6. For each task, propose: commit slices, test scaffolds (`/test-generate`), and review checkpoints (`/*-review`).
7. Track Definition of Done and link back to AC IDs for traceability.
8. **Extension hooks** — If `.specify/extensions.yml` exists, check `hooks.before_implement` and `hooks.after_implement` and execute registered hooks accordingly.
