---
name: wiki-ingest
description: >
  Ingest a document, PDF, article, or text file into the States Media wiki.
  Creates summary page, updates index.md, cross-references existing pages, logs activity.
  Follows the Karpathy LLM Wiki ingest pattern.
user-invocable: true
argument-hint: "<file-path-or-text>"
---

# Wiki Ingest

Ingest a source document into the States Media wiki at `~/states-media/wiki/`.

## Quick Start

```
/wiki-ingest ~/Downloads/report.pdf
/wiki-ingest "paste the text content here"
```

## Activation

1. Parse source from `$ARGUMENTS` (file path or inline text)
2. If no source provided, ask the user what to ingest
3. Execute the ingest pipeline below

## Pipeline

### Step 1 — Read the source

- If file path: Read the file (supports .pdf, .txt, .md, .docx)
- If inline text: Use the provided text
- If URL: Fetch with WebFetch and extract content

### Step 2 — Analyze and discuss

Tell the user:
- What the source is about (2-3 sentences)
- Key insights (bullet list, max 5)
- Which wiki folder it belongs in
- Which existing wiki pages are related

Ask: "Posso adicionar ao wiki? Algo a ajustar?"

### Step 3 — Create wiki page

Create a new markdown page in the appropriate folder:

```markdown
---
title: [Descriptive Title]
created: [YYYY-MM-DD]
updated: [YYYY-MM-DD]
tags: [relevant, tags]
sources: [source filename or URL]
---

# [Title]

## Summary
[2-3 paragraph summary of the source]

## Key Points
- [Point 1]
- [Point 2]
- [Point 3]

## Details
[Expanded content organized by topic]

## Related
- [[related-page-1]]
- [[related-page-2]]
```

**Page naming:** lowercase-with-hyphens.md, max 50 chars, descriptive.

**Folder selection:**
| Content about | Folder |
|--------------|--------|
| A person | `01-pessoas/` |
| A business unit, project, or client | `02-bus-e-projetos/` |
| A process, SOP, or how-to | `03-processos/` |
| A tool or technology | `04-ferramentas/` |
| Everything else | Root level |

### Step 4 — Update index.md

Add the new page to `~/states-media/wiki/index.md` under the appropriate section.
Format: `- [[folder/page-name]] — One-line description`

### Step 5 — Cross-reference

Read `index.md` to find related pages. For each related page:
- Read it
- Add a `[[wikilink]]` to the new page where relevant
- Add `[[wikilinks]]` from the new page to existing related pages

### Step 6 — Copy raw source

If the source is a file, copy it to `~/states-media/wiki/06-fontes-raw/`:
```bash
cp "<source-file>" ~/states-media/wiki/06-fontes-raw/
```

### Step 7 — Log the activity

Append to `~/states-media/wiki/log.md`:

```markdown
## [YYYY-MM-DD] ingest | [Source Title]
- Source: [filename or URL]
- Pages created: [[new-page]]
- Pages updated: [[page1]], [[page2]] (cross-refs added)
- Key insights: [2-3 bullet points]
```

### Step 8 — Report

Tell the user:
- Page created (path + link)
- Pages updated with cross-references
- Raw source archived location
- Suggest: "Abra o Obsidian para ver no graph view!"

## Rules

1. **Never invent.** Only write what the source says or what the user confirms.
2. **Always cite.** Reference the source in frontmatter and body.
3. **Update, don't duplicate.** If a page about this topic exists, update it instead.
4. **Link generously.** More `[[wikilinks]]` = more useful wiki.
5. **Ask before acting.** Always confirm with the user before creating/updating pages.
