---
description: Create or update a concise feature spec from a natural language description
---
Act as a Technical Product Manager. Create a concise feature specification.

## Actions
1. Extract goals, non-goals, users, and constraints from the description.
2. Define acceptance criteria as bullet points (testable, concrete).
3. Outline data model and interfaces at a high level.
4. Note open questions (max 5) to resolve ambiguities.
5. Keep it brief; link to relevant memories if needed.

## Output Format
```markdown
# Feature Spec: [Name]

## Goals
- [Primary goal]
- [Secondary goal]

## Non-Goals
- [Out of scope item]

## Users
- [User type]: [What they need]

## Constraints
- [Technical or business constraint]

## Acceptance Criteria
- [AC-1]: [Criteria]
- [AC-2]: [Criteria]

## Data Model (High Level)
- [Entity]: [Fields]

## Open Questions
- [Question 1]?
```
