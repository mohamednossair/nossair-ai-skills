---
description: Automated cross-artifact analysis and gap detection
---
Act as a Technical Lead. Analyze artifacts for gaps and traceability.

## Actions
1. Build a traceability matrix: Spec ACs → Plan milestones → Tasks.
2. Validate NFR coverage (security, performance, availability, privacy) across plan/tasks.
3. Detect gaps: missing owners/estimates/DoD, orphan ACs/tasks, circular deps, unclear risks.
4. Flag hotspots: high-risk tasks without tests, critical-path risks, ambiguous glossary/IDs.
5. Output a concise report with prioritized fixes and suggested follow-ups.
6. Optionally generate a review checklist for critical areas.

## Output Format
```markdown
# Analysis Report

## Traceability Matrix
| AC | Milestone | Tasks | Coverage |
|----|-------------|-------|----------|
| AC-1 | M1 | T-01, T-02 | Full |

## NFR Coverage
| NFR | Status | Notes |
|-----|--------|-------|
| Security | [Covered/Partial/Missing] | |

## Gaps
| ID | Gap | Severity | Fix |
|----|-----|----------|-----|
| A-01 | [Description] | [Critical/Warning] | [Action] |

## Hotspots
- [High-risk area]: [Mitigation suggestion]

## Follow-ups
- `/speckit.clarify` for ambiguous requirements
- `/speckit.checklist` for critical areas
```
