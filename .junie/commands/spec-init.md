---
name: spec-init
description: Initialize Spec-Driven Development structure from workspace analysis, repository rules, and templates.
---
Create the SDD project structure for this project or workspace.
1. Analyze the current workspace first: identify modules, apps, libraries, or sibling repositories and infer each role from folders, build files, and docs.
2. Summarize the detected repository/module map and ask the user to confirm or correct it.
3. Ask targeted follow-up questions for each repository or module: responsibilities, boundaries, forbidden changes, integration points, and best practices the AI must follow.
4. If repository roles or rules are still unclear, stop and wait for the user's answers - do not invent them.
5. Create `.spec/` directory with subdirectory `tasks/` only after the discovery answers are available.
6. Generate `constitution.md` with sections: Tech Stack, Workspace Map, Module Selection Rules, Rules, Testing. Pre-fill from `.junie/guidelines.md` if available.
7. In `constitution.md`, record which module/repository should be used for which kinds of changes so future AI agents write code in the correct place.
8. Generate `spec.md` template with sections: Goal, Non-Goals, Requirements, Acceptance Criteria.
9. Generate `plan.md` template with sections: Architecture, Data Model, Implementation Steps.
10. Generate `tasks/01-example.md` template showing the atomic task format (Context, Deliverables, Constraints).
11. Keep all templates concise, bullet-point format only, and keep the constitution focused on non-negotiable rules plus repository-routing guidance.
12. Use the `spec-kit` skill as reference for structure.
13. Print a summary of the detected workspace map, created files, open questions, and next steps.
