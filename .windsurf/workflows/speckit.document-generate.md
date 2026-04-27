---
description: Reverse-engineer a Business Analysis document set from the current codebase (frontend + backend) -- no manual input required
---

**Usage**: `/speckit.document-generate module="<module-name>" [project="<project-name>"] [frontend="<path>"] [backend="<path>"]`

## Purpose

Generate a useful Business Analysis document for the **active project** by extracting business meaning from the source code.

**Goals:**
- Explain what the system does in business terms — for a product owner, not a developer
- Help humans understand the project quickly through user journeys and screen-by-screen walkthroughs
- Help AI plan and perform tasks correctly
- Give business analysts and product owners a clear, readable project summary they can act on immediately

**Guiding principles:**
- **Frontend first**: if a frontend exists, treat it as the primary source of business truth — screens and user actions define the structure
- **User journeys first, screens inside**: group everything around end-to-end user journeys; list the screens and steps inside each journey
- Focus on **business behavior**, not implementation details
- Translate technical code into **plain business language**
- **NEVER include** in any output file: API endpoint URLs (e.g. `/api/users`), class names, method names, DTO/entity names, framework terms (e.g. "controller", "service", "repository", "component", "hook"), HTTP verbs, or database table names. These are **strictly forbidden** in all prose, tables, and lists
- Mark anything that cannot be inferred from code as `TBD` -- never leave a section blank
- Keep output structured, practical, and based on code evidence
- Make the output readable for: business analysts, product owners, and AI planning/task-execution agents
- The final document must be understandable by a non-technical product owner with no explanation

---

## Steps

### 1. Discover Project Structure

- **Determine the active project root**: use the git root of the file the user has open (or the workspace folder that was explicitly active when the command was invoked). If ambiguous, ask the user which workspace to use BEFORE proceeding.
- **Scope ONLY to that single project root.** Do NOT read, list, or reference files from any other open workspace, sibling workspace, or parent directory. Ignore any other projects visible in the IDE workspace layout.
- **Check for a frontend first** — this is mandatory:
  - Frontend indicators: `src/app/`, `src/components/`, `pages/`, `angular.json`, `package.json` with a UI framework dependency (Angular, React, Vue, etc.)
  - If `frontend` parameter is provided, use that path
- Then check for a backend:
  - Backend indicators: `src/main/java`, `src/main/kotlin`, `controllers/`, `routes/`, `app.py`, `Program.cs`
  - If `backend` parameter is provided, use that path
- Record what was found: Frontend only / Backend only / Both

### 2. Read and Extract Business Meaning from Code

**Reading discipline — this is mandatory:**
- Do NOT skim. Read every file in each layer listed below, one by one.
- For every file you read, ask: "What business action, rule, or data does this file reveal?" Write the answer before moving to the next file.
- Do not stop after finding the obvious screens or main flows. Keep reading until you have covered every file in the project.
- If a file seems purely technical (e.g. a config loader, a logger setup), still check it for business limits, defaults, or constraints before skipping.
- Depth required: for every service/logic file, read **every individual method or function** and ask what business decision or action it performs. A service with 10 methods = 10 potential business rules to extract.

**Translate everything into plain business language** — what the user sees, does, and gets as a result. Never extract technical details into the output.

#### Step A — Frontend (Primary Source, always first if present)

List every file you will read before you start. Then read each one and record what business signal it gives.

| Layer | What to Read — read EVERY file, not just the first one found | Business Signals to Extract (translate, do not copy) |
|-------|--------------------------------------------------------------|------------------------------------------------------|
| Routing / Pages | **Every** route file and every page/folder name | Every screen name and navigation path — translate to plain names: "User List Screen", "Order Detail Screen" |
| Access Control | **Every** auth guard and role guard file | Who can access which screen — translate to role names: "Administrator", "Sales Manager" |
| Forms & Inputs | **Every** form file, every validation rule, every field definition | Every piece of information the user fills in; every rule the system enforces on that input |
| Screen Interactions | **Every** page component and feature component | Every button, action, selection, search, and trigger available to the user on each screen |
| State & Data Shown | **Every** store, state slice, context, and data binding | Every piece of information displayed to the user — what they see, what they can filter/sort |
| Error & Empty States | Error messages, empty state text, toast/snackbar messages | What the system tells the user when something goes wrong or is empty |

