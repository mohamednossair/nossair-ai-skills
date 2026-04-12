---
description: Analyze the workspace, collect repository rules, and initialize SDD project structure
---

**Usage**: `/spec-init`

1. Analyze the current workspace first: detect modules, apps, libraries, or sibling repositories and infer each role.
2. Summarize the detected repository/module map and ask the user to confirm or correct it.
3. Ask targeted follow-up questions for repository/module rules, boundaries, forbidden changes, integration points, and best practices.
4. If repository roles or rules are still unclear, stop and wait for the user's answers — do not invent them.
5. Create `.spec/` directory with `tasks/` subdirectory after discovery is complete.
6. Generate `constitution.md` with Tech Stack, Workspace Map, Module Selection Rules, Rules, and Testing.
7. Generate `spec.md` template (Goal, Non-Goals, Requirements, Acceptance Criteria).
8. Generate `plan.md` template (Architecture, Data Model, Implementation Steps).
9. Generate `tasks/01-example.md` (Context, Deliverables, Constraints - max 20 lines).
