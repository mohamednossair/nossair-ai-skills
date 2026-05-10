---
description: Convert the feature spec into a concrete implementation plan
---

**Usage**: `/speckit.plan spec="path/to/spec.md"`

1. Locate the active feature via `.specify/feature.json` or the provided spec path.
2. Read `/memory/constitution.md` and cross-check against the spec — flag MUST-principle violations before planning.
3. Identify milestones (2–5), each outcome-oriented.
4. For each milestone, list key deliverables and risks.
5. Define dependencies and owners if known.
6. Phase 0 — Generate `research.md` to resolve any `[NEEDS CLARIFICATION]` markers.
7. Phase 1 — Generate `data-model.md`, `contracts/` (API/interface specs), and `quickstart.md`.
8. Keep steps lean; avoid micro-tasks.
