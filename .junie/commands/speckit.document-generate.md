---
description: Reverse-engineer a lean 6-file AI-optimized Business Analysis document set from the codebase (AI index, machine-readable facts, code map, Mermaid graphs)
---

**Usage**: `/speckit.document-generate module="<module-name>" [project="<project-name>"] [parts="<path1>, <path2>"] [mode="interactive|auto|resume"]`

Default `mode=interactive`. Execution modes:
- `interactive` — save discovery checkpoints; pause after the discovered business picture (Step 2.5); continue after corrections.
- `auto` — do not wait for confirmation; mark uncertain findings with `confidence` values and open questions; continue through validation.
- `resume` — load the latest valid checkpoint under `docs/ba/<module>/.work/`; revalidate changed source files only; preserve stable IDs for unchanged facts.

Checkpoints (internal working artifacts, written after each extraction stage): `docs/ba/<module>/.work/discovery.json`, `frontend-facts.json`, `backend-facts.json`, `reconciliation.json`, `coverage.json`, `id-registry.json`. Each checkpoint carries `schema_version`, `created_at`, `repository_commit`, `source_fingerprints` (path → hash), and `completed_stage`. All generated timestamps (`created_at` in checkpoints, `generated` in `99-facts.json`) use ISO 8601 with the execution environment's local offset, e.g. `2026-10-29T09:17:00+03:00`. Resume rules: invalid JSON, unknown schema version, or missing stage metadata invalidates the checkpoint; modified, deleted, or renamed files invalidate all facts depending on them; re-run reconciliation whenever frontend or backend facts change; preserve IDs for semantically unchanged facts; never reuse a checkpoint from a different repository or module.

> **Always unified.** Treat every part found (customer app, admin panel, backend, shared libs) as ONE integrated system — one document set, never per-part documents. If `parts` is omitted, auto-include all sub-projects found under the active workspace.

## Purpose

Extract business meaning from source code into a lean, AI-optimized BA document set for AI planning agents, developers, and business stakeholders. **Frontend first** (screens define structure); **user journeys first** (screens are steps inside journeys); document **business behavior**, never implementation details.

**AI-first outputs (mandatory):**
- **AI reading path** (state it in `00-ai-index.md` and `README.md`): `00-ai-index.md` (answer from the map) → `99-facts.json` (structured, grep-able facts) → `11-code-map.md` (jump to the exact source files) → deep-read a business file only when narrative is needed.
- **Mermaid graphs**: embed journey, data-model, lifecycle, and architecture diagrams in the generated files so structure is visible at a glance to humans and AI agents alike.
- **Token-efficient AI index**: `00-ai-index.md` is a dense one-line-per-item map of the whole set with anchor links — an AI agent answers most questions from this single small file and deep-reads only the linked section.
- **Machine-readable fact base**: `99-facts.json` holds every fact (journeys, screens, rules, stories, criteria, entities, statuses, limits) as structured data with IDs and doc anchors — deterministic to parse, filter, and grep; no re-reading of Markdown to extract facts.
- **Code map**: `11-code-map.md` maps every source file to its business purpose and the rules/journeys it implements — an AI can jump from a business question to the exact files without re-scanning the codebase.
- **Lookup-friendly writing**: stable fixed-width IDs (`BR-###`, `US-###`, `AC-###`, `J-###`, exact screen names), descriptive headings, and tables over prose in every file, so any section can be read in isolation.

**Lean set principle** — generate only what an AI needs: README, `00-ai-index`, `02-scope-context` (journeys + journey-map diagrams), `10-technical-map` (architecture + Data Model + Status Lifecycle diagrams + command mapping), `11-code-map`, `99-facts.json`. Rules, stories, criteria, entities, statuses, glossary, KPIs, assumptions, constraints, mismatches, and open questions ALWAYS live in `99-facts.json` — no narrative files are generated.

