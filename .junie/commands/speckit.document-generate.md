---
name: /speckit.document-generate
---

**Usage**: `/speckit.document-generate module="<module-name>" [project="<project-name>"] [frontend="<path>"] [backend="<path>"]`

## Purpose

Generate a useful Business Analysis document for the **active project** by extracting business meaning from the source code.

**Goals:**
- Explain what the system does in business terms
- Help humans understand the project quickly
- Help AI plan and perform tasks correctly
- Give business analysts and product owners a clear, readable project summary

**Guiding principles:**
- Focus on **business behavior**, not implementation details
- Translate technical code into **plain business language**
- Mark anything that cannot be inferred from code as `TBD` -- never leave a section blank
- Keep output structured, practical, and based on code evidence
- Do not include code-level detail unless it is necessary to explain a business behavior
- Make the output readable for: business analysts, product owners, and AI planning/task-execution agents
- The final document must be understandable by a non-technical product owner with no explanation

---

## Steps

### 1. Discover Project Structure
- **Determine the active project root**: use the git root of the file the user has open (or the workspace folder explicitly active when the command was invoked). If ambiguous, ask the user which workspace to use BEFORE proceeding.
- **Scope ONLY to that single project root.** Do NOT read, list, or reference files from any other open workspace, sibling workspace, or parent directory. Ignore any other projects visible in the IDE workspace layout.
- Detect whether the project has a backend only, frontend only, or both (same repo or sibling directories).
- If `frontend` or `backend` parameters are provided, use those paths. Otherwise auto-detect:
  - Backend: `src/main/java`, `src/main/kotlin`, `controllers/`, `routes/`, `app.py`, `Program.cs`
  - Frontend: `src/app/`, `src/components/`, `pages/`, `angular.json`, `package.json` with a framework dependency

### 2. Read and Extract Business Meaning from Code

Scan and read the codebase in order of priority. **Translate everything into business language** -- avoid technical jargon in the output. Identify:
- Business goals and purpose of the system
- Main users / stakeholders and their roles
- Screens and user actions (what users can do)
- Backend processes and APIs (what the system does)
- Business rules and validations (what is enforced)
- Data entities and important fields (what data is managed)
- Reporting or KPI needs (how success is measured)
- Assumptions, risks, and open questions

For each layer, extract the listed signals (read in the order shown -- Specs/Docs first, then API, then logic, then data):

#### Backend
| Layer | What to Read | Signals to Extract |
|-------|-------------|-------------------|
| Specs/Docs | `.spec/spec.md`, `.spec/plan.md`, `docs/` | Existing requirements, constraints |
| API | Controllers, routes, REST/GraphQL endpoints | Operations, HTTP methods, URL patterns, request/response shapes |
| Business Logic | Services, use cases, command/query handlers | Flows, decisions, business rules |
| Data | Entities, models, DTOs, DB schemas, migrations | Entities, fields, relationships, constraints |
| Security | Security config, roles, guards, JWT claims | Actors, permissions, access rules |
| Config | `application.properties`, `application.yml`, env files | Defaults, limits, integration targets |
| Tests | Unit and integration tests | Business intent, edge cases, acceptance signals |
| Comments | TODO, FIXME, HACK | Risks, open questions, known gaps |

#### Frontend
| Layer | What to Read | Signals to Extract |
|-------|-------------|-------------------|
| Routing | `app-routing.module.ts`, `router/index.js`, `pages/` | Screens, navigation flows, route guards |
| Components | Page and feature components | UI interactions, forms, user actions |
| Services/HTTP | API service files, HTTP client calls | Which backend endpoints are consumed, request payloads |
| State/Store | Redux, NgRx, Vuex, signals, context | Data the UI depends on, state transitions |
| Forms | Reactive forms, validation decorators | Input rules, field constraints from user perspective |
| Guards | Auth guards, role guards | Who can access which screen |

#### Cross-Layer Correlation
After reading both sides:
- Match each frontend HTTP call to its backend endpoint.
- Map each UI screen/component to the business use case it supports.
- Compare DTO fields returned by API vs. fields bound in UI components/forms.
- Flag mismatches: UI calls endpoint that does not exist, endpoint exists but unused by UI, field gaps.

### 3. Determine Output Directory
- Default: `<current-project-root>/docs/ba/<module-name>/`
- Create the output directory if it does not exist.

### 4. Generate the File Set

#### 4.0 Pre-Generation Check (Existing Files)

Before writing any file, **check if it already exists** in `docs/ba/<module-name>/`.
For each of the 8 files apply the following decision:

