---
name: graphify
description: Knowledge-graph codebase understanding via the Graphify CLI — build, query, impact analysis, exports, and multi-repo graphs instead of grepping files
---

# Graphify Skill

Use this skill to build and query a knowledge graph of the codebase (code, docs, SQL schemas, configs, PDFs) with the Graphify CLI. Code is parsed locally with tree-sitter AST — deterministic, no LLM, no vector store. Query the graph instead of grepping files. Full reference: https://docs.graphify.com/reference/overview (checked against `graphifyy` 0.9.97).

## When to Use
- Architecture questions: "what connects this controller to the Oracle tables?"
- Impact analysis before changing a service: `graphify affected "<symbol>"` — what depends on it.
- Tracing a call path or understanding an unfamiliar module.
- Speckit research: `/speckit.plan` research phase, `/speckit.tasks` conflict checks, `/speckit.implement` dependency checks.
- Do NOT use as a replacement for vector search (e.g., Qdrant) on documents — Graphify maps code/architecture knowledge; vector stores retrieve document semantics. They complement each other.

## Prerequisites
- Python 3.10+ and `uv` (or `pipx`).
- Install: `uv tool install graphifyy` — the PyPI package is `graphifyy` (double y); the CLI command is `graphify`.
- Check: `graphify --version`.
- Optional extras: `uv tool install "graphifyy[pdf]"` (PDFs), `"graphifyy[sql]"` (SQL schemas), `"graphifyy[office]"` (.docx/.xlsx), `"graphifyy[mcp]"` (MCP server), `"graphifyy[watch]"` (auto-rebuild), `"graphifyy[neo4j]"` / `"graphifyy[falkordb]"` (DB push), `"graphifyy[all]"`.
- Optional official assistant registration: `graphify install` (auto-detects the assistant) or `graphify devin install` — not required when this skill is present.

## First-Time Project Setup (per target project)

Run once per project — ask the user first, since `hook install` writes `.git/hooks/`:

1. `graphify hook install` — auto-rebuilds the graph on commit, checkout, merge, and rewrite, and registers a merge driver for `graph.json`. Manage with `graphify hook status` / `uninstall`.
2. Commit a `.graphifyignore` (gitignore syntax, `!pattern` re-includes) ONLY for graph-specific noise the built-in skips miss — `target/`, `node_modules/`, `dist/`, `build/`, `.angular/`, lock files, and `.env` are already skipped by default:
   ```gitignore
   # Generated clients
   src/generated/
   *.pb.go
   # Huge repetitive fixtures (keep specific ones back with !)
   tests/fixtures/
   ```
3. Optional `.graphifyrc` at the scan root for ambiguous extensions (e.g. `language.inc=php`) and `viz_node_limit`.
4. During active dev, run `graphify watch .` (needs the `watch` extra) to rebuild on every save.
5. After changing ignore rules, refresh once with `graphify extract . --force`.

## Build the Graph

| Command | Purpose |
|---------|---------|
| `graphify .` | Build the graph for the current folder |
| `graphify extract . --code-only` | Code-only, fully offline (no LLM backend needed) |
| `graphify extract . --backend B --model M` | Choose the model for the docs/PDF semantic pass |
| `graphify extract . --mode deep` | More aggressive `INFERRED` edges |
| `graphify extract . --postgres DSN` | Add tables/views/FKs from a live PostgreSQL DB |
| `graphify update .` | Re-extract changed code without a model (run after `git pull`) |
| `graphify watch .` | Re-extract on every save (needs the `watch` extra) |

Useful flags: `--exclude PATTERN` (repeatable), `--force` (full re-scan), `--out DIR`, `--no-cluster`, `--max-workers N`.

Outputs (in `graphify-out/`): `graph.html` (interactive), `GRAPH_REPORT.md` (god nodes, communities, key paths), `graph.json` (the full graph).

## Query the Graph

