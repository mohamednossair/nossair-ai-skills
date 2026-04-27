---
description: Reverse-engineer a Technical Business Analysis document set from the current codebase -- always treats all parts found (frontend, backend, admin, etc.) as one unified integrated system
---

**Usage**: `/speckit.document-generate module="<module-name>" [project="<project-name>"] [parts="<path1>, <path2>, <path3>"]`

> **Always unified by default.** Every codebase and sub-project found is treated as one integrated system. One document set covers everything. If `parts` is not provided, all sub-projects found under the active workspace are automatically included.

## Purpose

Generate a **Technical Business Analysis** document set for the **active project** — a hybrid that gives product owners the full business picture AND gives developers/architects the technical context, all in one place.

**Goals:**
- Explain what the system does in business terms — for a product owner, not a developer
- Also capture the technical implementation behind each business action — for developers and architects
- Help humans understand the project quickly through user journeys and screen-by-screen walkthroughs
- Help AI plan and perform tasks correctly with both business intent and technical context
- Give business analysts, product owners, and developers a complete, actionable reference

**Guiding principles:**
- **Frontend first**: if a frontend exists, treat it as the primary source of business truth — screens and user actions define the structure
- **User journeys first, screens inside**: group everything around end-to-end user journeys; list the screens and steps inside each journey
- **Always unified**: always treat every part found (customer app, admin panel, backend, shared libraries) as one integrated system across all modules. A journey may start in one part and complete in another — document the full journey, not each part in isolation. Never generate separate documents per part.
- **Exhaustive coverage**: document every discovered screen in the frontend and every business-facing API in the backend. No part of the business logic or user interface should be omitted across all modules. For every screen, you must explicitly identify and document every API it calls and the business purpose of those calls.
- **Deep contextual understanding**: as you scan each screen, immediately trace its actions to the backend APIs they trigger. Document the business rules and technical logic of those APIs directly in the context of the screen.
- **Two-layer documentation**: every business action must be paired with its technical implementation. Use clearly labelled sections: business language first, technical notes after.
- Focus on **business behavior** as the primary narrative — the "what" and "why"
- Add **technical notes** as a secondary layer — the "how": which API is called, which service handles it, what data model is used
- **Writing rule for technical notes**: technical terms ARE allowed in `> 🔧 Technical Notes` blocks and dedicated technical columns — but the main prose, tables headers, and business sections must remain in plain business language
- Mark anything that cannot be inferred from code as `TBD` -- never leave a section blank
- Keep output structured, practical, and based on code evidence
- Make the business sections understandable by a non-technical product owner; make the technical notes actionable by a developer

---

## Steps

### 1. Discover Project Structure

#### Discover All Parts (always — no flag needed)
- **Determine the workspace root**: use the git root or the workspace folder explicitly active when the command was invoked. If ambiguous, ask the user BEFORE proceeding.
- **If `parts` parameter is provided**: use those exact paths.
- **If `parts` is NOT provided**: scan the workspace root and identify every sub-project automatically. Look for:
  - Multiple `package.json` files (each = a separate frontend or Node app)
  - Multiple `src/main/java`, `src/main/kotlin`, `app.py`, `Program.cs` roots (each = a backend)
  - Folders named `admin`, `portal`, `dashboard`, `api`, `backend`, `frontend`, `client`, `server`, `app`, `web` — treat each as a potential part
- **Label each part** by its type:
  - Customer-facing frontend (e.g. web app, mobile app)
  - Admin / back-office panel
  - Backend API / business logic
  - Shared library or common module
- **If only one part exists**: treat it as a single-part system and continue.
- **Cross-part integration signals** — actively look for:
  - Data objects that appear in multiple parts (same concept, different views)
  - Roles that exist in one part but not another (e.g. Admin role only in admin panel)
  - Journeys that require actions in more than one part to complete
  - Business rules enforced in the backend but visible in multiple frontends
- List every part found with its label before proceeding to Step 2.

### 2. Read and Extract Business Meaning from Code

**Reading discipline — this is mandatory:**
- Do NOT skim. Read every file in each layer listed below, one by one.
- For every file you read, ask: "What business action, rule, or data does this file reveal?" Write the answer before moving to the next file.
- Do not stop after finding the obvious screens or main flows. Keep reading until you have covered every file in the project.
- If a file seems purely technical (e.g. a config loader, a logger setup), still check it for business limits, defaults, or constraints before skipping.
- Depth required: for every service/logic file, read **every individual method or function** and ask what business decision or action it performs. A service with 10 methods = 10 potential business rules to extract.
- Repeat Steps A and B for **every part** found. Label each finding with its source part (e.g. "Customer App", "Admin Panel", "Backend API"). Step C merges all parts into one unified picture.

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

Read the backend **completely and independently** — not just to fill frontend gaps. Extract every business capability, rule, and data object the system has, covering every single API endpoint and internal service across all modules.

