---
description: Create or update a concise feature spec from a natural language description
---

**Usage**: `/speckit.specify feature="..."`

1. Generate a short feature name (2–4 words, action-noun format, e.g. `user-auth`).
2. Create the spec directory under `specs/` (e.g. `specs/NNN-short-name`) and persist the path to `.specify/feature.json` so downstream commands can locate it.
3. Extract goals, non-goals, users, and constraints.
4. Capture success metrics and non-functional requirements (security, performance, availability, privacy).
5. Define acceptance criteria as bullet points, each verifiable.
6. Outline domain glossary, data model (entities, fields, IDs), and external/internal interfaces.
7. Note open questions with `[NEEDS CLARIFICATION]` markers — max 3 total. Use only for decisions that significantly impact scope, security, or UX.
8. After writing the spec, run **spec-quality validation**: create `specs/<dir>/checklists/requirements.md` and check for testable criteria, measurable success metrics, and no implementation leaks. Iterate up to 3 times if items fail.
9. Risks and assumptions (top 3) with mitigation or validation notes.
10. Keep it brief; link to `.windsurf/memories/*` and team standards where relevant.

Follow-ups:
- Run `/speckit.clarify` to resolve open questions.
- Run `/speckit.plan` to convert this spec into milestones.
- Use tech reviews after drafting: `/java-review`, `/ts-review`, `/sql-review`, `/maven-help` as applicable.

Git Branching (before writing files):
- Prompt the user: *"Do you have a Jira / Bitbucket issue ID? (e.g., SE-123) Enter it, or press Enter to skip."*
- Pass the issue ID (if any) and the short feature name to the helper script:
  - Windows: `scripts/powershell/create-branch.ps1 -Prefix "feature/spec" -ShortName "<short-name>" [-IssueId "<id>"]`
  - Linux/macOS: `scripts/bash/create-branch.sh --prefix "feature/spec" --short-name "<short-name>" [--issue-id "<id>"]`
- If already on a non-protected branch, the script returns `created: false` and continues safely.
- For refinements to an existing spec, use prefix `chore/spec` instead.
- Ensure alignment with repo rules from `/.junie/skills/git/`.
