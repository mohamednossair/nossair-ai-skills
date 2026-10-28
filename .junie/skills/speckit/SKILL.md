---
name: speckit
description: Cross-agent feature specification, planning, and validation toolkit (spec → plan → tasks → validate → implement)
---

# Speckit Skill

Use this skill to create concise specs, convert them into actionable plans and tasks, and validate consistency across artifacts.

## When to Use
- Starting a new feature that needs a spec, plan, and task breakdown.
- When the user invokes any `/speckit.*` command.
- When cross-checking spec, plan, and tasks for consistency or traceability.
- When generating a Business Analysis document set from an existing codebase.

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
- Follow the technology standards in `.junie/guidelines.md` when planning implementation details.

## Integration Map
- Requirements to Reviews: After `/speckit.specify`, run tech reviews where relevant:
  - `java` + `spring-boot` skills for JVM services
  - `typescript` + `angular` skills for frontend
  - `oracle` / `mysql` skills for data work
  - `security` skill when the feature touches auth, user input, or secrets
  - `performance` skill for hot paths, list endpoints, and data loading
  - `accessibility` skill for user-facing UI
  - `git` skill to validate branch and commit strategy
- Plan to Tests: After `/speckit.tasks`, use `/test-generate` for units/integration where DoD includes tests.
- Validation Loop: Use `/speckit.validate` after any major spec/plan/tasks update; run `/speckit.clarify` to resolve flagged ambiguities.

## Minimal Workflow
0. BA Doc (optional): `/speckit.document-generate module="..."` — create a business analysis doc before drafting a tech spec.
1. Draft: `/speckit.specify feature="..."` (creates the feature branch `feature/spec/<id>-<slug>` via the create-branch helper, then `specs/NNN-short-name/` + `.specify/feature.json`)
2. Clarify: `/speckit.clarify context="..."`
3. Plan: `/speckit.plan spec="..."` (plan.md includes a `## Standards` section listing the skills any implementing agent must load)
4. Tasks: `/speckit.tasks plan="..."`
5. Validate: `/speckit.validate spec="..." plan="..." tasks="..."` or run `/speckit.analyze`
6. Implement: `/speckit.implement tasks="..."` (verifies feature branch, loads the plan's Standards, marks tasks `[X]`)
7. Tests & Reviews: `/test-generate`, `/review`, and `/review-pr` before merging

## Cross-Agent Handoff
Artifacts are plain Markdown with exact file paths, tracked in `.specify/feature.json` — any agent can continue the chain:
- Plan with one tool (e.g., Junie), implement with another (e.g., Devin or AIR): the implementing agent reads `.specify/feature.json`, the feature's `plan.md` `## Standards` section, and the listed `.junie/skills/` files.
- Devin: invoke `/speckit <command>` — it maps to the same `.junie/commands/speckit.*.md` definitions.
- AIR: `.aiassistant/rules/project-rules.md` documents the same mapping.
- GitHub integration: `/speckit.taskstoissues` converts tasks.md into GitHub issues (requires a GitHub remote and `gh` CLI or the GitHub MCP tool).

## Checklist
- [ ] Goals, non-goals, users, constraints captured
- [ ] Acceptance criteria are concrete and testable
- [ ] Milestones are outcome-oriented (2–5)
- [ ] Tasks are dependency-ordered with clear DoD
- [ ] Gaps and ambiguities are called out with next steps
