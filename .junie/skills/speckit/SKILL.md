---
name: speckit
description: Cross-agent feature specification, planning, and validation toolkit
---

# Speckit Skill

Use this skill to create concise specs, convert them into actionable plans and tasks, and validate consistency across artifacts.

## Capabilities
- /speckit.specify: Create or update a concise feature spec. Generates a short name, persists to `.specify/feature.json`, and produces a spec-quality checklist.
- /speckit.clarify: Ask up to 5 targeted questions to resolve ambiguities and encode answers back into the spec.
- /speckit.plan: Turn the spec into an outcome-oriented implementation plan. Loads `.specify/feature.json` and cross-checks the constitution.
- /speckit.tasks: Generate dependency-ordered tasks grouped by user story (P1, P2...). Supports parallel markers `[P]` and reads `.specify/feature.json`.
- /speckit.validate: Check consistency across spec, plan, and tasks.
- /speckit.checklist: Generate domain-specific requirement-quality checklists (unit tests for English) under `checklists/`.
- /speckit.analyze: Read-only cross-artifact analysis with severity assignment (CRITICAL / HIGH / MEDIUM / LOW) and constitution alignment checks.
- /speckit.implement: Execute the implementation plan with constitution governance, checklist gating, and project-setup verification.
- /speckit.taskstoissues: Convert tasks into actionable GitHub issues (requires a GitHub remote).
- /speckit.document-generate: Reverse-engineer a Business Analysis (BA) document set from the current codebase -- no manual writing required.

## Usage Patterns
- Keep artifacts brief and outcome-focused.
- Prefer bullet points over paragraphs.
- Capture open questions and assumptions explicitly.
- Link to existing memories in `.windsurf/memories/` when relevant.

## Integration Map
- Requirements to Reviews: After `/speckit.specify`, run tech reviews where relevant:
  - `/java-review`, `/spring-api` for JVM services
  - `/ts-review`, `/angular-component` for frontend
  - `/sql-review`, `/mysql-review`, `/oracle-review` for data work
  - `/git-review` to validate branch and commit strategy
- Plan to Tests: After `/speckit.tasks`, use `/test-generate` for units/integration where DoD includes tests.
- Validation Loop: Use `/speckit.validate` after any major spec/plan/tasks update; run `/speckit.clarify` to resolve flagged ambiguities.

## Minimal Workflow
0. BA Doc (optional): `/speckit.document-generate module="..."` — create a business analysis doc before drafting a tech spec.
1. Draft: `/speckit.specify feature="..."` (prompt and create/switch to a `feature/spec/...` branch)
2. Clarify: `/speckit.clarify context="..."`
3. Plan: `/speckit.plan spec="..."`
4. Tasks: `/speckit.tasks plan="..."`
5. Validate: `/speckit.validate spec="..." plan="..." tasks="..."` or run `/speckit.analyze`
6. Implement: `/speckit.implement tasks="..."`
7. Tests & Reviews: `/test-generate` and targeted `/*-review` skills

## Checklist
- [ ] Goals, non-goals, users, constraints captured
- [ ] Acceptance criteria are concrete and testable
- [ ] Milestones are outcome-oriented (2–5)
- [ ] Tasks are dependency-ordered with clear DoD
- [ ] Gaps and ambiguities are called out with next steps