| Layer | What to Read — read EVERY file, not just the obvious ones | Business Signals to Extract (translate) | Technical Signals to Record (exact — for technical notes) |
|-------|-----------------------------------------------------------|-----------------------------------------|-----------------------------------------------------------|
| Specs/Docs | Every `.spec/`, `docs/`, `README` file | Requirements, constraints, stated business goals | N/A |
| Business Logic | **Every method in every service/use-case/handler file** | Each method = one business rule or action. Ask: "What decision does this method make?" | Exact method name, class name, service name — record for technical notes |
| Data | **Every entity, model, schema, migration, and enum/constant file** | Every data object translated to business label; every status enum in plain values (e.g. `STATUS_PENDING` → "Waiting for approval") | Entity/table name, field names, enum constants — record for technical notes |
| API / Routes | **Every controller, route handler, or gateway route file** | What business action the API performs (e.g. "Create User"). Map each endpoint to its business purpose. | Exact endpoint URL, HTTP method, request/response DTO names — record for technical notes |
| Security | **Every** security config, role definition, permission list, JWT claim | Every role and permission in plain language: "Sales Manager can view but not edit prices" | Role constant names, permission strings, JWT claim keys — record for technical notes |
| Config | **Every** config/env file | Every limit, threshold, default translated: "Maximum file size: 10 MB", "Session timeout: 30 minutes" | Config key names, exact values — record for technical notes |
| Tests | **Every** test file — read each test name and assertion | Each test = one piece of intended business behavior | Test class and method names — useful for tracing implementation |
| Comments | Every TODO, FIXME, HACK, NOTE comment in the codebase | Risks, open questions, known gaps translated to business impact | Exact comment text — preserve for technical notes |
| Error Handling | Every custom error, exception, and error message string | What can go wrong for the business; what the system refuses to do | Exception class names, error codes — record for technical notes |

After reading ALL backend files, produce independently:
1. **Complete API-to-Business mapping** — a list of every discovered API endpoint and the business function it serves, translated to plain language.
2. **Complete business rules list** — every rule found, numbered, in plain language. Include: who it applies to, when it triggers, what it allows or prevents.
3. **Technical implementation map** — for every business rule and API, record: which service class enforces it, which method, and which API endpoint triggers it.
4. **Backend-only journeys** — every automated process, scheduled job, batch operation, or capability that has no user screen.
5. **Complete data picture** — every business object, every meaningful field, every relationship, every status/lifecycle. Also record the technical entity/table name.
6. **Complete role & permission picture** — every role, every capability granted, every restriction enforced. Also record the technical role constant.
7. **System limits & policies** — every threshold, limit, timeout, and default that affects the user or business. Also record the config key.

#### Step C — Merge All Layers into One Complete Business Picture

**If only frontend exists**: document what can be inferred from screens and forms; mark backend-dependent sections `TBD`. Skip the merge bullets below.
**If only backend exists**: derive journeys from business logic and data flows; mark screen-level sections `TBD`. Skip the merge bullets below.
**If both exist**, do all of the following:

**Merge — enrich the document with backend business:**
- For every backend business rule found in Step B that is NOT visible on any frontend screen: add it to `03-requirements.md` as a business rule (BR-xx) and note "Enforced by the system, not shown to the user"
- For every backend-only journey or automated process found in Step B: add it to `02-scope-context.md` as a separate journey section labelled "System Journey" (no user interaction required) and to `04-use-cases.md` as a UC with "Who does this: System (automated)"
- For every data object found in Step B that is not visible on any frontend screen: add it to `06-data-reporting.md` section 6.1 with `Visible to User? No`
- For every role or permission found in the backend that has no matching frontend guard: add it to the stakeholders table in `01-overview.md` and note the permission in `03-requirements.md`

**Multi-part merge (when more than one part was found):**
- **Cross-part journeys**: if a user journey spans more than one part (e.g. customer places order in Customer App → admin approves in Admin Panel → backend processes it), document it as ONE journey with steps labelled by part: `[Customer App] Step 1 ...`, `[Admin Panel] Step 2 ...`. Do not split it into separate journeys.
- **Shared data objects**: if the same data concept appears in multiple parts (e.g. "Order" exists in customer app, admin panel, and backend), merge into ONE data object row in `06-data-reporting.md`. In the "Visible to User?" column note which roles see it: "Customer (read-only), Admin (full access)".
- **Role reconciliation**: compile all roles found across all parts into a single stakeholders table in `01-overview.md`. Note which part(s) each role accesses.
- **Part-specific scope**: in `02-scope-context.md` section 2.1, group capabilities by which part delivers them — e.g. "**Customer App**: ...", "**Admin Panel**: ...", "**System (automated)**: ...".
- **Integration points**: in `07-supporting.md` section 7.1 (How the Parts Connect), document how the parts interact in plain language — e.g. "When a customer submits an order, it immediately becomes visible to the admin team for review."

**Flag — identify gaps for the product owner:**
- Screens that exist in the frontend but have no backend business logic behind them (flag in `07-supporting.md` 7.4 as a mismatch)
- Backend capabilities that no screen exposes to the user yet (flag in `07-supporting.md` 7.5 as an open question: "Should this capability be exposed to users?")
- Business rules enforced in the backend that contradict or conflict with frontend validation (flag in `07-supporting.md` 7.4)
- Capabilities that exist in one part but are missing in another where they would be expected — e.g. "Admin can approve orders but there is no screen to view order history" (flag in `07-supporting.md` 7.5)