After reading ALL frontend files, produce:
1. **Screen inventory** — every screen, grouped by role. Must be exhaustive — if you found 12 screens, list all 12.
2. **User journey map** — group screens into named end-to-end goals. Every screen must belong to at least one journey.
3. **User actions per screen** — for every screen, every action available (not just the main one).
4. **All validation rules visible to the user** — every error message and constraint the user can encounter.
5. **All statuses and states shown** — every status label, badge, or state the user sees (e.g. "Pending", "Approved", "Rejected").

#### Step B — Backend (Full Independent Extraction)

List every file you will read before you start. Then read each one. Do not stop early.

Read the backend **completely and independently** — not just to fill frontend gaps. Extract every business capability, rule, and data object the system has, whether or not the frontend exposes it.

| Layer | What to Read — read EVERY file, not just the obvious ones | Business Signals to Extract (translate, do not copy) |
|-------|-----------------------------------------------------------|------------------------------------------------------|
| Specs/Docs | Every `.spec/`, `docs/`, `README` file | Requirements, constraints, stated business goals |
| Business Logic | **Every method in every service/use-case/handler file** | Each method = one potential business rule or action. Ask: "What decision does this method make? What does it allow or prevent?" |
| Data | **Every entity, model, schema, migration, and enum/constant file** | Every data object (translate name to business label), every field that matters, every status/state enum translated to plain values (e.g. `STATUS_PENDING` → "Waiting for approval") |
| Security | **Every** security config, role definition, permission list, JWT claim | Every role, every permission granted or denied — translate to plain: "Sales Manager can view but not edit prices" |
| Config | **Every** config/env file | Every limit, threshold, default (translate: "Maximum file size: 10 MB", session timeout: "Users are logged out after 30 minutes of inactivity") |
| Tests | **Every** test file — read each test name and assertion | Each test = one piece of intended business behavior. Extract what it proves the system does. |
| Comments | Every TODO, FIXME, HACK, NOTE comment in the codebase | Risks, open questions, known gaps — translate to business impact |
| Error Handling | Every custom error, exception, and error message string | What can go wrong for the business; what the system refuses to do |

After reading ALL backend files, produce independently:
1. **Complete business rules list** — every rule found, numbered, in plain language. Include: who it applies to, when it triggers, what it allows or prevents. Target: capture every rule, even minor ones.
2. **Backend-only journeys** — every automated process, scheduled job, batch operation, or capability that has no user screen (e.g. "Nightly stock recalculation", "Auto-expire pending requests after 7 days").
3. **Complete data picture** — every business object, every meaningful field, every relationship, every status/lifecycle.
4. **Complete role & permission picture** — every role, every capability granted, every restriction enforced.
5. **System limits & policies** — every threshold, limit, timeout, and default that affects the user or business.

**Do NOT copy into output**: endpoint URLs, HTTP methods, class names, method names, DTO names, framework terms. Translate everything.

#### Step C — Merge Both Layers into One Complete Business Picture

**If only frontend exists**: document what can be inferred from screens and forms; mark backend-dependent sections `TBD`. Skip the merge bullets below.
**If only backend exists**: derive journeys from business logic and data flows; mark screen-level sections `TBD`. Skip the merge bullets below.
**If both exist**, do all of the following:

**Merge — enrich the document with backend business:**
- For every backend business rule found in Step B that is NOT visible on any frontend screen: add it to `03-requirements.md` as a business rule (BR-xx) and note "Enforced by the system, not shown to the user"
- For every backend-only journey or automated process found in Step B: add it to `02-scope-context.md` as a separate journey section labelled "System Journey" (no user interaction required) and to `04-use-cases.md` as a UC with "Who does this: System (automated)"
- For every data object found in Step B that is not visible on any frontend screen: add it to `06-data-reporting.md` section 6.1 with `Visible to User? No`
- For every role or permission found in the backend that has no matching frontend guard: add it to the stakeholders table in `01-overview.md` and note the permission in `03-requirements.md`

