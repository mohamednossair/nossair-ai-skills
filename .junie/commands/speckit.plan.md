---
description: Turn the spec into an outcome-oriented implementation plan
---

**Usage**: `/speckit.plan spec="path/to/spec.md"`

1. Locate the active feature via `.specify/feature.json` or the provided spec path.
2. Read `/memory/constitution.md` and cross-check against the spec — flag MUST-principle violations before planning.
3. Identify milestones (2–5), each outcome-oriented with a clear Definition of Done (DoD).
4. For each milestone, list key deliverables, primary risks, and validation method (demo, test, doc).
5. Map dependencies between milestones and on external teams/services; note critical path.
6. Assign tentative owners/skills needed (e.g., backend, frontend, DBA) if known.
7. Phase 0 — Generate `research.md` to resolve any `[NEEDS CLARIFICATION]` markers.
8. Phase 1 — Generate `data-model.md`, `contracts/` (API/interface specs), and `quickstart.md`.
9. Keep steps lean; avoid micro-tasks.

Follow-ups:
- Run `/speckit.tasks` to expand milestones into dependency-ordered tasks.
- Trigger repo review early with `/git-review` to align on branch/commit strategy.
