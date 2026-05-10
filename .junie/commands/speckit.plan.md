---
description: Turn the spec into an outcome-oriented implementation plan
---

**Usage**: `/speckit.plan [spec="path/to/spec.md"]`

1. **Prerequisite check** — Run `scripts/powershell/check-prerequisites.ps1 -Json` (Windows) or `scripts/bash/check-prerequisites.sh --json` (Linux/macOS). If `spec` is not provided, use `FEATURE_SPEC_PATH` from the script output. If the spec does not exist, ask the user for the path.
2. Locate the active feature via `.specify/feature.json` or the provided spec path.
3. Read `/memory/constitution.md` and cross-check against the spec — flag MUST-principle violations before planning.
4. Identify milestones (2–5), each outcome-oriented with a clear Definition of Done (DoD).
5. For each milestone, list key deliverables, primary risks, and validation method (demo, test, doc).
6. Map dependencies between milestones and on external teams/services; note critical path.
7. Assign tentative owners/skills needed (e.g., backend, frontend, DBA) if known.
8. Phase 0 — Generate `research.md` to resolve any `[NEEDS CLARIFICATION]` markers.
9. Phase 1 — Generate `data-model.md`, `contracts/` (API/interface specs), and `quickstart.md`.
10. Keep steps lean; avoid micro-tasks.

Follow-ups:
- Run `/speckit.tasks` to expand milestones into dependency-ordered tasks.
- Trigger repo review early with `/git-review` to align on branch/commit strategy.
