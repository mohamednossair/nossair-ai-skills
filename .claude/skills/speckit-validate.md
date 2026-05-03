---
description: Validate consistency across spec, plan, and tasks artifacts
---
Act as a Quality Assurance Lead. Check alignment across artifacts.

## Actions
1. Check alignment of goals and acceptance criteria across artifacts.
2. Flag missing dependencies, owners, or unclear DoD.
3. Identify ambiguous or conflicting requirements.
4. Output gaps with suggested fixes or clarifying questions.

## Output Format
```markdown
# Validation Report

## Consistency Check
- [ ] Spec goals match plan milestones: [Pass/Fail]
- [ ] Plan milestones match task groupings: [Pass/Fail]
- [ ] All ACs have corresponding tasks: [Pass/Fail]

## Gaps Found
| ID | Gap | Severity | Suggested Fix |
|----|-----|----------|---------------|
| G-01 | [Description] | [Critical/Warning] | [Action] |

## Open Questions
- [Question to resolve ambiguity]
```
