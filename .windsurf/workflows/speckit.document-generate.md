---
description: Generate a full Business Analysis document for a project module stored under docs/ba/
---

**Usage**: `/speckit.document-generate module="<module-name>" [project="<project-name>"] [output="docs/ba/<module-name>.md"]`

## Purpose
Produce a structured, non-technical Business Analysis (BA) document for a specific project module. The document is intended for business stakeholders, project managers, and product owners — not developers. It covers business context, requirements, processes, data, and reporting in plain language.

---

## Steps

### 1. Gather Context
- Ask the user for the module name, project name, and any existing notes, descriptions, or requirements if not already provided.
- If `.spec/spec.md`, `.spec/plan.md`, or any `docs/` files exist in the project, read them for context to avoid repeated input.
- Identify the primary business domain (e.g. CRM, ERP, E-commerce, HR, Finance).

### 2. Determine Output Path
- Default path: `docs/ba/<module-name>.md`
- If the `output` parameter is provided, use that path instead.
- Create the `docs/ba/` directory if it does not exist.

### 3. Generate the BA Document
Write a Markdown file at the output path with the following structure:

```
# Business Analysis Document — <Module Name>

**Project**: <Project Name>
**Module**: <Module Name>
**Version**: 1.0
**Date**: <Today's Date>
**Status**: Draft

---

## 1. Executive Summary
- One paragraph: what the module does and why it matters to the business.

---

## 2. Business Goals
- Goal 1: ...
- Goal 2: ...
- Success Metrics: measurable outcomes that indicate the module is achieving its goals.

---

## 3. Stakeholders
| Role | Name / Team | Interest / Responsibility |
|------|-------------|--------------------------|
| Business Owner | ... | Final approval, budget |
| End User | ... | Daily use of the module |
| IT / Support | ... | Maintenance, integration |

---

## 4. Scope
### 4.1 In Scope
- ...

### 4.2 Out of Scope
- ...

---

## 5. Business Context
### 5.1 As-Is Process (Current State)
Describe the current way the business handles this area (manual, existing tool, workaround).

### 5.2 To-Be Process (Future State)
Describe how the module will change or improve this process.

### 5.3 Business Flow (Step-by-Step)
1. Step 1: ...
2. Step 2: ...
3. Step 3: ...

---

## 6. Functional Requirements (User Stories)
| ID | As a... | I want to... | So that... | Priority |
|----|---------|--------------|------------|----------|
| FR-01 | | | | High |
| FR-02 | | | | Medium |

---

## 7. Business Rules
| ID | Rule Description | Example / Constraint |
|----|-----------------|----------------------|
| BR-01 | | |
| BR-02 | | |

---

## 8. Use Cases
### UC-01: <Use Case Name>
- **Actor**: ...
- **Precondition**: ...
- **Main Flow**: ...
- **Alternative Flow**: ...
- **Postcondition**: ...

---

## 9. Acceptance Criteria
- [ ] AC-01: ...
- [ ] AC-02: ...

---

## 10. Key Entities & Data Dictionary
| Entity | Description | Key Fields |
|--------|-------------|------------|
| | | |

---

## 11. KPIs & Reporting Requirements
| KPI / Report | Description | Frequency | Audience |
|-------------|-------------|-----------|----------|
| | | | |

---

## 12. Assumptions & Constraints
### Assumptions
- ...

### Constraints
- ...

---

## 13. Risks & Open Questions
| # | Risk / Question | Impact | Owner | Status |
|---|----------------|--------|-------|--------|
| 1 | | High/Med/Low | | Open |

---

## 14. Glossary
| Term | Definition |
|------|------------|
| | |

---

## 15. Revision History
| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | <Today> | | Initial draft |
```

### 4. Quality Checks Before Saving
- All section headers must be present (fill with `TBD` if unknown, never omit).
- User stories must follow the `As a / I want / So that` format.
- Acceptance criteria must be concrete and verifiable.
- Business rules must be unambiguous.
- KPIs must be measurable.
- Glossary must define any domain-specific or ambiguous terms used in the doc.

### 5. Output Confirmation
- Report the file path created.
- List any sections left as `TBD` and prompt the user to supply missing details.
- Suggest follow-up commands:
  - `/speckit.specify feature="..."` — to turn this BA doc into a technical spec.
  - `/speckit.document-generate module="..."` — to generate a BA doc for another module.