**Flag — identify gaps for the product owner:**
- Screens that exist in the frontend but have no backend business logic behind them (flag in `07-supporting.md` 7.3 as a mismatch)
- Backend capabilities that no screen exposes to the user yet (flag in `07-supporting.md` 7.4 as an open question: "Should this capability be exposed to users?")
- Business rules enforced in the backend that contradict or conflict with frontend validation (flag in `07-supporting.md` 7.3)

### 2.5 Pause and Confirm — User Journey Review (REQUIRED when frontend exists)

**Before generating any file**, output a live populated summary using the actual data discovered — do NOT print placeholder text. Structure it as follows:

1. Heading: `## Discovered Business Picture — [actual project name]`
2. **User Journeys** table — one row per journey a user initiates:
   - Journey Name (plain language goal) | Who Does This (plain role name) | Screens Involved (plain screen names, comma-separated)
3. **System Journeys** table — one row per automated process or backend-only capability found (no user screen required). Omit if none found:
   - Process Name (plain language) | What Triggers It | What It Does for the Business
4. **Screens Inventory** table — one row per screen found:
   - Screen Name | Who Can Access It (role) | Main Actions Available (plain verbs, e.g. "Search, View details, Export")
5. **Backend Business Rules** — count only: "Found N business rules enforced by the system. These will be added to the Requirements document."
6. **Open Questions** — list any ambiguities found (e.g. a screen with no backend logic, a backend capability with no screen). Omit if none.
7. Close with: `Please confirm, correct, or add to this list. Type 'ok' to proceed, or tell me what to change.`

Only proceed to Step 3 after the user confirms.
**Exception**: if no frontend exists (backend-only project), skip this pause and proceed directly.

### 3. Determine Output Directory
- Default directory: `<current-project-root>/docs/ba/<module-name>/`
- Create the output directory if it does not exist.

### 4. Generate the File Set

#### 4.0 Pre-Generation Check (Existing Files)

Before writing any file, **check if it already exists** in `docs/ba/<module-name>/`.
There are **9 files** to generate: `README.md` (index) plus the 8 numbered files `01-overview.md` through `08-reference.md`.
For each of the 9 files apply the following decision:

| Condition | Action |
|-----------|--------|
| File does not exist | **Create** it from the template below |
| File exists but has empty or `TBD`-only sections that the current code can now fill | **Update** those sections; keep human-edited content intact |
| File exists and is already accurate and complete | **Skip** -- do not overwrite |

At the end of Step 4, report per file (all 9): `CREATED`, `UPDATED (sections: ...)`, or `SKIPPED (already up to date)`.

---

#### 4.1 Writing Rules (Apply to Every File)

- **Write for a product owner** -- someone who understands the business but does not read code.
- Use plain business language in all prose. No class names, method names, or framework terms in sentences.
- Every table row and bullet must say something real -- no placeholder text left in the final output.
- Use `TBD` only when the code gives no evidence at all, and add a note explaining what is missing.
- Navigation links: first line `[<- Back to Index](./README.md)`, last line prev/next (first file: no Previous; last file: no Next).
- **Hard ban — the following terms are banned in the generated output files only** (they are fine inside these workflow instructions as source-reading guidance):
  - API endpoint URLs (e.g. `/api/users`, `/v1/orders`)
  - HTTP methods (GET, POST, PUT, DELETE, PATCH)
  - Class names, method names, function names (e.g. `UserService`, `createOrder()`)
  - DTO or entity names (e.g. `UserDTO`, `OrderEntity`)
  - Framework or library terms (e.g. "controller", "service bean", "repository", "component", "hook", "reducer", "selector", "interceptor", "module")
  - Database or table names (e.g. `users_table`, `tbl_orders`)
  - Config key names (e.g. `spring.datasource.url`, `JWT_SECRET`)
  - If any such term is the only way to identify something, translate it: `UserController` → "User Management feature", `/api/orders` → "the order submission process"
- **Structure use cases and flows around user journeys** — each journey is a named goal (e.g. "Register a New Customer", "Approve a Purchase Request"). Screens are steps inside a journey, not top-level items.

