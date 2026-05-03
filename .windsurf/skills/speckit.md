# Speckit Skill

Feature specification, planning, tasks, validation, and clarification utilities.

## Capabilities
- **/speckit.specify**: Create or update a concise feature spec from natural language.
- **/speckit.plan**: Turn the spec into an outcome-oriented implementation plan.
- **/speckit.tasks**: Generate dependency-ordered tasks grouped by milestones.
- **/speckit.validate**: Check consistency across spec, plan, and tasks.
- **/speckit.clarify**: Ask targeted questions to resolve ambiguities.
- **/speckit.checklist**: Produce a short, verifiable review checklist from requirements.
- **/speckit.analyze**: Automated cross-artifact analysis and gap detection.
- **/speckit.implement**: Produce a dependency-ordered execution runbook with test/review gates.
- **/speckit.test-generate**: Generate spec-linked unit tests with AC traceability.
- **/speckit.document-generate**: Reverse-engineer BA docs from codebase.
- **/speckit.constitution**: Create or update cross-repository constitution.

## Usage Patterns
- Keep artifacts brief and outcome-focused.
- Prefer bullet points over paragraphs.
- Capture open questions and assumptions explicitly.
- Link to existing memories in `.windsurf/memories/` when relevant.

## Integration Map
- **Requirements to Reviews**: After `/speckit.specify`, run tech reviews where relevant:
  - `/java-review`, `/spring-api` for JVM services
  - `/ts-review`, `/angular-component` for frontend
  - `/sql-review`, `/mysql-review`, `/oracle-review` for data work
  - `/git-review` to validate branch and commit strategy
- **Plan to Tests**: After `/speckit.tasks`, use `/test-generate` for units/integration.
- **Validation Loop**: Use `/speckit.validate` after any major spec/plan/tasks update.

## Minimal Workflow
1. **BA Doc (optional)**: `/speckit.document-generate module="..."`
2. **Draft**: `/speckit.specify feature="..."`
3. **Clarify**: `/speckit.clarify context="..."`
4. **Plan**: `/speckit.plan spec="..."`
5. **Tasks**: `/speckit.tasks plan="..."`
6. **Validate**: `/speckit.validate spec="..." plan="..." tasks="..."`
7. **Implement**: `/speckit.implement tasks="..."`
8. **Tests & Reviews**: `/test-generate` and targeted `/*-review` skills

## Checklist
- [ ] Goals, non-goals, users, constraints captured
- [ ] Acceptance criteria are concrete and testable
- [ ] Milestones are outcome-oriented (2–5)
- [ ] Tasks are dependency-ordered with clear DoD
- [ ] Gaps and ambiguities are called out with next steps
