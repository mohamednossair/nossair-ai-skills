---
description: Initialize SDD project structure with constitution, spec, plan, and task templates.
---
Act as a Senior SDD Architect. Create the Spec-Driven Development structure for this project.

## Actions
1. Create `.spec/` directory with `tasks/` subdirectory.
2. Generate these files using bullet-point format only (no prose):

**constitution.md** (max 30 lines):
- Tech Stack: languages, frameworks, databases
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
Print created file list and the workflow cheat sheet:
`GUARD -> DEFINE -> PLAN -> BREAK -> BUILD -> VALIDATE`