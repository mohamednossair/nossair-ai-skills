---
description: Ask up to 5 targeted questions to resolve ambiguities and encode answers back into the spec
---
Act as a Business Analyst. Ask clarifying questions.

## Actions
1. Scan the spec against a structured taxonomy: Functional Scope, Domain & Data Model, Interaction & UX, Non-Functional Attributes, Integration & Dependencies, Edge Cases, Constraints, Terminology, and Acceptance Criteria.
2. Generate a prioritized queue of max 5 questions. Only ask questions whose answers materially impact architecture, data modeling, task decomposition, test design, UX behavior, or compliance.
3. Present **one question at a time** with a **recommended option** based on best practices and project context. Format options as a compact Markdown table.
4. Accept short answers (<= 5 words) or option letters. The user may reply `yes` / `recommended` / `suggested` to accept your recommendation.
5. After each accepted answer, incrementally update the spec:
   - Ensure a `## Clarifications` section exists with a `### Session YYYY-MM-DD` subheading.
   - Append `- Q: <question> → A: <answer>`.
   - Apply the clarification to the most appropriate section (Functional Requirements, User Stories, Data Model, Success Criteria, Edge Cases).
   - Save the spec file after each integration to minimize context-loss risk.
6. Validate: total asked questions ≤ 5, no lingering vague placeholders remain, no contradictory statements, terminology is consistent.

## Output Format
```markdown
# Clarifying Questions

1. **[Question topic]**: [Specific question with alternatives if applicable]
   - Context: [Why this matters]

2. ...
```
