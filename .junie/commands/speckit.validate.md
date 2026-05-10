---
description: Check consistency across spec, plan, and tasks
---

**Usage**: `/speckit.validate [spec="..."] [plan="..."] [tasks="..."]`

1. **Prerequisite check** — Run `scripts/powershell/check-prerequisites.ps1 -Json` (Windows) or `scripts/bash/check-prerequisites.sh --json` (Linux/macOS). Auto-populate any missing artifact paths from the script output (`FEATURE_SPEC_PATH`, `IMPL_PLAN_PATH`, `TASKS_PATH`). If an artifact does not exist, ask the user for the path.
2. Check alignment of goals and acceptance criteria across artifacts; ensure each acceptance criterion traces to a milestone and tasks.
3. Verify non-functional requirements (security, performance, availability, privacy) have corresponding plan/tasks.
4. Flag missing dependencies, owners, estimates, or unclear DoD.
5. Identify ambiguous or conflicting requirements and surface assumptions.
6. Output gaps with suggested fixes or clarifying questions; consider running `/speckit.clarify`.
7. Generate a short review guide with `/speckit.checklist` for critical areas.
