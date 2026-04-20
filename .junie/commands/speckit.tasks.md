---
name: /speckit.tasks
---

**Usage**: `/speckit.tasks plan="path/to/plan.md"`

1. Create tasks grouped by milestone with stable IDs (e.g., M1-T1).
2. Order by dependencies; one owner per task if known.
3. Include acceptance criteria and Definition of Done (tests/docs/review) for each.
4. Add rough estimate (S/M/L) and risk flag where applicable.
5. Keep tasks concise; avoid repeating spec/plan text.

Follow-ups:
- Generate tests with `/test-generate` after tasks with testing DoD are identified.
- Use tech reviewers: `/java-review`, `/ts-review`, `/sql-review` for risky or core tasks.