### 2.5 Pause and Confirm — Full Business Picture Review (REQUIRED when frontend exists)

**Before generating any file**, output a live populated summary using the actual data discovered — do NOT print placeholder text. Structure it as follows:

1. Heading: `## Discovered Business Picture — [actual project name]`
2. **Parts Read**: list each part and its type — e.g. "Customer App (frontend) | Admin Panel (frontend) | Backend API (backend)". If only one part, write "Single project — [name]".
3. **User Journeys** table — one row per journey. If multiple parts were found, note which parts the journey spans:
   - Journey Name (plain language goal) | Who Does This | Parts Involved | Screens (comma-separated)
4. **System Journeys** table — one row per automated process. Omit if none found:
   - Process Name (plain language) | What Triggers It | What It Does for the Business
5. **Screens Inventory** table — one row per screen, grouped by part if multiple parts were found:
   - Part | Screen Name | Who Can Access It | Main Actions Available
6. **Backend Business Rules** — count only: "Found N business rules enforced by the system. These will be added to the Requirements document."
7. **Open Questions** — ambiguities or cross-part gaps found. Omit if none.
8. Close with: `Please confirm, correct, or add to this list. Type 'ok' to proceed, or tell me what to change.`

Only proceed to Step 2.7 after the user confirms.
**Exception**: if no frontend exists (backend-only project), skip this pause and proceed directly to Step 2.7.

### 2.7 Build Per-Page Extraction Plan and Verify Completeness (MANDATORY before generating any file)

For **every screen** found in Step A, build a structured extraction record. Do this for every screen — no screen may be skipped.

For each screen, build the following extraction record. This data feeds directly into `09-page-catalog.md` — every item captured here MUST appear in the final Page Catalog file. **Crucial**: Every action on the screen must be linked to its backend API business logic.

```
Screen: <Plain screen name>
Role(s) who access it: <role 1>, <role 2>
Linked to journey(s): <Journey name(s) this screen is part of>

--- BUSINESS LAYER ---
Buttons / Actions available:
  - <Button or action label in plain language> → <what it does for the user> [Calls API: <Business purpose of API call>]
  - ...
Input fields on this screen:
  - <Field label in plain language> | Required? | Validation rule (plain language)
  - ...
Data displayed to the user:
  - <What the user sees on this screen — list each piece of information> [Source API: <Business purpose of data fetch>]
Business rules that apply on this screen:
  - <Rule in plain language — from frontend validation OR backend logic of called APIs>
  - ...
Error messages the user can see:
  - <Error text or plain description of when it appears> [Triggered by API: <Business reason for error>]
Backend rules that apply but are NOT shown on screen:
  - <Rule in plain language — silent backend enforcement during screen actions>

--- TECHNICAL LAYER ---
API calls made from this screen:
  - <Button/action label> → <HTTP method> <endpoint URL> (handled by: <ServiceClass.methodName()>) | Business logic summary: <what the backend does>
  - ...
Request payload fields:
  - <Field label> → <DTO field name> (<type>, <validation annotation if any>)
  - ...
Response / data loaded:
  - <What is displayed> → <DTO/entity field name> (from: <EntityClass or table>)
  - ...
Frontend component / file:
  - <Component or page file name>
Security guard(s):
  - <Guard name or role check — e.g. "RoleGuard: ROLE_ADMIN">
```

**Verification gate — before moving to Step 3:**
For every screen in the list, confirm:
- [ ] At least one button or action is documented (if a screen has none, flag it as a risk in `07-supporting.md` 7.4)
- [ ] Every input field has a validation rule documented (if unknown, mark `TBD` and flag)
- [ ] Every piece of data shown to the user is listed
- [ ] All backend rules for this screen are captured (from Step B)

Only proceed to Step 3 when every screen has a completed extraction record.

**Backend-only fallback (no screens found):**
If no frontend screens were found, skip the per-page extraction above but verify instead:
- [ ] Every backend business rule from Step B has a corresponding BR-xx in `03-requirements.md`
- [ ] Every backend-only journey has a System Journey in `02-scope-context.md` and a UC in `04-use-cases.md`
- [ ] Every data object has an entry in `06-data-reporting.md` section 6.1
- [ ] Every role/permission has an entry in the stakeholders table in `01-overview.md`
- [ ] `09-page-catalog.md` is marked as `N/A — no user screens in this module` and skipped

### 3. Determine Output Directory
- Default directory: `<current-project-root>/docs/ba/<module-name>/`
- Create the output directory if it does not exist.

### 4. Generate the File Set

#### 4.0 Pre-Generation Check (Existing Files)

Before writing any file, **check if it already exists** in `docs/ba/<module-name>/`.
There are **11 files** to generate: `README.md` (index) plus the 10 numbered files `01-overview.md` through `10-technical-map.md`.
For each of the 11 files apply the following decision:

| Condition | Action |
|-----------|--------|
| File does not exist | **Create** it from the template below |
| File exists but has empty or `TBD`-only sections that the current code can now fill | **Update** those sections; keep human-edited content intact |
| File exists and is already accurate and complete | **Skip** -- do not overwrite |

At the end of Step 4, report per file (all 11): `CREATED`, `UPDATED (sections: ...)`, or `SKIPPED (already up to date)`.

