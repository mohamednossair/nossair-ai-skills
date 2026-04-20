---
name: /speckit.specify
---

**Usage**: `/speckit.specify feature="..."`

1. Extract goals, non-goals, users, and constraints.
2. Capture success metrics and non-functional requirements (security, performance, availability, privacy).
3. Define acceptance criteria as bullet points, each verifiable.
4. Outline domain glossary, data model (entities, fields, IDs), and external/internal interfaces.
5. Note open questions (max 5) to resolve ambiguities.
6. Risks and assumptions (top 3) with mitigation or validation notes.
7. Keep it brief; link to `.windsurf/memories/*` and team standards where relevant.

Follow-ups:
- Run `/speckit.clarify` to resolve open questions.
- Run `/speckit.plan` to convert this spec into milestones.
- Use tech reviews after drafting: `/java-review`, `/ts-review`, `/sql-review`, `/maven-help` as applicable.

Git Branching (before writing files):
- Prompt for a branch name and create/switch to it. Recommend:
  - `feature/spec/<id>-<short-slug>` for new specs
  - `chore/spec/<id>-<short-slug>` for refinements
- If an ID exists (Jira/issue), include it. Otherwise, generate a short slug from the feature description.
- Examples: `feature/spec/SE-123-auth-refresh`, `feature/spec/auth-refresh`.
- Ensure alignment with repo rules from `/.junie/skills/git/`.
