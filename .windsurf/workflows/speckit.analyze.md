---
description: Automated cross-artifact analysis and gap detection
---

**Usage**: `/speckit.analyze spec="..." plan="..." tasks="..."`

1. Build a traceability matrix: Spec ACs → Plan milestones → Tasks.
2. Validate NFR coverage (security, performance, availability, privacy) across plan/tasks.
3. Detect gaps: missing owners/estimates/DoD, orphan ACs/tasks, circular deps, unclear risks.
4. Flag hotspots: high-risk tasks without tests, critical-path risks, ambiguous glossary/IDs.
5. Output a concise report with prioritized fixes and suggested follow-ups (`/speckit.clarify`, `/speckit.plan`, `/speckit.tasks`).
6. Optionally generate a review checklist with `/speckit.checklist` for critical areas.