| Command | Purpose |
|---------|---------|
| `graphify query "<question>"` | Scoped subgraph for a plain-language question (`--budget N` caps tokens, default 2000; `--seed X`, `--context C`, `--dfs`) |
| `graphify explain "Symbol"` | One node: source location, connections, community (`--all` for every connection) |
| `graphify path "A" "B"` | Shortest path between two symbols (`--undirected` to ignore edge direction) |
| `graphify affected "Symbol"` | Reverse walk: what depends on this node (`--depth N` default 2, `--relation calls` repeatable) |
| `graphify god-nodes --top 10` | Most-connected nodes (add `--json` for scripts) |

- Every edge is tagged `EXTRACTED` (explicit in the source) or `INFERRED` (resolved by graphify) — cite the tag when reporting findings.
- Exit codes for scripts: `0` answer, `3` ambiguous name (candidates printed — never guess), `4` no match.
- Disambiguation quirk: for ambiguous names, `explain`/`path` accept `path::symbol` (e.g. `src/path/models.py::Symbol`); `affected` requires the full node id printed by the ambiguity error (e.g. `src_path_models_symbol`).
- `query` matching uses label words, not full sentences — use names from the code.

## Communities, Labels, Work Memory

| Command | Purpose |
|---------|---------|
| `graphify . --cluster-only` | Re-cluster without re-extracting (`--resolution`, `--exclude-hubs`, `--no-viz`, `--no-label`) |
| `graphify label .` | Rename communities with the model (`--missing-only` keeps existing names) |
| `graphify save-result --question "..." --answer "..." --nodes X --outcome useful` | Record a query outcome (`useful` / `dead_end` / `corrected`) |
| `graphify reflect` | Write `graphify-out/reflections/LESSONS.md` from recorded outcomes |

## Exports & Integrations

| Command | Output |
|---------|--------|
| `graphify export html` | `graph.html` (`--node-limit`, default 5000) |
| `graphify export callflow-html` | Mermaid architecture / call-flow page |
| `graphify export obsidian` | Obsidian vault notes and canvas |
| `graphify export wiki` | Markdown wiki articles |
| `graphify export svg` / `graphml` | `graph.svg` / GraphML |
| `graphify export neo4j` / `falkordb` | Cypher, or `--push URI` to a database (set `NEO4J_PASSWORD` / `FALKORDB_PASSWORD` env vars, never `--password`) |
| `graphify tree` | `GRAPH_TREE.html` collapsible tree |
| `graphify benchmark` | Token use of the graph vs reading every file |
| `graphify-mcp` | Local MCP server (ten tools; needs the `mcp` extra) |

## Architecture Docs Pipeline (docs that never go stale)

Refresh architecture documentation from the graph instead of writing it by hand. Suggested doc set: `project-overview.md`, `extraction-flow.md`, `database-design.md`, `agents.md`, `prompts.md` under `docs/architecture/` (or an architecture-skill folder).

| Graph output | Feeds |
|--------------|-------|
| `GRAPH_REPORT.md` (god nodes, communities) | `project-overview.md` — subsystem map |
| `graphify export callflow-html` | `extraction-flow.md` — Mermaid call flow |
| `graphify export wiki` | per-topic articles (services, agents, prompts) |
| `graphify export obsidian` | linked notes + canvas for exploration |
| `graphify query` on schema nodes (`sql` extra) | `database-design.md` — tables, FKs, mappings |

Loop: `graphify update .` → `graphify export wiki` (+ `callflow-html`) → refresh the doc set, citing graph nodes with file:line. Regenerate after significant merges; generated sections are derived artifacts — mark them and do not hand-edit them.

## Multi-Repo & Automation