---

#### 4.1 Writing Rules (Apply to Every File)

- **Write for a product owner** -- someone who understands the business but does not read code.
- Use plain business language in all prose. No class names, method names, or framework terms in sentences.
- Every table row and bullet must say something real -- no placeholder text left in the final output.
- Use `TBD` only when the code gives no evidence at all, and add a note explaining what is missing.
- Navigation links: first line `[<- Back to Index](./README.md)`, last line prev/next (first file: no Previous; last file: no Next).
- **Two-layer rule — strictly enforced in every generated file:**
  - **Business sections** (all main prose, tables, journey steps, use cases, business rules): plain language only. No class names, endpoint URLs, HTTP methods, DTO names, framework terms, table names, or config keys.
  - **Technical blocks**: technical terms ARE allowed — but ONLY inside clearly labelled `> 🔧 Technical Notes` blockquotes or in columns explicitly labelled `Technical Implementation`. Never mix them into the business narrative.
  - If any technical term appears in the main prose — rewrite it: `UserController` → "User Management feature", `POST /api/orders` → "the order submission step", `OrderEntity` → "Order record".
- **Structure use cases and flows around user journeys** — each journey is a named goal (e.g. "Register a New Customer", "Approve a Purchase Request"). Screens are steps inside a journey, not top-level items.
- **`> 🔧 Technical Notes` format** — use this exact blockquote style for all technical blocks:
  ```
  > 🔧 Technical Notes
  > - API: POST /api/v1/orders (OrderController.createOrder)
  > - Service: OrderService.validateAndCreate()
  > - Entity: OrderEntity (table: orders)
  > - DTO: CreateOrderRequest / OrderResponse
  ```

---

#### Files to Generate

There are **11 files** to generate: `README.md` (index) plus the 10 numbered files `01-overview.md` through `10-technical-map.md`.

| File | Who it is for | What they will find here |
|------|---------------|--------------------------|
| `README.md` | Everyone | What the system does, who uses it, and a guide to all 11 documents |
| `01-overview.md` | Product owners | What the system does, why it exists, who uses it — in 30-second readable form |
| `02-scope-context.md` | Product owners | What is built, how the system works today, and the end-to-end business flow |
| `03-requirements.md` | Product owners + Developers | User stories and rules — business language with technical implementation notes |
| `04-use-cases.md` | Product owners + Developers | Step-by-step walkthroughs with technical notes per step |
| `05-acceptance-criteria.md` | Product owners + QA | Given/When/Then criteria a product owner can verify; automated test hooks noted |
| `06-data-reporting.md` | Product owners + Developers | What data the system manages, what users see vs. what is stored, technical field mapping |
| `07-supporting.md` | Everyone | Assumptions, constraints, mismatches, risks, and integration points |
| `08-reference.md` | Everyone | Glossary translating every term to plain business language, change history |
| `09-page-catalog.md` | Product owners + Developers | Complete page-by-page reference — every button, field, rule, error + technical API/component notes per screen |
| `10-technical-map.md` | Developers + Architects | Full technical implementation map — APIs, services, entities, config, security, and component structure |

### 4.2 File Templates

#### `README.md` -- Index