| Condition | Action |
|-----------|--------|
| File does not exist | **Create** it from the template below |
| File exists but has empty or `TBD`-only sections that the current code can now fill | **Update** those sections; keep human-edited content intact |
| File exists and is already accurate and complete | **Skip** -- do not overwrite |

At the end of Step 4, report per file: `CREATED`, `UPDATED (sections: ...)`, or `SKIPPED (already up to date)`.

---

#### 4.1 Writing Rules (Apply to Every File)

- **Write for a product owner** -- someone who understands the business but does not read code.
- Use plain business language in all prose. No class names, method names, or framework terms in sentences.
- Every table row and bullet must say something real -- no placeholder text left in the final output.
- Use `TBD` only when the code gives no evidence at all, and add a note explaining what is missing.
- Navigation links: first line `[<- Back to Index](./README.md)`, last line prev/next (first file: no Previous; last file: no Next).

---

#### 4.1.1 Files to Generate

| File | What a product owner will find here |
|------|--------------------------------------|
| `README.md` | What the system does, who uses it, and a guide to all 8 files |
| `01-overview.md` | What the system does, why it exists, who uses it -- in 30-second readable form |
| `02-scope-context.md` | What is built, how the system works today, and the end-to-end business flow |
| `03-requirements.md` | User stories (As a / I want / So that) and rules the system enforces in plain language |
| `04-use-cases.md` | Step-by-step walkthroughs written as user stories, not technical flows |
| `05-acceptance-criteria.md` | Given/When/Then criteria a product owner can verify manually |
| `06-data-reporting.md` | What data the system manages, what users see vs. what is stored, how success is measured |
| `07-supporting.md` | Assumptions, constraints, mismatches flagged as plain questions, risks as decisions needed |
| `08-reference.md` | Glossary translating every term to plain business language, change history |

### 4.2 File Templates

#### `README.md` -- Index

```markdown
# Business Analysis -- <Module Name>

**Project**: <Project Name> | **Module**: <Module Name> | **Version**: 1.0 | **Date**: <Today> | **Status**: Draft
> Auto-generated from source code. Written for product owners and business analysts. Review and adjust for accuracy.

## What is this system?
<2-3 sentences: what does this system do, who uses it, and what problem does it solve? Plain language only.>

## Health Summary

| Item | Count |
|------|-------|
| Features mapped | <N> |
| TBD sections | <N> |
| Mismatches flagged | <N> |
| Open questions | <N> |

## Contents

| # | Group | File | What a product owner will find here |
|---|-------|------|--------------------------------------|
| 1 | Overview | [01-overview.md](./01-overview.md) | What the system does, why it exists, who uses it |
| 2 | Scope & Context | [02-scope-context.md](./02-scope-context.md) | What is built, how the system works today, and the end-to-end business flow |
| 3 | Requirements | [03-requirements.md](./03-requirements.md) | What users need to do (user stories) and the rules the system enforces |
| 4 | Use Cases | [04-use-cases.md](./04-use-cases.md) | Step-by-step walkthroughs of each main user scenario |
| 5 | Acceptance Criteria | [05-acceptance-criteria.md](./05-acceptance-criteria.md) | How to verify the system works correctly |
| 6 | Data & Reporting | [06-data-reporting.md](./06-data-reporting.md) | What data the system manages and how it is measured |
| 7 | Supporting | [07-supporting.md](./07-supporting.md) | Assumptions, constraints, risks, and open questions |
| 8 | Reference | [08-reference.md](./08-reference.md) | Glossary of terms and change history |
```

---

#### `01-overview.md` -- Overview

```markdown
[<- Back to Index](./README.md)

# 1. Overview -- <Module Name>

## 1.0 One-Line Summary
<Complete this sentence: "This system helps [who] [do what] so that [business outcome]." One sentence only. No technical terms.>

## 1.1 What Does This System Do?
<Write 2-4 sentences a product owner can read in 30 seconds. What problem does it solve? Who benefits? What is the end result?
Do NOT mention technologies, frameworks, or class names.>

## 1.2 Business Goals
<Why was this system built? What should it achieve for the business?
List each goal as a plain statement, not a technical requirement.>
- Goal 1: ...

**How success is measured**: <e.g. number of processed requests, error rate, user adoption -- infer from KPI fields or test assertions>

## 1.3 Who Uses This System? (Stakeholders)
<List every type of user or system that interacts with this module. Translate role names to plain business titles.>
| Role | What They Do in the System | What They Need From It |
|------|---------------------------|------------------------|
| | | |

---
[-> Next: Scope & Context](./02-scope-context.md)
```

---