| Command | Purpose |
|---------|---------|
| `graphify global add graphify-out/graph.json --as TAG` | Merge a repo graph into the global graph (`~/.graphify/global-graph.json`); `global list` / `remove TAG` / `path` |
| `graphify merge-graphs a.json b.json --out combined.json` | Combine graphs manually |
| `graphify clone <repo-url>` | Clone a repo and graph it |
| `graphify hook install` | Post-commit/checkout/merge/rewrite hooks + `graph.json` merge driver (`status`, `uninstall`) |
| `graphify prs` | PR dashboard: CI state, review status, graph impact (`--triage`, `--conflicts`, `prs 42` deep dive) |
| `graphify add <url>` | Fetch a web page/paper/video and add it to the graph |
| `graphify check-update .` | Cron-safe check for pending semantic re-extraction |

## Token Optimization Protocol

Escalation ladder — always spend the cheapest sufficient step:

1. `graphify query "<question>"` — architecture/relationship questions. Cap with `--budget N` (default 2000 tokens); `--seed <file path>` for precision.
2. `graphify explain` / `path` / `affected` — one node, a connection, or impact radius.
3. grep — exact string/line lookups only.
4. read — only the files the graph pointed to.

- **One freshness check per session**, not per query: `graphify-out/graph.json` mtime vs last commit; `graphify update .` once if stale.
- **Never read `GRAPH_REPORT.md` wholesale** to answer a question — it is for broad human review; query the graph instead.
- Prefer a `--code-only` graph for code questions (smaller graph, no backend needed).
- **Work memory loop**: after a query settles a question, record it — `graphify save-result --question "..." --answer "..." --nodes X --outcome useful|dead_end|corrected` — and run `graphify reflect` occasionally. `graphify-out/reflections/LESSONS.md` compounds across sessions and cuts repeated exploration.
- Measured reference (722-file codebase, code-only graph): full corpus ≈ 1.3M tokens vs ≈ 1.6k tokens per scoped query — run `graphify benchmark` on the project for its own number.

## Rules
1. **Query-first**: when a fresh graph exists, prefer `graphify query`/`path`/`explain`/`affected` over grep for architecture and dependency questions; fall back to grep/read for exact line-level detail.
2. **Freshness**: prefer automatic freshness (`graphify hook install`, see First-Time Project Setup); otherwise check `graphify-out/graph.json` modification time against the last commit and run `graphify update .` if stale before trusting answers.
3. **Evidence**: graph answers are leads, not proof — confirm critical findings in the source files (`graphify explain` gives file:line).
4. **Privacy**: code is parsed locally (nothing leaves the machine). Docs/PDFs/images need an LLM backend for the semantic pass — use `--code-only` when that is not wanted. No telemetry.
5. **Hygiene**: `graphify-out/` is a build artifact — do not commit it unless the team agrees; add it to `.gitignore`.
6. **Config**: honor `.graphifyignore` and `.graphifyrc` (declare ambiguous extensions like `.inc`/`.h` there).
7. **Secrets**: DB push passwords go in env vars (`NEO4J_PASSWORD`, `FALKORDB_PASSWORD`), never on the command line.

## Speckit Integration
- `/speckit.plan` (research): use `graphify query`/`path` to map affected components, callers, and data flow before writing research.md and data-model.md.
- `/speckit.tasks`: use `graphify affected`/`path`/`explain` for `[P]` conflict checks (shared files/interfaces) and per-task impact analysis.
- `/speckit.implement`: before editing, `graphify explain "<symbol>"` and `graphify affected "<symbol>"` to confirm dependencies. Respect the Mode Safety Invariant — queries are read-only, but building the graph writes `graphify-out/`, so build BEFORE starting `mode=plan|execute`.
- `/speckit.document-generate`: the graph is an evidence source for the code map, but facts still need file:line evidence per the BA contract.
- `/review` and `/review-pr`: use `graphify affected` for impact/blast-radius notes in findings.

## Checklist
- [ ] `graphify --version` works (or install steps provided)?
- [ ] Graph is fresh (rebuilt after recent changes)?
- [ ] Answers cite EXTRACTED/INFERRED and critical claims are confirmed in source?
- [ ] Impact analysis run (`graphify affected`) before proposing changes to shared components?
- [ ] `graphify-out/` not committed?