```markdown
# Technical Business Analysis -- <Module Name>

**Project**: <Project Name> | **Module**: <Module Name> | **Version**: 1.0 | **Date**: <Today> | **Status**: Draft
> Auto-generated from source code. Written for product owners, business analysts, and developers.

## What is this system?
<2-3 sentences: what does this system do, who uses it, and what problem does it solve? Plain language only.>

## Health Summary

| Item | Count |
|------|-------|
| User journeys mapped | <N> |
| System journeys (automated) | <N> |
| Screens cataloged | <N> |
| Business rules captured | <N> (frontend: <n>, backend-only: <n>) |
| Buttons / actions documented | <N> |
| Input fields documented | <N> |
| API endpoints mapped | <N> |
| Service classes documented | <N> |
| Data entities mapped | <N> |
| TBD sections | <N> |
| Mismatches flagged | <N> |
| Open questions | <N> |

## Contents

| # | Group | File | Audience | What you will find here | Status |
|---|-------|------|----------|--------------------------|--------|
| 1 | Overview | [01-overview.md](./01-overview.md) | Product owners | What the system does, why it exists, who uses it | Complete / Partial / TBD |
| 2 | Scope & Context | [02-scope-context.md](./02-scope-context.md) | Product owners | What is built, how the system works today, and the end-to-end business flow | Complete / Partial / TBD |
| 3 | Requirements | [03-requirements.md](./03-requirements.md) | PO + Developers | User stories and rules with technical implementation notes | Complete / Partial / TBD |
| 4 | Use Cases | [04-use-cases.md](./04-use-cases.md) | PO + Developers | Step-by-step walkthroughs with technical notes per step | Complete / Partial / TBD |
| 5 | Acceptance Criteria | [05-acceptance-criteria.md](./05-acceptance-criteria.md) | PO + QA | How to verify the system works correctly | Complete / Partial / TBD |
| 6 | Data & Reporting | [06-data-reporting.md](./06-data-reporting.md) | PO + Developers | What data the system manages, field mapping, and reporting | Complete / Partial / TBD |
| 7 | Supporting | [07-supporting.md](./07-supporting.md) | Everyone | Assumptions, constraints, risks, integration points, open questions | Complete / Partial / TBD |
| 8 | Reference | [08-reference.md](./08-reference.md) | Everyone | Glossary of terms and change history | Complete / Partial / TBD |
| 9 | Page Catalog | [09-page-catalog.md](./09-page-catalog.md) | PO + Developers | Every screen's buttons, fields, rules, errors, and technical API notes | Complete / Partial / TBD |
| 10 | Technical Map | [10-technical-map.md](./10-technical-map.md) | Developers + Architects | Full API, service, entity, security, and component map | Complete / Partial / TBD |
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
| Role | What They Do in the System | What They Need From It | Part(s) They Access |
|------|---------------------------|------------------------|---------------------|
| | | | <e.g. Customer App, Admin Panel> |

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
| ID | As a... | I want to... | So that... | Journey | Where (Screen) | Part | Priority |
|----|---------|--------------|------------|---------|----------------|------|----------|
| FR-01 | | | | | | <Part name, e.g. Customer App> | High |

> 🔧 Technical Notes
> <For each FR above, list: API endpoint + HTTP method, controller/handler class, and frontend component/page file that implements it.>
> - FR-01: `POST /api/v1/...` → `ServiceClass.methodName()` | Component: `feature-name.component.ts`

## 3.2 Rules the System Enforces (Business Rules)
<List every validation, constraint, or policy the system applies. Write in plain language.
Type: Policy = a business decision that can be changed; Compliance = a legal/regulatory requirement; Technical Default = a system limit; UX Constraint = an interface restriction.
Example: "A user cannot submit the form without a valid email address.">
| ID | Rule (plain language) | When It Applies | Where (Screen) | Type | Enforced In | Who Sees the Effect | Technical Implementation |
|----|-----------------------|-----------------|----------------|------|-------------|---------------------|--------------------------|
| BR-01 | | | <Screen name(s), or "All" / "System-wide"> | Policy / Compliance / Technical Default / UX Constraint | Frontend / Backend / Both / System Only | User / Admin / System (silent) | <e.g. `@NotNull` on `OrderRequest.customerId`; enforced in `OrderService.validate()`> |

> **See also**: [Page Catalog](./09-page-catalog.md) for the complete per-page breakdown of every button, field, rule, and error message.
> **See also**: [Technical Map](./10-technical-map.md) for the full API and service implementation details.

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

> 🔧 Technical Notes
> - APIs called in this use case:
>   - Step 1 → `GET /api/v1/...` (ControllerClass.method)
>   - Step 2 → `POST /api/v1/...` (ControllerClass.method) — validates via ServiceClass.validate()
> - Frontend components: `PageComponent`, `FormComponent`
> - Entities written: `EntityName` (table: `table_name`)
> - Security: Route guarded by `RoleName` / JWT claim `claim_key`

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

> 🔧 Technical Notes
> - Trigger mechanism: `@Scheduled(cron="...")` / event listener class / message queue
> - Service class: `ServiceClass.methodName()`
> - Data affected: `EntityName` (table: `table_name`)
> - Error handling: `ExceptionClass` → logged to `...` / retried `N` times

> **See also**: [Page Catalog](./09-page-catalog.md) for the complete per-page breakdown of every button, field, rule, and error message.

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
| Data Object | What It Represents (business meaning) | Key Information It Holds | Visible to User? | Owner (Role) |
|-------------|---------------------------------------|--------------------------|------------------|--------------|
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

## 6.4 Technical Data Model Reference
<Maps each business data object to its technical implementation. Written for developers.>
| Business Object | Entity / Table | Key Fields (technical name → business label) | Relationships | Status Enum Values |
|-----------------|---------------|----------------------------------------------|---------------|--------------------|
| <e.g. "Customer"> | `CustomerEntity` / `customers` | `customer_id` → ID, `full_name` → Full Name, `status` → Account Status | One Customer → Many Orders | `ACTIVE`, `INACTIVE`, `SUSPENDED` |

> 🔧 Technical Notes
> - ORM: JPA / Hibernate / Mongoose / Prisma / SQLAlchemy
> - Migration tool: Flyway / Liquibase / Alembic
> - Any notable indexes, constraints, or cascade rules found in migrations

---
[<- Previous: Acceptance Criteria](./05-acceptance-criteria.md) | [-> Next: Supporting](./07-supporting.md)
```

---

#### `07-supporting.md` -- Supporting Information

