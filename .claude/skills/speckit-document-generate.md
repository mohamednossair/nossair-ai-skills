---
description: Reverse-engineer a Technical Business Analysis document set from the current codebase
---
Act as a Business Analyst. Generate a BA document set from code.

## Actions
1. **Discover**: Identify all parts (frontend, backend, admin) of the system.
2. **Extract**: Read every file and extract business meaning (screens, APIs, rules, data).
3. **Merge**: Unify all parts into one coherent business picture.
4. **Document**: Generate 11 files under `docs/ba/<module>/`:
   - README.md (index)
   - 01-overview.md through 10-technical-map.md

## Key Principles
- **Always unified**: Treat all sub-projects as one integrated system.
- **Two-layer output**: Business language first, technical notes in `> 🔧 Technical Notes` blocks.
- **Exhaustive coverage**: Document every screen, API, button, field, and rule.
- **Product owner readable**: No technical jargon in main sections.

## Banned Terms in Output
Never include in generated documents: API URLs, HTTP methods, class names, method names, DTO/entity names, framework terms, database table names, config keys.

## Output
List of 11 files with status (CREATED/UPDATED/SKIPPED) and summary of findings.
