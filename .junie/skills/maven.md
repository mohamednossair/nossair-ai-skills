---
name: maven
description: Dependency management, BOMs, reproducible builds, and profiles
---

# Maven Skill

## Guidelines
- Use BOMs to align versions; prefer dependencyManagement.
- Correct scopes (compile, provided, runtime, test).
- Reproducible builds: plugin versions pinned; enforcer rules.

## Checklist
- [ ] No version drift; dependency convergence checked
- [ ] Plugin versions pinned; reproducible builds enabled
- [ ] Profiles documented and minimal
