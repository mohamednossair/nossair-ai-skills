---
description: Read-only cross-artifact consistency and quality analysis
---

**Usage**: `/speckit.analyze spec="..." plan="..." tasks="..."`

1. **STRICTLY READ-ONLY** — Do not modify any files. Output a structured Markdown report only.
2. Build a traceability matrix: Spec ACs → Plan milestones → Tasks.
3. Validate NFR coverage (security, performance, availability, privacy) across plan/tasks.
4. **Constitution alignment** — Load `/memory/constitution.md` and flag MUST-principle violations as **CRITICAL**.
5. Detect gaps: missing owners/estimates/DoD, orphan ACs/tasks, circular deps, unclear risks.
6. Flag hotspots: high-risk tasks without tests, critical-path risks, ambiguous glossary/IDs.
7. **Severity assignment** — Classify each finding:
   - **CRITICAL**: Constitution MUST violation, missing core artifact, or zero-coverage requirement blocking baseline functionality.
   - **HIGH**: Duplicate/conflicting requirement, ambiguous security/performance attribute, untestable acceptance criterion.
   - **MEDIUM**: Terminology drift, missing non-functional task coverage, underspecified edge case.
   - **LOW**: Style/wording improvements, minor redundancy.
8. Output a concise report (max 50 findings; summarize overflow) with prioritized fixes and suggested follow-ups (`/speckit.clarify`, `/speckit.plan`, `/speckit.tasks`).
9. Optionally generate a review checklist with `/speckit.checklist` for critical areas.
