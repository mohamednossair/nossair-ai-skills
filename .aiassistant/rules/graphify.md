---
apply: always
---

# Graphify: Query the Knowledge Graph First

When `graphify-out/graph.json` exists in the project, answer codebase questions from the graph before grepping or reading files. Full skill: `.junie/skills/graphify/SKILL.md`.

## Escalation Ladder (cheapest sufficient step first)

1. `graphify query "<question>"` — architecture/relationship questions ("what connects the controller to the Oracle tables?"). Cap output with `--budget N` (default 2000 tokens); use `--seed <file path>` for precision.
2. `graphify explain "Symbol"` / `graphify path "A" "B"` / `graphify affected "Symbol"` — one node with connections, a connection path, or reverse impact radius.
3. Grep — only for exact string/line-level lookups the graph cannot answer.
4. Read files — only the specific files the graph pointed to.

## Rules

- One freshness check per session (not per query): if `graphify-out/graph.json` is older than the last commit, run `graphify update .` once before trusting answers.
- Cite edge tags: `EXTRACTED` (explicit in source) vs `INFERRED` (resolved by graphify). Confirm critical claims in the source file before asserting them.
- Never read `GRAPH_REPORT.md` wholesale to answer a question — query the graph; the report is for broad human review.
- Exit codes: `0` answer, `3` ambiguous name (candidates listed — ask, never guess), `4` no match.
- The IDE's own index handles single-symbol navigation; use the graph for cross-file relationships, impact analysis, and architecture questions the index cannot answer.
- MCP alternative: the local server `graphify-mcp` (ten query tools) can be connected via the IDE's MCP settings instead of terminal commands.

## Speckit

- `/speckit.plan` research and `/speckit.tasks` `[P]` conflict checks use the graph when `graphify-out/graph.json` exists — see `.junie/commands/speckit.plan.md` (step 6) and `.junie/commands/speckit.tasks.md` (step 7).
- Build the graph BEFORE `/speckit.implement` (building writes `graphify-out/`; queries are read-only).
