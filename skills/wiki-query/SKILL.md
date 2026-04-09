---
name: wiki-query
description: >
  Search the States Media wiki and answer questions with citations.
  Reads index.md, finds relevant pages, synthesizes an answer with [[wikilink]] citations.
user-invocable: true
argument-hint: "<question>"
---

# Wiki Query

Search the company wiki and answer with citations.

## Quick Start

```
/wiki-query "quais ferramentas a gente usa?"
/wiki-query "quem trabalha com marketing?"
```

## Activation

1. Parse question from `$ARGUMENTS`
2. If no question provided, ask the user
3. Execute the query pipeline below

## Pipeline

### Step 1 — Read the index

Read `~/states-media/wiki/index.md` to get the catalog of all pages.

### Step 2 — Identify relevant pages

Based on the question, identify which pages are likely relevant.
Consider:
- Direct keyword matches in page titles/descriptions
- Related topics that might contain the answer
- The glossary (`05-glossario.md`) for term definitions

### Step 3 — Read relevant pages

Read each relevant page (max 10 pages per query to keep it fast).

### Step 4 — Synthesize answer

Answer the user's question using ONLY information from the wiki pages.

Format:
```
[Answer in natural language]

**Fontes:**
- [[page-1]] — [what was found here]
- [[page-2]] — [what was found here]
```

### Step 5 — Handle gaps

If the wiki doesn't have enough information:

1. Tell the user honestly: "O wiki não tem informação suficiente sobre isso."
2. Suggest: "Quer que eu pesquise com /tech-search e depois salve no wiki com /wiki-ingest?"
3. If the user says yes, run tech-search and then wiki-ingest with the results.

### Step 6 — Offer to save valuable queries

If the answer synthesized new insights not in any single page:

"Essa resposta combina informações de várias páginas. Quer que eu salve como uma nova página no wiki?"

## Rules

1. **Only cite what exists.** Never invent information not in the wiki.
2. **Always cite sources.** Every claim should reference a `[[page]]`.
3. **Be honest about gaps.** Don't hallucinate answers — say when you don't know.
4. **Compound knowledge.** Good queries should flow back into the wiki as new pages.
