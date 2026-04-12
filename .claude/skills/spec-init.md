---
description: Initialize SDD project structure from workspace analysis, repository rules, and task templates.
---
Act as a Senior SDD Architect. Create the Spec-Driven Development structure for this project or workspace.

## Actions
1. Analyze the current workspace first: detect modules, apps, libraries, or sibling repositories and infer each role from folders, manifests, and docs.
2. Summarize the detected repository/module map and ask the user to confirm or correct it.
3. Ask targeted questions for missing rules: module responsibilities, ownership boundaries, forbidden edits, integration touchpoints, and preferred best practices.
4. If repository roles or rules are still unclear, stop and wait for the user's answers — do not invent them.
5. Create `.spec/` directory with `tasks/` subdirectory after the discovery phase.
6. Generate these files using bullet-point format only (no prose):

**constitution.md** (concise):
- Tech Stack: languages, frameworks, databases
- Workspace Map: repository/module -> role
- Module Selection Rules: where AI should implement each type of change
- Rules: non-negotiable constraints
- Testing: frameworks, patterns, coverage expectations

**spec.md** (template):
- Goal: one-line objective
- Non-Goals: 3-5 explicit exclusions
- Requirements: endpoints/features as bullet list
- Acceptance Criteria: measurable outcomes

**plan.md** (template):
- Architecture: layer diagram or description
- Data Model: table with fields, types, constraints
- Implementation Steps: numbered milestones

**tasks/01-example.md** (template):
- Context: references to spec/plan sections
- Deliverables: exact files to create
- Constraints: applicable constitution rules

## Output
Print the detected workspace map, any unresolved questions, created file list, and the workflow cheat sheet:
`DISCOVER -> GUARD -> DEFINE -> PLAN -> BREAK -> BUILD -> VALIDATE`