---
name: test-generate
description: Generate unit tests for provided code without requiring feature-spec linkage — thin unlinked wrapper around the canonical /speckit-test-generate generator; never resolves or uses feature specifications
argument-hint: 'file="path/to/file" [action="preview|write"]'
allowed-tools:
  - read
  - grep
  - glob
  - exec
  - edit
  - write
triggers:
  - user
  - model
---

Run the **test-generate** unified command.

1. Read and follow `.junie/commands/test-generate.md` exactly — it is the source of truth for all agents.
2. This command is a thin unlinked wrapper: delegate test generation to `/speckit.test-generate` with `allow_unlinked=true`; do not resolve or require a specification unless one is explicitly supplied; pass `action` through unchanged (default `preview` — no file modification).
3. Framework selection (repository configuration → plan Standards → technology skill → fallback default: JUnit 5 + AssertJ for Java, Jest for TypeScript/Angular, pytest for Python), existing-test inspection, naming conventions, mocking rules, write safety, and the traceability summary are defined by the canonical command — do not duplicate that logic here.
4. Arguments: file="<path/to/source>" (required); action="preview|write" (optional, default preview)
