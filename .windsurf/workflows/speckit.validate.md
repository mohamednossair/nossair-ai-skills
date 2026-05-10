---
description: Validate consistency across spec, plan, and tasks artifacts
---

**Usage**: `/speckit.validate [spec="..."] [plan="..."] [tasks="..."]`

1. **Prerequisite check** — Run `scripts/powershell/check-prerequisites.ps1 -Json` (Windows) or `scripts/bash/check-prerequisites.sh --json` (Linux/macOS). Auto-populate any missing artifact paths from the script output (`FEATURE_SPEC_PATH`, `IMPL_PLAN_PATH`, `TASKS_PATH`). If an artifact does not exist, ask the user for the path.
2. Check alignment of goals and acceptance criteria across artifacts.
3. Flag missing dependencies, owners, or unclear DoD.
4. Identify ambiguous or conflicting requirements.
5. Output gaps with suggested fixes or clarifying questions.