**Global rules (apply to every step below):**
- **Exhaustive coverage (MANDATORY, two-pass)**: every discovered screen and business-facing API is documented, including each screen's API calls and their business purpose. Coverage means every file is CLASSIFIED (Pass 1) and every business-relevant file is DEEP-READ (Pass 2) — not that every file received equal-depth reading. A missed screen, business API, or unclassified file = failed document.
- **Forceful scanning**: search for hidden screens, modal dialogs, and dynamic routes — check every `import` and route definition, not just top-level navigation.
- **Skip generated/boilerplate code**: `generated` in package/path, `@Generated` annotation, `DO NOT EDIT` headers, `generated-sources/`, `gen/`, `.proto/` output. Record the skip and why.
- **Feature flags**: if a business rule is conditional on a flag/toggle, document the rule, flag name, default state, and which users/roles see the gated behavior.
- **Plain business language — scoped per file** (fine in these instructions): `README.md`, `00-ai-index.md`, and `02-scope-context.md` are business-language files and HARD-BAN implementation details: no API endpoint URLs (`/api/users`), HTTP verbs, class/method/function names (`UserService`, `createOrder()`), DTO/entity names, framework terms (controller, service, repository, component, hook, reducer, selector, interceptor, module), DB/table names (`tbl_orders`), or config keys. Translate instead: `UserController` → "User Management feature"; `/api/orders` → "the order submission process". In `99-facts.json`, business-facing fields follow the same hard ban, while only the designated technical and evidence fields (see the JSON field boundary below) may contain implementation identifiers. Exception: `10-technical-map.md` and `11-code-map.md` are for implementers and MAY use technical terms.
- **Never leave a section blank — TBD is controlled**: mark anything not inferable from code as `TBD`; every `TBD` must be accompanied by the missing fact, the evidence searched, why it could not be determined, the required owner or source, and the impact on confidence. Represent each unresolved fact as one nested record — generate as normal Markdown without the example indentation:

    - Session timeout: TBD
      - Evidence searched: Application configuration and environment templates
      - Why unresolved: Production identity-provider policy is unavailable
      - Required source: Identity platform owner or production policy
      - Confidence impact: Authentication lifecycle remains unconfirmed
