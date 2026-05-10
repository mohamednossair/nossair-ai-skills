---
description: Reverse-engineer an 11-file Technical Business Analysis document set from the current codebase
---
Act as a Business Analyst. Generate a BA document set from code.

## Actions
1. **Discover**: Identify all parts (frontend, backend, admin) of the system. Use fallback heuristics for non-standard structures (`main` entry points, `Dockerfile`, build files, dominant file type).
2. **Extract**: Read every file and extract business meaning. Scan 12 backend layers:
   - Services, APIs, Data/Entities, Security, Config, Tests, Comments, Errors
   - **Validators / Constraints**, **Event Listeners**, **Scheduled / Batch Jobs**
   - **SQL / Stored Procedures / Views**, **DB constraints / triggers**
3. **Awareness areas**:
   - Skip generated / boilerplate code (protobuf, OpenAPI, JPA metamodel, GraphQL generated).
   - Detect and document **feature flags / toggles** that gate business behavior.
   - Extract **state-machine and workflow transition rules** (status meanings, transition conditions, triggers, side effects).
4. **Merge**: Unify all parts into one coherent business picture.
5. **Document**: Generate 11 files under `docs/ba/<module>/`:
   - README.md (index)
   - 01-overview.md through 10-technical-map.md

## Key Principles
- **Always unified**: Treat all sub-projects as one integrated system.
- **Two-layer output**: Business language first, technical notes in `> 🔧 Technical Notes` blocks.
- **Exhaustive coverage**: Document every screen, API, button, field, and rule.
- **Product owner readable**: No technical jargon in main sections.
- **Generated code skip**: Do NOT read or document auto-generated code.
- **Feature flag awareness**: Flagged business rules are still business rules — document them.

## Banned Terms in Output
Never include in generated documents: API URLs, HTTP methods, class names, method names, DTO/entity names, framework terms, database table names, config keys.

## Output
List of 11 files with status (CREATED/UPDATED/SKIPPED) and summary of findings including:
- User journeys, screens, roles
- Business rules by source: frontend-visible, backend-only, validator-based, event-driven, scheduled-job, state-machine, DB-constraint
- Files skipped (generated code), feature flags / toggles found, mismatches flagged
