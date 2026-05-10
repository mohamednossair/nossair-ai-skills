---
description: Validate consistency across spec, plan, and tasks artifacts
---
Act as a Quality Assurance Lead. Check alignment across artifacts.

## Actions
1. **Prerequisite check** — Run `scripts/powershell/check-prerequisites.ps1 -Json` (Windows) or `scripts/bash/check-prerequisites.sh --json` (Linux/macOS). Auto-populate any missing artifact paths from the script output (`FEATURE_SPEC_PATH`, `IMPL_PLAN_PATH`, `TASKS_PATH`). If an artifact does not exist, ask the user for the path.
2. Check alignment of goals and acceptance criteria across artifacts.
3. Flag missing dependencies, owners, or unclear DoD.
4. Identify ambiguous or conflicting requirements.
5. Output gaps with suggested fixes or clarifying questions.

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