#### `02-scope-context.md` -- Scope & Context

```markdown
[<- Back to Index](./README.md)

# 2. Scope & Context -- <Module Name>

## 2.1 What Is Included (In Scope)
<List every feature or capability that is implemented and working, based on code evidence.
Write as user-facing capabilities, not endpoint names.>
- ...

## 2.2 How the System Works Today (As-Is)
<Describe the current state in business terms. What happens when a user interacts with the system?
Write as a short narrative, not a technical description.>

## 2.3 End-to-End Business Flow
<Write one named flow per distinct user role found in the codebase. Label each flow as shown below.
If only one role exists, write one flow. Focus on WHAT happens (not HOW it happens technically).>

### Flow: <Role> — <Goal>
1. The user opens the <screen name> screen.
2. The user <performs action>.
3. The system validates <what> and <does what>.
4. The system saves / retrieves <data description>.
5. The user sees <result>.

---
[<- Previous: Overview](./01-overview.md) | [-> Next: Requirements](./03-requirements.md)
```

---

#### `03-requirements.md` -- Requirements

```markdown
[<- Back to Index](./README.md)

# 3. Requirements -- <Module Name>

## 3.1 What Users Need to Do (User Stories)
<One row per main user action. Write the "So that" column as a real business benefit, not a technical outcome.
Priority: High = core flow, Medium = important but not blocking, Low = nice-to-have.>
| ID | As a... | I want to... | So that... | Where (Screen) | Priority |
|----|---------|--------------|------------|----------------|----------|
| FR-01 | | | | | High |

## 3.2 Rules the System Enforces (Business Rules)
<List every validation, constraint, or policy the system applies. Write in plain language.
Type: Policy = a business decision that can be changed; Compliance = a legal/regulatory requirement; Technical Default = a system limit; UX Constraint = an interface restriction.
Note whether each rule is enforced in frontend, backend, or both.
Example: "A user cannot submit the form without a valid email address.">
| ID | Rule (plain language) | When It Applies | Type | Enforced In | Who Sees the Error |
|----|-----------------------|-----------------|------|-------------|--------------------| 
| BR-01 | | | Policy / Compliance / Technical Default / UX Constraint | Frontend / Backend / Both | User / Admin / System |

---
[<- Previous: Scope & Context](./02-scope-context.md) | [-> Next: Use Cases](./04-use-cases.md)
```

---

#### `04-use-cases.md` -- Use Cases

```markdown
[<- Back to Index](./README.md)

# 4. Use Cases -- <Module Name>

<Each use case is a complete story of one user achieving one goal. Write it so a product owner can read it,
understand what the system does, and decide whether it meets business needs.>

## UC-01: <Plain-language name of what the user is trying to achieve>
- **Who does this**: <Role in plain business language, e.g. "Sales Manager", "Customer", "Administrator">
- **Starting point**: <Which screen or entry point does the user start from?>
- **Before they can start**: <What must be true first? e.g. "The user must be logged in", "A record must already exist">
- **What happens step by step**:
  1. The user opens <screen> and sees <what>.
  2. The user <fills in / selects / clicks> <what>.
  3. The system checks <what rule or condition>.
  4. The system saves / retrieves / sends <what data>.
  5. The user sees <result or confirmation>.
- **What if something goes wrong**: <What does the user see if validation fails or an error occurs?>
- **Business value**: <What business goal does this use case advance? e.g. "Reduces manual data entry time", "Enables compliance with X regulation".>
- **End result**: <What has changed after this use case completes? What can the user do next?>

---
[<- Previous: Requirements](./03-requirements.md) | [-> Next: Acceptance Criteria](./05-acceptance-criteria.md)
```

---

#### `05-acceptance-criteria.md` -- Acceptance Criteria

```markdown
[<- Back to Index](./README.md)

# 5. Acceptance Criteria -- <Module Name>

<Each criterion is a verifiable statement that confirms a requirement is working correctly.
Write in plain language. A product owner should be able to manually verify each item.
After each criterion add a label: (Manual) if a person can verify it by clicking through the UI, (Automated) if it requires a script or test tool, (Either) if both apply.>

### FR-01 -- <User story title>
- [ ] AC-01: Given <starting condition>, when <user action>, then <expected result>. (Manual / Automated / Either)
- [ ] AC-02: Given <starting condition>, when <invalid input>, then the user sees <error message>. (Manual / Automated / Either)

### FR-02 -- <User story title>
- [ ] AC-03: ... (Manual / Automated / Either)

---
[<- Previous: Use Cases](./04-use-cases.md) | [-> Next: Data & Reporting](./06-data-reporting.md)
```

