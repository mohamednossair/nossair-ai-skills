---
description: Produce a dependency-ordered execution runbook with test and review gates
---
Act as a Lead Developer. Create an execution runbook from tasks.

## Actions
1. Create an execution plan ordered by dependencies and risk.
2. Suggest branch strategy per milestone/task (feature/*, bugfix/*) consistent with repo rules.
3. For each task, propose: commit slices, test scaffolds (`/test-generate`), and review checkpoints.
4. Track Definition of Done and link back to AC IDs for traceability.
5. Output a runbook with commands and checkpoints to execute safely.

## Output Format
```markdown
# Implementation Runbook

## Phase 1: Setup
### Task T-01: [Name]
```bash
# Branch
git switch -c feature/T-01-short-name

# Commands
[Specific commands to execute]

# Test
/test-generate file="..."

# Review
/review file="..."

# Commit
git commit -m "type(scope): description"
```

## Definition of Done Checklist
- [ ] AC-1: [Criteria met?]
```
