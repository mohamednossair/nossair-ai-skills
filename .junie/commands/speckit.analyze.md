---
name: /speckit.analyze
---

**Usage**: `/speckit.analyze spec="..." plan="..." tasks="..."`

1. Build a traceability matrix: Spec ACs → Plan milestones → Tasks.
2. Validate NFR coverage (security, performance, availability, privacy) across plan/tasks.
3. Detect gaps: missing owners/estimates/DoD, orphan ACs/tasks, circular deps, unclear risks.
4. Flag hotspots: high-risk tasks without tests, critical-path slippage risk, ambiguous glossary.
5. Produce a concise report with prioritized fixes and suggested follow-up commands (`/speckit.clarify`, `/speckit.plan`, `/speckit.tasks`).
6. Optionally generate a review checklist with `/speckit.checklist` for critical areas.
