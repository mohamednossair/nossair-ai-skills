---
description: Convert the feature spec into a concrete implementation plan
---
Act as a Senior Software Architect. Convert the spec into milestones.

## Actions
1. **Prerequisite check** — Run `scripts/powershell/check-prerequisites.ps1 -Json` (Windows) or `scripts/bash/check-prerequisites.sh --json` (Linux/macOS). If no spec path is provided, use `FEATURE_SPEC_PATH` from the script output. If the spec does not exist, ask the user for the path.
2. Locate the active feature via `.specify/feature.json` or the provided spec path.
3. Read `/memory/constitution.md` and cross-check against the spec — flag MUST-principle violations before planning.
4. Identify milestones (2–5), each outcome-oriented.
5. For each milestone, list key deliverables and risks.
6. Define dependencies and owners if known.
7. Phase 0 — Generate `research.md` to resolve any `[NEEDS CLARIFICATION]` markers.
8. Phase 1 — Generate `data-model.md`, `contracts/` (API/interface specs), and `quickstart.md`.
9. Keep steps lean; avoid micro-tasks.

## Output Format
```markdown
# Implementation Plan

## Milestone 1: [Name]
- **Outcome**: [What is delivered]
- **Deliverables**: [List]
- **Dependencies**: [What must complete first]
- **Risks**: [If any]
- **Owner**: [If known]
```
