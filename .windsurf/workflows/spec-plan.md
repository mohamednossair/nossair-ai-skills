---
description: Generate technical plan and atomic tasks
---

**Usage**: `/spec-plan task="Describe the feature"`

1. Read `.spec/constitution.md` and `.spec/spec.md`.
2. Generate or update `plan.md` (Architecture, Data Model, Steps - max 40 lines).
3. Break into atomic task files in `.spec/tasks/` (max 20 lines each).
4. Each task: Context, Deliverables, Constraints - self-contained for one AI prompt.
5. Validate every spec requirement is covered by at least one task.
6. Output a coverage matrix: requirement -> task mapping.
