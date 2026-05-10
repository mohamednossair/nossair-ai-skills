---
description: Create or update a concise feature spec from a natural language description
---

**Usage**: `/speckit.specify feature="..."`

1. Generate a short feature name (2–4 words, action-noun format, e.g. `user-auth`).
2. **Branch guard** — Before writing files, run the helper script:
   - Windows: `scripts/powershell/create-branch.ps1 -Prefix "feature/spec" -ShortName "<short-name>" [-IssueId "SE-123"]`
   - Linux/macOS: `scripts/bash/create-branch.sh --prefix "feature/spec" --short-name "<short-name>" [--issue-id "SE-123"]`
   - If already on a non-protected branch, the script returns `created: false` and continues safely.
   - For refinements to an existing spec, use prefix `chore/spec` instead.
3. Create the spec directory under `specs/` (e.g. `specs/NNN-short-name`) and persist the path to `.specify/feature.json` so downstream commands can locate it.
4. Extract goals, non-goals, users, and constraints.
5. Define acceptance criteria as bullet points.
6. Outline data model and interfaces at a high level.
7. Note open questions with `[NEEDS CLARIFICATION]` markers — max 3 total. Use only for decisions that significantly impact scope, security, or UX.
8. After writing the spec, run **spec-quality validation**: create `specs/<dir>/checklists/requirements.md` and check for testable criteria, measurable success metrics, and no implementation leaks. Iterate up to 3 times if items fail.
9. Keep it brief; link to `.windsurf/memories/*` if relevant.
