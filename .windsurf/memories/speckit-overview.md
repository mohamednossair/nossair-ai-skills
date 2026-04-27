# SpecKit — Feature Specification & BA Toolkit

Cross-agent toolkit for specification, planning, validation, and document generation.

## Capabilities
- `/speckit.specify` — Create or update a feature spec from natural language
- `/speckit.clarify` — Ask targeted questions to resolve ambiguities
- `/speckit.plan` — Turn the spec into an outcome-oriented implementation plan
- `/speckit.tasks` — Generate dependency-ordered tasks grouped by milestones
- `/speckit.validate` — Check consistency across spec, plan, and tasks
- `/speckit.analyze` — Automated cross-artifact analysis and gap detection
- `/speckit.implement` — Dependency-ordered execution runbook with test/review gates
- `/speckit.checklist` — Verifiable review checklist from requirements
- `/speckit.document-generate` — Reverse-engineer a 10-file BA document set from the codebase (see workflow for full details)
- `/speckit.test-generate` — Generate spec-linked unit tests with AC traceability

## Integration Map
- After `/speckit.specify`, run relevant tech reviews: `/review`, java-review, spring-api, ts-review, sql-review
- After `/speckit.tasks`, use `/test-generate` for test generation where DoD includes tests
- After any major spec/plan/tasks update, run `/speckit.validate` then `/speckit.clarify` for flagged ambiguities

## Minimal Workflow
0. BA Doc (optional): `/speckit.document-generate module="..."` — create business analysis before tech spec
1. Draft: `/speckit.specify feature="..."` — creates/switches to `feature/spec/...` branch
2. Clarify: `/speckit.clarify context="..."`
3. Plan: `/speckit.plan spec="..."`
4. Tasks: `/speckit.tasks plan="..."`
5. Validate: `/speckit.validate spec="..." plan="..." tasks="..."` or `/speckit.analyze`
6. Implement: `/speckit.implement tasks="..."`
7. Tests & Reviews: `/test-generate` and targeted reviews

## Quality Checklist
- [ ] Goals, non-goals, users, constraints captured
- [ ] Acceptance criteria are concrete and testable
- [ ] Milestones are outcome-oriented (2-5)
- [ ] Tasks are dependency-ordered with clear DoD
- [ ] Gaps and ambiguities are called out with next steps