- The business-language files (`README.md`, `00-ai-index.md`, `02-scope-context.md`, `99-facts.json`) must be understandable by a non-technical product owner with no explanation.
- **Dual representation for technical references**: business-facing fields stay plain language; technical references (HTTP method, endpoint path, source symbol) appear only in technical outputs (`10-technical-map.md`, `11-code-map.md`) or designated machine fields (e.g. a screen action's `technical_refs` in `99-facts.json`). Never remove source paths, symbols, routes, schema objects, or technical identifiers from the technical maps.
- **JSON field boundary (schema-driven)**: business-language validation applies to `99-facts.json` fields `name`, `statement`, `purpose`, `business_effect`, `user_message`, `assumption`, `constraint`, `question`, and acceptance text; technical terminology is permitted only in `technical_refs`, `evidence.path`, `evidence.symbol`, `evidence.lines`, `evidence.evidence_type`, `source_part`, and `implementation_layer`.
- **Stable fact-ID lifecycle**: never renumber an existing fact; preserve IDs when meaning remains materially the same; mark removed facts `Deprecated` with `replaced_by` when applicable; assign new IDs only to genuinely new facts; detect possible renames via source evidence and semantic similarity; maintain `docs/ba/<module>/.work/id-registry.json` so regeneration never breaks links from specifications, plans, tasks, or tests. IDs are fixed-width zero-padded: `J-###` (journey), `SJ-###` (system journey), `SCR-###` (screen), `BR-###`, `US-###`, `AC-###`, `ENT-###`, `INT-###`. Authority: `99-facts.json` is authoritative for published business facts; `.work/id-registry.json` is authoritative only for ID allocation, aliases, deprecation history, and replacement relationships — when they disagree, generation is BLOCKED until reconciled.

## Steps

### 1. Discover Parts

- Workspace root = git root or the active workspace folder; if ambiguous, ask the user BEFORE proceeding.
- If `parts` is provided, use those exact paths. Otherwise scan the root for sub-projects: multiple `package.json` files; multiple `src/main/java` / `app.py` / `Program.cs` roots; folders named `admin|portal|dashboard|api|backend|frontend|client|server|app|web`.
- Fallback heuristics: a folder with a `main` entry point (`main.py`, `index.js`, `App.java`, `Program.cs`...); a `Dockerfile`/`docker-compose.yml` defining a service; `.html/.css/.jsx/.tsx/.vue/.svelte` alongside `package.json`/`vite.config.*` (frontend); `pyproject.toml|setup.py|Cargo.toml|go.mod|pom.xml|build.gradle|*.csproj` (backend/library). When in doubt, classify each top-level folder by dominant file type.
- Label each part: Customer-facing frontend | Admin/back-office panel | Backend API | Shared library. One part only → single-part system.
- Actively look for cross-part signals: data objects appearing in multiple parts, roles existing in only one part, journeys requiring actions in several parts, backend rules visible in multiple frontends.
- List every part with its label before Step 2.

### 2. Read and Extract Business Meaning

**Mandatory file inventory first (FORCE STEP)**: inventory every source, test, configuration, migration, and documentation file under the discovered parts — before reading any content. Cross-reference frontend files against discovered routes — any file not in a route must be traced to its usage (modals, tabs, conditional rendering). Classify every file in Pass 1; deep-read only business-relevant files in Pass 2 — no file is silently excluded before classification.

**Reading discipline (two-pass, evidence-driven)**:
- **Pass 1 — Structural inventory**: classify every file via manifests, entry points, routes, imports, source roots, APIs, data models, migrations, tests, jobs, and integrations — without reading full contents. Record per file: `path`, `classification` (business | technical-support | generated | configuration | test), `scan_depth` (structural | deep), `business_relevance`, `reason`.
- **Pass 2 — Evidence-driven deep read**: deep-read only files reachable from screens, implementing business APIs, containing policy/validation, state transitions, permission enforcement, data constraints, or automated business processes. For each deep-read file record the business action/rule/data it reveals; for every service/logic method ask what business decision it makes (10 methods = 10 potential rules).
- Never claim a file was deep-read when only its structure was scanned; the classification record is the honest coverage artifact. Repeat for every part, labeling findings with the source part.

#### Step A — Frontend (primary source, always first if present)

| Layer | Inventory every file; deep-read business-relevant files (Pass 1 → Pass 2) | Extract (translate, do not copy) |
|---|---|---|
| Routing/Pages | every route file + page/folder name | screen names + navigation ("User List Screen") |
| Access Control | every auth/role guard | who can access which screen (plain role names) |
| Forms & Inputs | every form, validation rule, field definition | what users fill in + every enforced input rule |
| Interactions | every page and feature component | every button, action, selection, search, trigger per screen |
| State & Data | every store/slice/context/binding | everything displayed; filter/sort options |
| Errors/Empty | error messages, empty states, toasts | what the system says when something fails or is empty |

Produce: 1) exhaustive screen inventory grouped by role (12 screens found = 12 listed); 2) journey map — every screen belongs to ≥1 named end-to-end journey; 3) all actions per screen (not just the main one); 4) all user-visible validation rules and error texts; 5) all statuses/states shown ("Pending", "Approved"...).

#### Step B — Backend (full independent extraction — not just filling frontend gaps)

