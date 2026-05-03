---
description: Generate an actionable, dependency-ordered tasks.md based on the plan
---
Act as a Project Manager. Create actionable tasks from the plan.

## Actions
1. Create tasks grouped by milestone with IDs (e.g., T-01, T-02).
2. Order by dependencies; one owner per task if known.
3. Include acceptance criteria and definition of done for each.
4. Keep tasks concise; avoid repeating spec/plan text.

## Output Format
```markdown
# Tasks

## Milestone 1

### T-01: [Task name]
- **Description**: [Brief description]
- **Acceptance Criteria**: [AC refs]
- **DoD**: [Definition of Done]
- **Depends on**: [Task IDs]
- **Owner**: [If known]
```