---

#### Files to Generate

| File | What a product owner will find here |
|------|--------------------------------------|
| `README.md` | What the system does, who uses it, and a guide to all 9 documents |
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
| User journeys mapped | <N> |
| TBD sections | <N> |
| Mismatches flagged | <N> |
| Open questions | <N> |

## Contents

| # | Group | File | What a product owner will find here | Status |
|---|-------|------|--------------------------------------|--------|
| 1 | Overview | [01-overview.md](./01-overview.md) | What the system does, why it exists, who uses it | Complete / Partial / TBD |
| 2 | Scope & Context | [02-scope-context.md](./02-scope-context.md) | What is built, how the system works today, and the end-to-end business flow | Complete / Partial / TBD |
| 3 | Requirements | [03-requirements.md](./03-requirements.md) | What users need to do (user stories) and the rules the system enforces | Complete / Partial / TBD |
| 4 | Use Cases | [04-use-cases.md](./04-use-cases.md) | Step-by-step walkthroughs of each main user scenario | Complete / Partial / TBD |
| 5 | Acceptance Criteria | [05-acceptance-criteria.md](./05-acceptance-criteria.md) | How to verify the system works correctly | Complete / Partial / TBD |
| 6 | Data & Reporting | [06-data-reporting.md](./06-data-reporting.md) | What data the system manages and how it is measured | Complete / Partial / TBD |
| 7 | Supporting | [07-supporting.md](./07-supporting.md) | Assumptions, constraints, risks, and open questions | Complete / Partial / TBD |
| 8 | Reference | [08-reference.md](./08-reference.md) | Glossary of terms and change history | Complete / Partial / TBD |
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
<List every capability the user can do, based on what the screens and business logic reveal.
Write as user-facing capabilities using plain language — no endpoint names, no feature flags, no class names.>
- ...

## 2.2 How the System Works Today (As-Is)
<Describe the current state in business terms. What can a user do when they log in? What are the main areas of the system?
Write as a short narrative a product owner can read in under a minute. No technical description.>

## 2.3 User Journeys and End-to-End Business Flows

<Write one journey per distinct end-to-end goal a user can accomplish.
Each journey starts with a user intent and ends with a business outcome.
Group the screens the user visits inside the journey as numbered steps.
Focus on WHAT the user does and WHAT the system does for them — not HOW it works technically.
Example journey name: "Register a New Supplier", "Approve a Leave Request", "Submit a Monthly Report".>

### Journey: <Plain-language name of what the user is trying to accomplish> — <Role who does this>

**Goal**: <One sentence — what the user wants to achieve by the end of this journey.>
**Starting point**: <Where does the user begin? e.g. "The user opens the Dashboard and clicks 'New Order'">

| Step | Screen | What the User Does | What the System Does |
|------|--------|--------------------|---------------------|
| 1 | <Screen Name> | <plain action, e.g. "Selects a customer from the list"> | <plain result, e.g. "Loads the customer's existing orders"> |
| 2 | <Screen Name> | <plain action> | <plain result> |
| 3 | <Screen Name> | <plain action, e.g. "Reviews the summary and clicks Submit"> | <plain result, e.g. "Saves the order and sends a confirmation to the customer"> |

**End result**: <What has changed for the user or the business after this journey completes?>
**What if something goes wrong**: <What does the user see if a step fails? e.g. "The system shows an error message and keeps the user on the same screen.">

---

### System Journey: <Plain-language name of an automated process, e.g. "Send Order Confirmation", "Recalculate Stock Levels Nightly">
<Use this pattern for backend-only processes — automated actions the system performs with no user screen involved.
Only include if evidence exists in the backend code. If none found, remove this section entirely.>

**What triggers it**: <e.g. "Runs automatically every night", "Triggered when an order is submitted", "Runs when a user's account is deactivated">
**What it does for the business**: <Plain description of the business outcome, e.g. "Sends a confirmation email to the customer and updates the order status to Confirmed">
**Who benefits**: <e.g. "Customer receives confirmation", "Finance team sees updated figures">
**If it fails**: <What happens if this process does not complete? e.g. "The order stays in Pending status and the operations team must resolve it manually.">

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
| ID | As a... | I want to... | So that... | Journey | Where (Screen) | Priority |
|----|---------|--------------|------------|---------|----------------|----------|
| FR-01 | | | | | | High |

