---
name: /speckit.plan
---

**Usage**: `/speckit.plan spec="path/to/spec.md"`

1. Identify milestones (2–5), each outcome-oriented with a clear Definition of Done (DoD).
2. For each milestone, list key deliverables, primary risks, and validation method (demo, test, doc).
3. Map dependencies between milestones and on external teams/services; note critical path.
4. Assign tentative owners/skills needed (e.g., backend, frontend, DBA) if known.
5. Keep steps lean; avoid micro-tasks.

Follow-ups:
- Run `/speckit.tasks` to expand milestones into dependency-ordered tasks.
- Trigger repo review early with `/git-review` to align on branch/commit strategy.
