---
name: speckit
description: Cross-agent feature specification, planning, and validation toolkit
---

# Speckit Skill

Use this skill to create concise specs, convert them into actionable plans and tasks, and validate consistency across artifacts.

## Capabilities
- /speckit.specify: Create or update a concise feature spec from natural language.
- /speckit.plan: Turn the spec into an outcome-oriented implementation plan.
- /speckit.tasks: Generate dependency-ordered tasks grouped by milestones.
- /speckit.validate: Check consistency across spec, plan, and tasks.
- /speckit.clarify: Ask targeted questions to resolve ambiguities.
- /speckit.checklist: Produce a short, verifiable review checklist from requirements.

## Usage Patterns
- Keep artifacts brief and outcome-focused.
- Prefer bullet points over paragraphs.
- Capture open questions and assumptions explicitly.
- Link to existing memories in `.windsurf/memories/` when relevant.

## Checklist
- [ ] Goals, non-goals, users, constraints captured
- [ ] Acceptance criteria are concrete and testable
- [ ] Milestones are outcome-oriented (2–5)
- [ ] Tasks are dependency-ordered with clear DoD
- [ ] Gaps and ambiguities are called out with next steps