## 3.2 Rules the System Enforces (Business Rules)
<List every validation, constraint, or policy the system applies. Write in plain language.
Type: Policy = a business decision that can be changed; Compliance = a legal/regulatory requirement; Technical Default = a system limit; UX Constraint = an interface restriction.
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

<Each use case is a complete story of one user achieving one end-to-end goal (a journey).
Screens are listed as steps inside the journey — not as separate use cases.
Write it so a product owner can read it, walk through it mentally, and decide whether it meets business needs.
No technical terms, endpoint names, class names, or framework words anywhere in this file.>

## UC-01: <Plain-language name of the user's goal, e.g. "Register a New Customer", "Submit a Monthly Expense Report">

- **Who does this**: <Role in plain business language, e.g. "Sales Manager", "Customer", "Procurement Officer">
- **What they want to achieve**: <One sentence — the business outcome the user is trying to get to.>
- **Before they can start**: <What must be true first? e.g. "The user must be signed in", "A product catalogue must already be set up">
- **Screens visited in this journey**:

| Step | Screen | What the User Does Here | What the System Does |
|------|--------|------------------------|---------------------|
| 1 | <Screen Name, e.g. "Dashboard"> | <e.g. "Clicks 'Add New Customer'"> | <e.g. "Opens the customer registration form with empty fields"> |
| 2 | <Screen Name, e.g. "Customer Registration"> | <e.g. "Fills in name, email, phone, and company name, then clicks Save"> | <e.g. "Checks that the email is not already registered and saves the customer record"> |
| 3 | <Screen Name, e.g. "Customer List"> | <e.g. "Reviews the updated list and confirms the new customer appears"> | <e.g. "Displays the full customer list with the new entry at the top"> |

- **What if something goes wrong**:
  - <Scenario 1: e.g. "If the email is already in use, the system highlights the email field and shows a message asking the user to use a different address.">
  - <Scenario 2: e.g. "If the user leaves a required field empty, the system prevents saving and marks the missing fields.">
- **Business value**: <What business goal does completing this use case advance? e.g. "Allows the sales team to onboard new customers without manual paperwork.">
- **End result**: <What has changed for the business after this use case completes? e.g. "A new customer record is available for the sales team to create orders against.">

---

## UC-XX: <Plain-language name of an automated system process, e.g. "Automatically Notify Customer After Order Is Confirmed">
<Use this pattern for backend-only processes with no user screen. Only include if found in backend code.>

- **Who does this**: System (automated — no user action required)
- **What it does**: <One sentence — the business outcome this process produces.>
- **What triggers it**: <e.g. "Runs every night at midnight", "Triggered automatically when a customer places an order">
- **What it does step by step**:
  1. The system detects <condition or event in plain language>.
  2. The system checks <rule or condition>.
  3. The system <performs action, e.g. "sends a notification", "updates the record", "marks the request as expired">.
  4. The result is <business outcome>.
- **What if it fails**: <What happens to the business if this process does not complete? Who is affected?>
- **Business value**: <Why does this process exist? What would break without it?>

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
**Journey**: <Plain-language journey name this story belongs to, e.g. "Register a New Customer">
- [ ] AC-01: Given <starting condition>, when <user action>, then <expected result>. (Manual / Automated / Either)
- [ ] AC-02: Given <starting condition>, when <invalid input>, then the user sees <error message>. (Manual / Automated / Either)

### FR-02 -- <User story title>
**Journey**: <Plain-language journey name>
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

### 6.1.1 How These Things Connect (Business Relationships)
<Describe how the data objects above relate to each other in plain business language.
Only include relationships that matter to the product owner — skip internal or technical links.
Write each relationship as a plain sentence. Examples:
- "An Order belongs to one Customer. A Customer can have many Orders."
- "A Product can appear in many Orders. An Order can contain many Products."
- "An Approval Request is linked to one Employee. Each request has one outcome: Approved or Rejected."
If the data is simple (fewer than 3 objects or no meaningful relationships), skip this section — do not add it at all.>