| Layer | Inventory every file; deep-read business-relevant files (Pass 1 → Pass 2) | Extract |
|---|---|---|
| Specs/Docs | `.spec/`, `docs/`, README files | requirements, constraints, stated goals |
| API/Controllers | every controller and route handler | business action per endpoint ("Create User", "Process Payment") |
| Business Logic | every method in every service/use-case/handler | each method = one rule/action: what decision it makes, what it allows/prevents |
| Data | every entity/model/schema/migration/enum + every DB constraint, unique index, check constraint, trigger | business objects, meaningful fields, statuses in plain values (`STATUS_PENDING` → "Waiting for approval"), rules hidden in constraints |
| Security | every security config, role definition, permission list, JWT claim | role capabilities in plain terms ("Sales Manager can view but not edit prices") |
| Config | every config/env file | limits, thresholds, defaults ("max file size 10 MB", "logout after 30 min idle") |
| Tests | every test name + assertion | intended business behavior proven |
| Comments | every TODO/FIXME/HACK/NOTE | risks, open questions, business impact |
| Errors | every custom error/exception/message string | what can go wrong; what the system refuses to do |
| Validators | every validator class, constraint annotation, pre-save hook, AOP aspect | rules enforced on data before acceptance |
| Events | every event listener, queue consumer, webhook handler | "when X happens, the system does Y" |
| Scheduled | every `@Scheduled`/cron/batch/background worker | automated processes, triggers, outcomes |
| SQL | every native query, stored procedure, view, trigger in migrations/`.sql`/code | record filters, hardcoded status rules, aggregations, computed fields |

Produce: 1) complete API→business mapping; 2) numbered business-rules list (who / when triggers / allows-prevents — include minor ones); 3) backend-only journeys (automated processes with no user screen); 4) full data picture (objects, fields, relationships, lifecycles); 5) role & permission picture; 6) system limits & policies; 7) state-machine transitions (every status, condition, trigger, side effects like notifications/audit).

Tests and comments follow the two-pass rule: structurally inventory all of them; deep-read only those connected to business behavior, risk, constraints, or selected business-relevant source files.

#### Step C — Merge into One Business Picture

- Frontend only → mark backend-dependent facts `TBD`. Backend only → derive journeys from logic/data flows; for screens, set `screens` to an empty array with a business-language `screens_note` — never create invented or placeholder screens. Both → merge:
- Backend rules not visible on any screen → `99-facts.json` business_rules as BR-###, noted "Enforced by the system, not shown to the user"
- Backend-only journeys → `02-scope-context.md` as "System Journey" + `99-facts.json` system_journeys
- Backend-only data objects → `99-facts.json` data_entities with `visible_to_user: false`
- Backend roles with no frontend guard → `99-facts.json` roles
- **Multi-part merge**: cross-part journeys stay ONE journey with `[Customer App] Step 1`, `[Admin Panel] Step 2` labels; shared data concepts merge into one entry noting role visibility ("Customer (read-only), Admin (full access)"); all roles compile into one roles list; scope grouped by part in `02-scope-context.md` ("**Customer App**: ...", "**System (automated)**: ..."); part interactions in `02-scope-context.md` §Integration Points in plain language.
- **Flag gaps in `99-facts.json`** (mismatches + open_questions): screens with no backend logic behind them; backend capabilities no screen exposes ("Should this be exposed to users?"); backend rules contradicting frontend validation; capabilities missing where expected.

### 2.5 Pause and Confirm (REQUIRED when frontend exists)

Before generating any file, output a live summary populated with actual discovered data (never placeholders):
1. `## Discovered Business Picture — <project name>`
2. **Parts Read**: "Customer App (frontend) | Admin Panel (frontend) | Backend API (backend)" or "Single project — <name>"
3. **User Journeys** table: Name | Who Does This | Parts Involved | Screens
4. **System Journeys** table (omit if none): Process | Trigger | Business Effect
5. **Screens Inventory** table, grouped by part: Part | Screen | Who Can Access | Main Actions
6. **Backend Business Rules**: count only ("Found N rules; these will be added to Requirements")
7. **Open Questions** (omit if none)

Close with: `Please confirm, correct, or add to this list. Type 'ok' to proceed, or tell me what to change.` — wait for confirmation in `mode=interactive` (skip for backend-only projects). In `mode=auto`, do not pause: present the same summary, mark uncertain findings with `confidence` values and open questions, and continue. In `mode=resume`, continue from the approved checkpoint instead of re-deriving the picture.

