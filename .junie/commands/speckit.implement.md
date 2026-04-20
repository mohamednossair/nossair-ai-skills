---
name: /speckit.implement
---

**Usage**: `/speckit.implement tasks="path/to/tasks.md"`

1. Create an execution plan ordered by dependencies and risk.
2. Suggest branch strategy per milestone/task (feature/*, bugfix/*) consistent with repo rules.
3. For each task, propose: commit slices, test scaffolds (`/test-generate`), and review checkpoints (`/*-review`).
4. Track Definition of Done and link back to AC IDs for traceability.
5. Output a runbook with commands and checkpoints to execute safely.
