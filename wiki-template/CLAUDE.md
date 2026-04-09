# States Media — Wiki Schema

This is the LLM Wiki for States Media, based on the Karpathy LLM Wiki pattern.

## Architecture (3 Layers)

### Layer 1: Raw Sources (human-curated, LLM reads only)
- Location: `06-fontes-raw/`
- Content: PDFs, articles, documents, transcripts
- Rule: NEVER modify raw sources. They are immutable truth.

### Layer 2: Wiki Pages (LLM-maintained)
- Location: All folders except `06-fontes-raw/`
- Content: Summaries, entity pages, concept pages, synthesis
- Rule: LLM creates, updates, and cross-references these pages.

### Layer 3: Schema (this file)
- Location: This `CLAUDE.md`
- Content: Conventions, workflows, rules
- Rule: Governs how the LLM behaves as wiki maintainer.

---

## Operations

### INGEST — Add new knowledge

When the user provides a new source (article, PDF, document):

1. Read the source completely
2. Discuss key findings with the user
3. Create a summary page in the appropriate folder:
   - People → `01-pessoas/`
   - Business units/projects → `02-bus-e-projetos/`
   - Processes/SOPs → `03-processos/`
   - Tools/tech → `04-ferramentas/`
   - Other → root level
4. Update `index.md` with the new page (one-line summary)
5. Cross-reference: update ALL related existing pages with `[[wikilinks]]`
6. Append entry to `log.md`:
   ```
   ## [YYYY-MM-DD] ingest | Source Title
   - Source: filename or URL
   - Pages created: [[page1]], [[page2]]
   - Pages updated: [[page3]], [[page4]]
   - Key insights: bullet list
   ```
7. Move/copy raw source to `06-fontes-raw/`

### QUERY — Search the wiki

When the user asks a question:

1. Read `index.md` to find relevant pages
2. Read the relevant pages
3. Synthesize answer with `[[citations]]` to specific pages
4. If the answer reveals new insights worth keeping, offer to create a new page

### LINT — Audit the wiki

Periodically check for:

- Orphan pages (not linked from anywhere)
- Broken `[[wikilinks]]`
- Contradictions between pages
- Stale information (pages not updated in 30+ days)
- Missing cross-references
- Pages without frontmatter
- `index.md` out of sync with actual pages

Report findings and suggest fixes.

---

## Page Conventions

### Frontmatter (YAML)
Every page MUST have:
```yaml
---
title: Page Title
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [tag1, tag2]
sources: [source1, source2]
---
```

### Wikilinks
- Use `[[page-name]]` for internal links
- Use `[[page-name|display text]]` for custom display text
- Link liberally — more connections = more useful wiki

### Naming
- Lowercase with hyphens: `nome-da-pagina.md`
- No spaces, no special characters
- Descriptive but concise

---

## Folder Structure

| Folder | Content | Examples |
|--------|---------|---------|
| `01-pessoas/` | People (team, clients, partners) | `denis.md`, `time-marketing.md` |
| `02-bus-e-projetos/` | Business units and active projects | `nutra-dr.md`, `boosted-meds.md` |
| `03-processos/` | SOPs, workflows, how-tos | `onboarding.md`, `media-buying.md` |
| `04-ferramentas/` | Tools and tech stack | `redtrack.md`, `claude-code.md` |
| `06-fontes-raw/` | Raw source documents (immutable) | PDFs, article downloads |
| `99-experimentos/` | Sandbox for testing | Anything goes |

---

## Rules

1. **Never invent.** Only write what comes from sources or user confirmation.
2. **Always cite.** Every claim should trace to a source or `[[page]]`.
3. **Update, don't duplicate.** If a page exists, update it rather than creating a new one.
4. **Log everything.** Every ingest and major edit gets a `log.md` entry.
5. **Link generously.** Cross-reference related pages with `[[wikilinks]]`.