### 2.7 Per-Screen Extraction Records (MANDATORY before generating any file)

Per-screen extraction records are JSON working records — not Markdown:

- Save them in the reconciliation checkpoint (`.work/reconciliation.json`).
- Validate them against the `99-facts.json` screen schema before generation.
- Render human-readable screen summaries into `00-ai-index.md` and `02-scope-context.md` only when generating those files.

Every action declares one `interaction_type` — backend process, client-side interaction, navigation, external integration, or unknown; backend and external actions include the business process and `technical_refs`; client-side actions describe the local state or presentation effect; never invent an API link for actions that do not call a backend.

Build every screen record using this structure — fields: `id` (`SCR-###`) · `name` · `source_part` · `roles` · `journey_ids` · `displayed_data` · `fields` (each: `name`, `required`, `rules`, `confidence`, `evidence`) · `actions` (each: an action record as below) · `visible_rule_ids` · `silent_rule_ids` · `errors` · `empty_states` · `confidence` · `evidence` — generate as normal JSON without the example indentation:

    {
      "id": "SCR-001",
      "name": "Order List",
      "source_part": "Customer App",
      "roles": ["Customer"],
      "journey_ids": ["J-001"],
      "displayed_data": [
        "Order number",
        "Submission date",
        "Current status"
      ],
      "fields": [
        {
          "name": "Status filter",
          "required": false,
          "rules": [],
          "confidence": "confirmed",
          "evidence": []
        }
      ],
      "actions": [],
      "visible_rule_ids": ["BR-003"],
      "silent_rule_ids": [],
      "errors": [],
      "empty_states": [],
      "confidence": "confirmed",
      "evidence": []
    }

