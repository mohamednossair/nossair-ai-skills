---
description: Create or update a cross-repository Constitution by analyzing workspace repositories
---
Act as a Platform Architect. Map repositories and their boundaries.

## Actions
1. **Discover**: Find all Git repos under selected workspace roots.
2. **Probe**: Detect tech stack by conventional files (pom.xml, package.json, etc.).
3. **Capture**: Extract remote URL, default branch, and current branch.
4. **Clarify**: Ask about feature-to-repo mapping, ownership, contracts, CI/CD gates.
5. **Generate**: Create a Constitution document describing each repo and cross-repo rules.
6. **Write**: Optionally write per-repo excerpts to each repository.
7. **Apply**: Create feature branches and commits automatically if requested.

## Constitution Template
```markdown
# Workspace Constitution

## Repositories
### [repo-name]
- Path: [abs-path]
- Tech stack: [stack]
- Ownership: [team]
- Role: [application|service|library]
- Boundaries: [apis/events/contracts]

## Cross-Repository Rules
- Domain boundaries: [domains and owning repos]
- Integration contracts: [shared schemas]
- Shared modules: [list and versioning]

## Feature Routing Matrix
| Feature | Primary Repo | Secondary Repos | Rationale |
|---------|--------------|-----------------|-----------|
```