```markdown
[<- Back to Index](./README.md)

# 7. Supporting Information -- <Module Name>

## 7.1 How the Parts Connect (Integration Points)
<If the system has multiple parts (e.g. Customer App + Admin Panel + Backend), describe here how they interact — in plain business language.
Omit this section entirely if only one part exists.>
| # | What Happens | From (Part) | To (Part) | Business Effect |
|---|-------------|-------------|-----------|----------------|
| 1 | <e.g. "Customer submits an order"> | Customer App | Backend | "The order becomes visible to the admin team for review" |
| 2 | <e.g. "Admin approves the order"> | Admin Panel | Backend | "The customer receives a confirmation and the order moves to Processing" |

## 7.2 Assumptions
<Things the system assumes to be true that are not explicitly stated. Inferred from defaults, config values, or hardcoded logic.
Write as plain statements, not technical observations.>
- ...

## 7.3 Constraints
<Limits the system currently has. E.g. "A user cannot upload files larger than 10MB", "Pagination is limited to 50 items per page".>
- ...

## 7.4 Things That Do Not Add Up (Mismatches)
<Gaps found between what the UI shows and what the backend provides. Flag these for the product owner to review.>
| # | What the issue is (plain language) | Business Impact | Action Needed | Assigned To |
|---|-------------------------------------|-----------------|---------------|-------------|
| 1 | | High / Medium / Low | | TBD (Product Owner to assign) |

## 7.5 Risks & Open Questions
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
[<- Previous: Supporting](./07-supporting.md) | [-> Next: Page Catalog](./09-page-catalog.md)
```

---

#### `09-page-catalog.md` -- Page Catalog (Complete Per-Page Business Reference)

