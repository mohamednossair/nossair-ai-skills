---
name: /speckit.validate
---

**Usage**: `/speckit.validate spec="..." plan="..." tasks="..."`

1. Check alignment of goals and acceptance criteria across artifacts; ensure each acceptance criterion traces to a milestone and tasks.
2. Verify non-functional requirements (security, performance, availability, privacy) have corresponding plan/tasks.
3. Flag missing dependencies, owners, estimates, or unclear DoD.
4. Identify ambiguous or conflicting requirements and surface assumptions.
5. Output gaps with suggested fixes or clarifying questions; consider running `/speckit.clarify`.
6. Generate a short review guide with `/speckit.checklist` for critical areas.