| Relationship (plain language) | Business Meaning | Example |
|-------------------------------|-----------------|---------|
| <e.g. "A Customer can place many Orders"> | <e.g. "Each order must be linked to a known customer"> | <e.g. "Customer: Acme Corp — Orders: #1001, #1002, #1005"> |

## 6.2 What the User Sees vs. What the System Has / Returns
<Flag any gaps between what the user sees on screen and what the system actually has or returns.
This helps the product owner spot missing fields, hidden data, or display inconsistencies.>
| What the User Sees | What the System Has / Returns | Match? | Notes |
|--------------------|-------------------------------|--------|-------|
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
Write as questions the product owner should answer, not technical TODOs.
Priority: High = blocks a core journey; Medium = affects a feature but has a workaround; Low = minor gap.>
| # | Question or Risk | Why It Matters | Priority | Who Should Decide |
|---|-----------------|----------------|----------|-------------------|
| 1 | | | High / Medium / Low | |

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
| Term Used in Document | Plain Business Meaning | Which Document(s) |
|-----------------------|------------------------|-------------------|
| | | |

## 8.2 Change History
| Version | Date | Changed By | What Changed |
|---------|------|------------|--------------|
| 1.0 | <Today> | AI-generated | Initial draft from source code |

---
[<- Previous: Supporting](./07-supporting.md)
```

### 5. Quality Checks Before Saving

**Coverage verification (do this FIRST, before any other check):**
Before saving any file, answer these questions internally and correct any gaps:
- Did I read every route/page file? (not just the routing module — every page folder too)
- Did I read every form file and extract every field and validation rule?
- Did I read every service/use-case/handler method individually? (not just the class name)
- Did I read every entity/model and every enum/status constant?
- Did I read every test file and extract business intent from each test?
- Did I read every config/env file for limits and defaults?
- Did I read every error/exception message?
- If any answer is NO — go back and read those files before saving.

**Hard-ban check (scan every generated file before saving):**
- Search for: `/api/`, `/v1/`, `Controller`, `Service`, `Repository`, `Entity`, `DTO`, `GET `, `POST `, `PUT `, `DELETE `, `PATCH `, `component`, `hook`, `reducer`, `selector`, `interceptor`, `tbl_`, `_table`
- If any of these are found in prose, table cells, or bullet points — rewrite that item in plain business language before saving.

**Content checks:**
- Every section filled from code evidence -- not left blank without reason.
- Use `TBD` only when no code evidence exists for that section -- never leave a section blank.
- Language must be **plain business language** -- no class names, method signatures, or framework jargon in prose sections.
- User stories follow `As a / I want / So that` format and include screen reference.
- Business rules note whether enforced in frontend, backend, or both, and include rule type (Policy / Compliance / Technical Default / UX Constraint).
- Use cases are structured as user journeys — each UC traces the screens visited, what the user does at each screen, and what the system does in response. No technical trace (no endpoint → service → DB chain).
- Field mapping table in `06-data-reporting.md` describes what the user sees vs. what the system stores — no column/field names from code.
- Glossary translates screen names, feature names, and any domain terms into plain business meaning.
- Every file has `[<- Back to Index]` at top and prev/next navigation at bottom.
- The final document must be understandable by a non-technical product owner with no explanation.

### 6. Output Confirmation
- List all 9 files created with their full paths and status (CREATED / UPDATED / SKIPPED).
- Summarize key findings in business language:
  - User journeys identified (list names)
  - Screens discovered (count and list)
  - User roles found (list plain names)
  - Business rules captured (count)
  - Mismatches flagged (count and brief description)
- List sections left as `TBD` and explain what information is missing (in plain language — not "no entity found" but "no data structure could be identified for this section").
- Suggest follow-ups:
  - `/speckit.specify feature="..."` to convert this BA doc set into a technical spec.
  - `/speckit.document-generate module="..."` to generate a BA doc set for another module.