```markdown
[<- Back to Index](./README.md)

# 9. Page Catalog -- <Module Name>

> This is the complete page-by-page business reference. Every screen in the system is listed here with **every** button, input field, validation rule, data displayed, backend business rule, and error message. Nothing is left out. If a screen exists in the system, it must appear here.

## Quick Summary

| # | Screen Name | Part | Role(s) | Buttons | Fields | Business Rules | Journey(s) |
|---|-------------|------|---------|---------|--------|----------------|------------|
| 1 | [<Screen Name>](#page-screen-name--part) | <Part, e.g. Customer App> | <Role(s)> | <count> | <count> | <count> | <Journey name(s)> |
<Repeat for every screen. Link each Screen Name to its detailed section anchor below using lowercase-kebab-case: `[Customer List](#page-customer-list--customer-app)`.>

---

## Page: <Screen Name> — <Part>

**Who can access this page**: <Role 1, Role 2>
**Part of journey(s)**: <Journey name(s) — link to 02-scope-context.md section>
**What this page is for**: <One sentence — what the user comes here to do.>

### Actions & Buttons
<Every button, link, action, and trigger available to the user on this screen. Miss nothing.>
| # | Button / Action | What It Does (plain language) | Who Can Use It | Related Rule(s) |
|---|-----------------|-------------------------------|----------------|------------------|
| 1 | <e.g. "Save"> | <e.g. "Saves the form and creates a new customer record"> | <Role> | BR-xx, BR-yy |
| 2 | <e.g. "Delete"> | <e.g. "Removes the selected record after confirmation"> | <Role> | BR-zz |
| 3 | <e.g. "Export"> | <e.g. "Downloads the current list as a spreadsheet"> | <Role> | — |

### Input Fields
<Every field the user can fill in or edit on this screen.>
| # | Field Label | What It Is | Required? | Validation Rules (plain language) | Error Message if Invalid |
|---|-------------|-----------|-----------|-----------------------------------|-------------------------|
| 1 | <e.g. "Email Address"> | <e.g. "The customer's contact email"> | Yes / No | <e.g. "Must be a valid email format"> | <e.g. "Please enter a valid email address"> |
| 2 | <e.g. "Company Name"> | <e.g. "The customer's company"> | Yes | <e.g. "Cannot be empty, maximum 100 characters"> | <e.g. "Company name is required"> |

### Data Displayed to the User
<Every piece of information shown on this screen — tables, cards, labels, badges, counts.>
| # | What the User Sees | Where on the Screen | Source (which data object from 06-data-reporting) |
|---|-------------------|--------------------|-------------------------------------------------|
| 1 | <e.g. "Customer name and email"> | <e.g. "Table columns"> | Customer |
| 2 | <e.g. "Order count badge"> | <e.g. "Next to customer name"> | Order |

### Business Rules on This Page
<Every rule that applies when the user interacts with this page — from frontend validation AND backend enforcement.>
| Rule ID | Rule (plain language) | Visible to User? | Enforced In | What Happens When Violated |
|---------|-----------------------|-------------------|-------------|---------------------------|
| BR-xx | <e.g. "Email must be unique across all customers"> | Yes — error message shown | Both | "A customer with this email already exists" |
| BR-yy | <e.g. "Only Admins can delete a customer record"> | Yes — button hidden for non-admins | Backend | Button not shown; if forced, system rejects the action |
| BR-zz | <e.g. "Customer status is automatically set to Active on creation"> | No — happens silently | System Only | N/A — silent rule |

### Error Messages & Edge Cases
<Every error, warning, and edge case the user can encounter on this page.>
| # | When This Happens | What the User Sees | Severity |
|---|-------------------|--------------------|---------|
| 1 | <e.g. "User submits form with missing required fields"> | <e.g. "Red border on empty fields + message: 'This field is required'"> | Blocking |
| 2 | <e.g. "Network connection lost while saving"> | <e.g. "'Unable to save. Please try again.'"> | Blocking |
| 3 | <e.g. "No records match the search"> | <e.g. "'No results found. Try adjusting your filters.'"> | Informational |

### Technical Implementation
> 🔧 Technical Notes
> - **Frontend component**: `<component-file-name>.component.ts` / `<page-file-name>.tsx`
> - **Route / path**: `<frontend-route-path>` (guard: `<GuardClass>` — requires role `<ROLE_CONSTANT>`)
> - **APIs called on this page**:
>   | Action / Button | HTTP Method | Endpoint URL | Handler | Service |
>   |-----------------|------------|--------------|---------|---------|
>   | <e.g. "Save"> | `POST` | `/api/v1/...` | `ControllerClass.method()` | `ServiceClass.method()` |
>   | <e.g. "Load page"> | `GET` | `/api/v1/...` | `ControllerClass.method()` | `ServiceClass.method()` |
> - **DTOs used**: `RequestDtoName` (request), `ResponseDtoName` (response)
> - **Entities read/written**: `EntityClass` (table: `table_name`)
> - **Notable validations in backend**: `@Annotation` on `field_name` in `DtoClass`

---
<Repeat the full "Page: ..." section above for EVERY screen in the system. No screen may be skipped.>

---
[<- Previous: Reference](./08-reference.md) | [-> Next: Technical Map](./10-technical-map.md)
```

---

#### `10-technical-map.md` -- Technical Implementation Map

```markdown
[<- Back to Index](./README.md)

# 10. Technical Implementation Map -- <Module Name>

> This document is for developers and architects. It maps every business capability to its technical implementation: API endpoints, service classes, entities, DTOs, security config, and frontend components. Written from code evidence.

## 10.1 API Endpoint Map

<List every API endpoint found. Group by functional area (translate to plain names for the group header).>

### <Functional Area — plain name, e.g. "Customer Management">
| # | Business Action | Method | Endpoint URL | Controller Class | Service Class | Request DTO | Response DTO | Auth Required |
|---|----------------|--------|--------------|-----------------|---------------|-------------|--------------|---------------|
| 1 | <e.g. "Create a new customer"> | `POST` | `/api/v1/customers` | `CustomerController.create()` | `CustomerService.create()` | `CreateCustomerRequest` | `CustomerResponse` | `ROLE_ADMIN` |
| 2 | <e.g. "Get customer details"> | `GET` | `/api/v1/customers/{id}` | `CustomerController.getById()` | `CustomerService.findById()` | — | `CustomerResponse` | `ROLE_USER` |

## 10.2 Service & Business Logic Map

<For every service class found, list what it does in business terms alongside its technical name.>

| Service Class | Business Responsibility | Key Methods | Depends On |
|---------------|------------------------|-------------|------------|
| `CustomerService` | Manages customer lifecycle — creation, updates, deactivation | `create()`, `update()`, `deactivate()` | `CustomerRepository`, `NotificationService` |

## 10.3 Data Model Map

<Every entity / table with its fields, types, and constraints.>

### <Entity name> (`table_name`)
| Field Name | Type | Nullable | Constraint | Business Meaning |
|------------|------|----------|------------|-----------------|
| `id` | `BIGINT` / `UUID` | No | Primary Key, auto-generated | Unique record identifier |
| `status` | `VARCHAR(20)` | No | Enum: `ACTIVE`, `INACTIVE` | Current account status |
| `created_at` | `TIMESTAMP` | No | Default: now() | When the record was created |

**Relationships**:
- `CustomerEntity` (1) → `OrderEntity` (many) via `customer_id` FK
- <Add all FK relationships found in code>

## 10.4 DTOs & Validation

<Every request/response DTO with validation annotations.>

| DTO Class | Used For | Key Fields & Validation |
|-----------|---------|------------------------|
| `CreateCustomerRequest` | Create customer API request | `name: @NotBlank`, `email: @Email @NotNull`, `phone: @Pattern(...)` |
| `CustomerResponse` | All customer API responses | `id`, `name`, `email`, `status`, `createdAt` |

## 10.5 Security Configuration

<Roles, permissions, and endpoint security rules.>

### Roles Defined
| Role Constant | Business Name | Capabilities |
|---------------|--------------|--------------|
| `ROLE_ADMIN` | Administrator | Full access to all endpoints |
| `ROLE_USER` | Standard User | Read-only access to own data |

### Endpoint Security Rules
| Endpoint Pattern | Required Role(s) | Notes |
|-----------------|-----------------|-------|
| `POST /api/v1/customers` | `ROLE_ADMIN` | Create only by admins |
| `GET /api/v1/customers/**` | `ROLE_ADMIN`, `ROLE_USER` | Read by all authenticated users |

> 🔧 Security implementation: `SecurityConfig.java` / `SecurityFilterChain` / JWT claims / `@PreAuthorize`

## 10.6 Frontend Component Map

<Every screen mapped to its frontend component file(s) and route.>

| Screen (Business Name) | Part | Route Path | Component File | Guard(s) | Key Services Called |
|------------------------|------|------------|---------------|----------|---------------------|
| <e.g. "Customer List"> | Customer App | `/customers` | `customer-list.component.ts` | `AuthGuard`, `RoleGuard(ADMIN)` | `CustomerService.getAll()` |
| <e.g. "Customer Detail"> | Customer App | `/customers/:id` | `customer-detail.component.ts` | `AuthGuard` | `CustomerService.getById()` |

## 10.7 Configuration & Environment

<All business-relevant configuration values found.>

| Config Key | Current Value / Default | Business Meaning | Where Used |
|------------|------------------------|-----------------|------------|
| `app.session.timeout` | `1800` (seconds) | Users are logged out after 30 minutes of inactivity | `SecurityConfig` |
| `app.file.max-size` | `10MB` | Maximum allowed file upload size | `FileUploadService` |

## 10.8 External Integrations

<Any external systems, APIs, or message queues found.>
<Omit this section entirely if no external integrations are found.>

| Integration | Business Purpose | Technical Details |
|------------|-----------------|-------------------|
| <e.g. "Email Service"> | Sends confirmation emails to customers | `NotificationService` → `POST https://api.sendgrid.com/v3/mail/send` |

---
[<- Previous: Page Catalog](./09-page-catalog.md)
```

### 5. Quality Checks Before Saving

**Coverage verification (do this FIRST, before any other check):**
Use the per-page extraction records built in Step 2.7 as the source of truth. For every generated file, verify:
- [ ] **Every single file** in the module has been read and analyzed (no files skipped)
- [ ] **Every class and method** (business logic, controllers, entities) has been processed
- [ ] Every screen from Step 2.7 has a full entry in `09-page-catalog.md` with ALL six sections (Actions & Buttons, Input Fields, Data Displayed, Business Rules, Error Messages, Technical Implementation). Each section MUST include the business logic of the specific APIs called by that screen.
- Every screen from Step 2.7 appears in `02-scope-context.md` (journey steps) and `04-use-cases.md`
- Every button/action from Step 2.7 appears in `09-page-catalog.md` Actions table AND as a user story in `03-requirements.md` or as a step in `04-use-cases.md`
- Every input field and its validation rule from Step 2.7 appears in `09-page-catalog.md` Input Fields table AND as a business rule (BR-xx) in `03-requirements.md`
- Every backend-only rule from Step 2.7 appears in `09-page-catalog.md` Business Rules table with "System Only" AND in `03-requirements.md`
- Every error message from Step 2.7 appears in `09-page-catalog.md` Error Messages table AND in the "What if something goes wrong" section of the relevant use case
- Every data item displayed on screen appears in `09-page-catalog.md` Data Displayed table AND in `06-data-reporting.md` section 6.1 or 6.2
- The Quick Summary table in `09-page-catalog.md` has correct counts matching the detailed sections below it
- If any of the above is missing — add it before saving.

**Two-layer check (scan every generated file before saving):**
- In **business sections** (main prose, journey tables, use case steps, business rules, user stories): search for technical terms and rewrite any found:
  - `/api/`, `/v1/`, HTTP method names (`GET `, `POST `, `PUT `, `DELETE `, `PATCH `) in prose → rewrite as business action
  - Class names ending in `Controller`, `Service`, `Repository`, `Entity`, `DTO`, `Component` in prose → rewrite as business feature name
  - Table or DB names (`tbl_`, `_table`) in prose → rewrite as business object name
- In **technical blocks** (`> 🔧 Technical Notes` and `10-technical-map.md`): technical terms are expected and correct — do NOT rewrite them.
- For every API endpoint in the technical layer: confirm the matching business action is described in plain language in the business layer.

**Technical completeness check (10-technical-map.md):**
- Every API endpoint found in code appears in section 10.1
- Every service class with business logic appears in section 10.2
- Every entity/table appears in section 10.3
- Every DTO appears in section 10.4
- Every role constant and security rule appears in section 10.5
- Every screen has a matching entry in section 10.6 (Frontend Component Map)
- Every business-relevant config key appears in section 10.7

**Content checks:**
- Every section filled from code evidence -- not left blank without reason.
- Use `TBD` only when no code evidence exists for that section -- never leave a section blank.
- Business sections: plain business language. Technical blocks: exact technical names from code.
- User stories follow `As a / I want / So that` format and include screen reference and technical notes block.
- Business rules include rule type, enforcement location, and `Technical Implementation` column value.
- Use cases include `> 🔧 Technical Notes` block listing all APIs called per use case.
- `06-data-reporting.md` section 6.4 covers every entity with field-level technical mapping.
- Glossary translates screen names, feature names, and domain terms into plain business meaning.
- Every file has `[<- Back to Index]` at top and prev/next navigation at bottom.

### 6. Output Confirmation
- List all 11 files created with their full paths and status (CREATED / UPDATED / SKIPPED).
- Summarize key findings:
  - **Business summary**: user journeys (list names), automated processes (list names), screens (count + list), user roles (plain names)
  - **Business rules**: frontend-visible (count) + backend-only / system-enforced (count)
  - **Page detail**: buttons/actions documented (total), input fields (total), error messages (total)
  - **Technical summary**: API endpoints mapped (total), service classes documented (total), entities/tables mapped (total), DTOs documented (total)
  - **Mismatches flagged** (count and brief plain-language description)
- List sections left as `TBD` and explain what is missing.
- Suggest follow-ups:
  - `/speckit.specify feature="..."` to convert this BA doc set into a technical spec.
  - `/speckit.document-generate module="..."` to generate a BA doc set for another module.