**Gate before Step 3** — per screen: ≥1 action documented (else flag as mismatch); every field has a rule (else `TBD` + flag); all displayed data listed; all backend rules captured; client-side and navigation actions are valid — only `unknown` interaction types are flagged for follow-up; every record validates against the screen schema. Backend-only projects: apply the Step C backend-only fallback (rules → BR-###, automated processes → System Journeys, data objects → data_entities, roles → roles, `screens: []` + `screens_note` in `99-facts.json`).

Example action records — fields: `label` · `interaction_type` · `business_effect` · `business_process` (null for client-side) · `technical_refs` (each: `method`, `path`, `symbol`; empty for client-side) · `confidence` · `evidence` — generate as normal JSON without the example indentation. Client-side action:

    {
      "label": "Filter by status",
      "interaction_type": "client-side interaction",
      "business_effect": "Limits displayed records to the selected status",
      "business_process": null,
      "technical_refs": [],
      "confidence": "confirmed",
      "evidence": [
        {
          "path": "src/app/orders/order-list.component.ts",
          "symbol": "applyStatusFilter",
          "lines": "72-84",
          "evidence_type": "business-logic"
        }
      ]
    }

Backend action:

    {
      "label": "Submit order",
      "interaction_type": "backend process",
      "business_effect": "Sends the completed order for processing",
      "business_process": "Order submission",
      "technical_refs": [
        {
          "method": "POST",
          "path": "/api/orders",
          "symbol": "OrderController#create"
        }
      ],
      "confidence": "confirmed",
      "evidence": []
    }

### 3. Output Directory

`<project-root>/docs/ba/<module-name>/` — create if missing.

### 4. Generate the 6 Files

Generate exactly these 6 published files (internal working artifacts under `docs/ba/<module>/.work/` — checkpoints, ID registry, backups, coverage — are allowed and are NOT part of the published document set):

1. `README.md` — entry point + health summary
2. `00-ai-index.md` — AI navigation layer
3. `02-scope-context.md` — journeys + journey-map diagrams + system journeys + integrations + limitations
4. `10-technical-map.md` — architecture + Data Model + Status Lifecycle diagrams + command mapping (technical language allowed)
5. `11-code-map.md` — source file → business concept map (technical language allowed)
6. `99-facts.json` — machine-readable fact base (authoritative home for rules, stories, criteria, entities, statuses, glossary, KPIs, assumptions, constraints, mismatches, open questions)

**Pre-generation check** per file: does not exist → **CREATE**; exists → **UPDATE** only generated regions; accurate and complete → **SKIP**. Report per file at the end: `CREATED` | `UPDATED (sections: ...)` | `SKIPPED (already up to date)`.

**Ownership markers (protect human edits)** — generated content lives inside deterministic regions; human-maintained content lives inside protected regions. Marker prefixes: `SPECKIT:GENERATED:BEGIN` + `SPECKIT:GENERATED:END` delimit generated regions; `SPECKIT:HUMAN:BEGIN` + `SPECKIT:HUMAN:END` delimit human regions; each marker wraps an HTML comment around the prefix plus `section=<stable-section-name>`. Generate these markers as normal text without the example indentation:

    <!-- SPECKIT:GENERATED:BEGIN section=journeys -->
    Generated content
    <!-- SPECKIT:GENERATED:END section=journeys -->

    <!-- SPECKIT:HUMAN:BEGIN section=business-notes -->
    Human-maintained content
    <!-- SPECKIT:HUMAN:END section=business-notes -->

Update rules: replace generated regions deterministically; never overwrite human regions; report conflicts between human assertions and current code evidence; create a backup or diff of the previous version before updating existing documentation (saved under `.work/backups/<timestamp>/`); never silently delete a stable fact ID. Marker failure behavior: a generated BEGIN marker without its matching END marker is BLOCKED; duplicate stable section names in one file are BLOCKED; human regions are never modified; content outside recognized generated regions is treated as human-owned. Marker contract: section names are lowercase kebab-case and unique within one file; nested ownership regions are not allowed; JSON files do not use Markdown comment markers.

**JSON ownership exception (`99-facts.json`)** — the complete JSON document is generated (HTML comments would make it invalid JSON). Human-maintained overrides are preserved in `.work/human-overrides.json`, merged by stable fact ID; conflicts between source evidence and human overrides are reported; ownership comments are never inserted into JSON.

**Writing rules**: business-language files write for a product owner (see Global rules for the file scoping); every row/bullet says something real (no placeholders); `TBD` only with the controlled accompaniments defined in Global rules; journeys are the top-level structure — screens are steps inside them. Navigation: `README.md` is the documentation home and carries no back-navigation header; `00-ai-index.md` starts `[← Documentation Home](./README.md)`; every other published Markdown file starts `[← Documentation Home](./README.md) · [AI Index](./00-ai-index.md)` and ends with prev/next navigation (none at the ends); `99-facts.json` receives no Markdown navigation links.

#### Templates (inline below — do NOT read example sets under `docs/ba/`)

- **00-ai-index.md** (FIRST file — AI navigation layer, plain business language, dense):
  - Title line: "AI Index — read this file first; it maps every question to the file and section that answers it."
  - **Reading strategy** (the AI reading path, verbatim): 1) answer from this index; 2) for structured lookups load `99-facts.json`; 3) to touch code use `11-code-map.md`; 4) deep-read a business file only when narrative is needed.
  - **Question → location routing table** (Question | Read: file + section anchor) covering at minimum: what the system does; who uses it; all screens and their actions; all input fields and validation; all business rules; why the system refuses/rejects something; data objects and fields; statuses and transitions; journeys end-to-end; automated background processes; integrations; known gaps/risks; glossary; grep-able structured facts (`99-facts.json`); which source file implements a concept (`11-code-map.md`).
  - **One-line inventory tables** with anchor links to detail sections: Journeys (Name | Who | Parts | Screens | Link); System Journeys (Process | Trigger | Effect | Link); Screens (Screen | Part | Roles | #Actions | Link); Business Rules (BR-### | one-line rule | Link); User Stories (ID | one-line story | Link); Data Entities (Entity | Key fields | Link); Roles (Role | Part(s) | What they do | Link); Diagrams (Diagram | Type | File + anchor).
  - Stable IDs everywhere (`BR-###`, `US-###`, `AC-###`, `J-###`, exact screen names) so AI answers can cite and link precisely.
  - Every row links to its section anchor; counts match the README Health Summary; no placeholders, no prose paragraphs.
- **99-facts.json** (machine-readable fact base — for deterministic AI parsing, filtering, and grep):
  - Valid JSON, UTF-8. Top-level keys: `module`, `generated`, `parts`, `roles`, `journeys`, `system_journeys`, `screens`, `business_rules`, `user_stories`, `acceptance_criteria`, `data_entities`, `statuses`, `integrations`, `background_processes`, `limits`, `assumptions`, `constraints`, `mismatches`, `kpis`, `glossary`, `open_questions`, `diagrams`.
  - Every item carries a `doc` field linking back to the human-readable file + anchor (in ai mode, re-homed categories point to `99-facts.json` itself as the authoritative home); IDs match the Markdown set exactly (`BR-###`, `US-###`, `AC-###`, `J-###`, screen names).
  - Every fact carries `confidence` (`confirmed | derived | suggested | unknown`) and `evidence` — source references with `path`, `symbol`, `lines`, and `evidence_type` (business-logic, test, configuration, constraint, comment) — so planning commands can weigh the fact.
  - Strings are one-liners; narrative lives in the Markdown files, never here.
  - Backend-only modules: `screens: []` plus a `note` field; every other key still fully populated.
- **11-code-map.md** (technical file map — bridges business concepts to source files; technical language allowed):
  - Per part: table `File | Purpose (one line) | Key items (routes/classes/tables/stores) | Implements (business concept + rule/journey IDs) | Notes`.
  - Coverage: every file from the Step 2 inventory appears, or is listed under a "Skipped" section with the reason (generated/boilerplate/non-business).
  - Purpose: an AI jumps question → rule/journey ID → exact source files without re-scanning the codebase.
- **README.md**: what the system does + who uses it; Health Summary table (counts: journeys, screens, rules, buttons, fields, TBDs, mismatches); Contents table (file | one-line description | status) with `00-ai-index.md` as the first row; a note: "AI agents: start with `00-ai-index.md` — then `99-facts.json` for structured facts, `11-code-map.md` to reach source files."
- **02-scope-context.md**: `# 2. Scope & Context` — What Is Built (capabilities grouped by part: "**Customer App**: ..."); How It Works Today (As-Is narrative); End-to-End Business Flow (per journey: step table Step | Screen [Part] | User Action | System Response); Journey Map Mermaid diagram (one path per journey, part-labeled); System Journeys; Integration Points; Current Limitations.
- **10-technical-map.md**: technical architecture overview, Architecture Mermaid diagram (parts + main components + integrations), Background Processes Mermaid diagram (scheduled/event-driven, omit if none), API-to-business mapping table, integration points, background processes, Data Model Mermaid diagram (erDiagram of business objects), Status Lifecycle Mermaid diagrams (stateDiagram-v2 per status-bearing object). (This file MAY use technical terms — it is for implementers.)

#### Mermaid Diagrams (mandatory, embedded in the files above)

Every document set includes these Mermaid graphs, kept in sync with the tables (no invented data), each ≤ ~15 nodes, labels in plain business language (except `10-technical-map.md`, which may use technical terms):

| Diagram | File | Type | Content |
|---|---|---|---|
| Journey Map | `02-scope-context.md` | `flowchart LR` | One path per journey through its screen steps, nodes labeled `Screen [Part]` |
| Data Model | `10-technical-map.md` | `erDiagram` | Business objects, meaningful fields, relationships and cardinalities |
| Status Lifecycles | `10-technical-map.md` | `stateDiagram-v2` | Every status of a status-bearing object and what moves it forward/back (one diagram per object) |
| Architecture | `10-technical-map.md` | `flowchart TB` | Parts, main components, integrations |
| Background Processes | `10-technical-map.md` | `flowchart LR` | Scheduled/event-driven processes, triggers, outcomes (omit if none) |

Diagram writing rules: wrap in ` ```mermaid ` fences; never use `end` as a node/state label (breaks Mermaid — use `Finish`); quote labels containing parentheses, slashes, or commas; a 1-step journey still gets its path; omit a diagram only when its subject does not exist and note the omission in the file; every diagram appears in the `00-ai-index.md` Diagrams table.

### 5. Quality Checks Before Saving

- **Coverage (first)**: final screen list must match the Mandatory file inventory and the Per-Screen Extraction Records; no orphan component files (assign to a screen or mark shared/utility); every screen's record from 2.7 is fully captured in the `99-facts.json` screens array; every action/field/rule/error/data item appears there AND in its cross-target (rules → business_rules, steps → journey steps in `02-scope-context.md`, data → data_entities); every `00-ai-index.md` row has a working anchor link and its counts match the README Health Summary and the fact base.
- **Diagrams**: every required Mermaid diagram present (or omission noted); syntax-safe (no bare `end` labels; special characters quoted); content matches the tables — no invented nodes/edges; all diagrams listed in the `00-ai-index.md` Diagrams table.
- **Machine-readable**: `99-facts.json` parses as valid JSON; it is the authoritative home for rules, stories, criteria, entities, statuses, glossary, KPIs, assumptions, constraints, mismatches, and open questions; every item has a `doc` anchor; IDs match the Markdown set exactly.
- **Code map**: every file from the Step 2 inventory appears in `11-code-map.md` or in its Skipped list with a reason; every mapped file references the business concepts (rule/journey IDs) it implements.
- **Terminology validation (scoped)**: apply the business-language hard ban ONLY to `README.md`, `00-ai-index.md`, `02-scope-context.md`, and business-facing fields in `99-facts.json` — rewrite hits (endpoint URLs, HTTP verbs, class/method names, DTO/entity names, framework terms, table names, config keys) into plain business language before saving. Technical language is allowed and expected in `10-technical-map.md`, `11-code-map.md`, and evidence/source-reference fields in `99-facts.json`; in mixed files validate each field per its declared audience. Do not remove source paths, symbols, routes, schema objects, or technical identifiers from the technical maps.
- **Content**: no blank sections (`TBD` + note only when no code evidence); stories in As a/I want/So that with journey reference; rules note enforcement layer + type; journey steps trace screens/actions/responses with no technical trace; navigation links present; AI-readable and stakeholder-readable.

### 6. Output Confirmation

- List all 6 generated files with full paths + status (CREATED / UPDATED / SKIPPED).
- Summarize in business language: journeys (names); system journeys; screens (count + list); roles; rule counts by kind (frontend-visible / backend-only / validator / event-driven / scheduled / state-machine / DB-constraint); buttons, fields, error-message totals; diagrams generated (count by type); fact-base item counts (per key); code-map coverage (files mapped / skipped); mismatches flagged; skipped files (why); feature flags found; `TBD` sections with what is missing.
- Suggest follow-ups: `/speckit.specify feature="..."` to convert this BA set into a technical spec; `/speckit.document-generate module="..."` for another module.
- End with a deterministic quality verdict:
  - **BLOCKED** — invalid JSON; unmapped discovered files; unrecorded screens; broken stable-ID references; a missing mandatory output; or contradictory authoritative facts.
  - **COMPLETE_WITH_GAPS** — no structural blockers, but TBDs, open questions, or low-confidence findings remain.
  - **COMPLETE** — coverage and consistency checks pass and no material unresolved gaps remain.