---

#### `06-data-reporting.md` -- Data & Reporting

```markdown
[<- Back to Index](./README.md)

# 6. Data & Reporting -- <Module Name>

## 6.1 What Data Does the System Manage?
<Describe each main piece of data in plain business language. Avoid technical field names in the description column.
Only include fields that matter to the business -- not internal IDs or audit timestamps unless they are relevant.>
| Data Object | What It Represents (business meaning) | Key Information Stored | Visible to User? | Owner (Role) |
|-------------|---------------------------------------|------------------------|------------------|--------------|
| | | | Yes / No / Partial | <Role that creates or manages this data> |

## 6.2 What the User Sees vs. What the System Stores
<Flag any gaps between what the user sees on screen and what the system actually stores or returns.
This helps the product owner spot missing fields or inconsistencies.>
| What the User Sees | What the System Stores | Match? | Notes |
|--------------------|------------------------|--------|-------|
| | | Yes / Partial / No | |

## 6.3 How Is Success Measured? (KPIs & Reporting)
<What metrics, counts, or reports does this system produce or support?
If no reporting is found in the code, write TBD and explain what is missing.>
| Metric / Report | What It Measures | Who Needs It |
|-----------------|------------------|--------------|
| | | |

---
[<- Previous: Acceptance Criteria](./05-acceptance-criteria.md) | [-> Next: Supporting](./07-supporting.md)
```

---

#### `07-supporting.md` -- Supporting Information

```markdown
[<- Back to Index](./README.md)

# 7. Supporting Information -- <Module Name>

## 7.1 Assumptions
<Things the system assumes to be true that are not explicitly stated. Inferred from defaults, config values, or hardcoded logic.
Write as plain statements, not technical observations.>
- ...

## 7.2 Constraints
<Limits the system currently has. E.g. "A user cannot upload files larger than 10MB", "Pagination is limited to 50 items per page".>
- ...

## 7.3 Things That Do Not Add Up (Mismatches)
<Gaps found between what the UI shows and what the backend provides. Flag these for the product owner to review.>
| # | What the issue is (plain language) | Business Impact | Action Needed | Assigned To |
|---|-------------------------------------|-----------------|---------------|-------------|
| 1 | | High / Medium / Low | | TBD (Product Owner to assign) |

## 7.4 Risks & Open Questions
<Anything uncertain, incomplete, or flagged in the code as needing attention.
Write as questions the product owner should answer, not technical TODOs.>
| # | Question or Risk | Why It Matters | Who Should Decide |
|---|-----------------|----------------|-------------------|
| 1 | | | |

---
[<- Previous: Data & Reporting](./06-data-reporting.md) | [-> Next: Reference](./08-reference.md)
```

---

#### `08-reference.md` -- Reference

```markdown
[<- Back to Index](./README.md)

# 8. Reference -- <Module Name>

## 8.1 Glossary
<Translate every technical term, system name, or domain concept into plain business language.
A product owner should be able to look up any term they encounter in this document.>
| Term Used in Document | Plain Business Meaning | Where It Appears |
|-----------------------|------------------------|------------------|
| | | Overview / Requirements / Use Cases / Data |

## 8.2 Change History
| Version | Date | Changed By | What Changed |
|---------|------|------------|--------------|
| 1.0 | <Today> | AI-generated | Initial draft from source code |

---
[<- Previous: Supporting](./07-supporting.md)
```

---

### 5. Quality Checks Before Saving
- Every section filled from code evidence -- not blank without reason.
- `TBD` only when no code evidence exists -- never leave a section blank.
- Language must be **plain business language** -- no class names, method signatures, or framework jargon in prose sections.
- User stories follow `As a / I want / So that` format and include screen reference.
- Business rules note whether enforced in frontend, backend, or both, and include rule type.
- Use cases trace the full path: UI screen -> HTTP call -> backend service -> data layer, and include business value.
- Field mapping table in `06-data-reporting.md` must flag any mismatches found.
- Glossary translates frontend component names and backend class names into business language.
- Every file has `[<- Back to Index]` at top and prev/next navigation at bottom.
- The final document must be understandable by a non-technical product owner with no explanation.

### 6. Output Confirmation
- List all 8 files created with their full paths.
- Summarize key findings: entities found, endpoints mapped, UI screens identified, roles detected, mismatches flagged.
- List sections left as `TBD` and explain what code evidence is missing.
- Suggest follow-ups:
  - `/speckit.specify feature="..."` to convert this BA doc set into a technical spec.
  - `/speckit.document-generate module="..."` to generate a BA doc set for another module.
