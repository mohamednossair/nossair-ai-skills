---
description: Generate unit tests for provided code without requiring feature-spec linkage
---

**Usage**: `/test-generate file="..." [action="preview|write"]`

This command is a thin unlinked wrapper around the canonical generator `/speckit.test-generate`. It never resolves or uses feature specifications — use `/speckit.test-generate` for specification-linked testing.

1. Delegate test generation to `/speckit.test-generate` with `allow_unlinked=true` (the canonical command then performs no automatic specification discovery when no explicit `spec` is supplied).
2. Pass `action` through unchanged (default `preview` — outputs proposed test content without modifying files; `write` creates or updates the test file after existing-test inspection and scope checks).
3. Framework selection (repository configuration → plan Standards → technology skill → fallback default: JUnit 5 + AssertJ for Java, Jest for TypeScript/Angular, pytest for Python), existing-test inspection, naming conventions, mocking rules, write safety, and the traceability summary are defined by the canonical command — do not duplicate that logic here.
