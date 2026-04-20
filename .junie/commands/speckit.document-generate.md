---
name: /speckit.document-generate
---

**Usage**: `/speckit.document-generate module="<module-name>" [project="<project-name>"] [output="docs/ba/<module-name>.md"]`

## Purpose
Generate a full, structured Business Analysis (BA) document for a specific project module. Targeted at business stakeholders, not developers. Covers business context, requirements, flows, data, and reporting.

---

## Steps

### 1. Gather Context
- Ask for module name, project name, and any existing notes if not provided.
- Read `.spec/spec.md`, `.spec/plan.md`, or existing `docs/` files for context if they exist.
- Identify the primary business domain.

### 2. Determine Output Path
- Default: `docs/ba/<module-name>.md`
- Use `output` parameter path if provided.
- Create `docs/ba/` directory if it does not exist.

### 3. Generate the BA Document
Write a Markdown file at the output path with all of these sections:

1. **Executive Summary** — What the module does and why it matters to the business.
2. **Business Goals** — Goals list + measurable success metrics.
3. **Stakeholders** — Table: Role | Name/Team | Interest/Responsibility.
4. **Scope** — In Scope and Out of Scope sub-sections.
5. **Business Context** — As-Is process, To-Be process, step-by-step business flow.
6. **Functional Requirements (User Stories)** — Table: ID | As a | I want to | So that | Priority.
7. **Business Rules** — Table: ID | Rule | Example/Constraint.
8. **Use Cases** — Per use case: Actor, Precondition, Main Flow, Alternative Flow, Postcondition.
9. **Acceptance Criteria** — Checklist, each item concrete and verifiable.
10. **Key Entities & Data Dictionary** — Table: Entity | Description | Key Fields.
11. **KPIs & Reporting Requirements** — Table: KPI/Report | Description | Frequency | Audience.
12. **Assumptions & Constraints** — Two sub-sections.
13. **Risks & Open Questions** — Table: # | Risk/Question | Impact | Owner | Status.
14. **Glossary** — Table: Term | Definition.
15. **Revision History** — Table: Version | Date | Author | Changes.

### 4. Quality Checks Before Saving
- All 15 sections must be present (use `TBD` for unknowns, never omit a section).
- User stories follow `As a / I want / So that` format.
- Acceptance criteria are concrete and verifiable (not vague).
- Business rules are unambiguous.
- KPIs are measurable.
- Glossary covers all domain-specific terms used.

### 5. Output Confirmation
- Report the created file path.
- List sections left as `TBD` and prompt user to fill them.
- Suggest follow-ups:
  - `/speckit.specify feature="..."` to convert this BA doc into a technical spec.
  - `/speckit.document-generate module="..."` for another module.
