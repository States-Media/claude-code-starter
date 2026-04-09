---
name: wiki-lint
description: >
  Audit the States Media wiki for quality issues: orphan pages, broken links,
  contradictions, stale content, missing frontmatter, index.md sync.
user-invocable: true
---

# Wiki Lint

Audit and improve wiki health.

## Quick Start

```
/wiki-lint
```

## Activation

1. No arguments needed
2. Execute the full audit pipeline below
3. Report findings with suggested fixes

## Pipeline

### Step 1 — Scan all pages

```bash
find ~/states-media/wiki -name "*.md" -not -path "*/.obsidian/*" -not -name "CLAUDE.md" | sort
```

Build a list of all wiki pages.

### Step 2 — Check index.md sync

Read `~/states-media/wiki/index.md`.
Compare against actual files:
- Pages in index but file doesn't exist → **Broken index entry**
- Files that exist but aren't in index → **Missing from index**

### Step 3 — Check wikilinks

For each page, extract all `[[wikilinks]]`.
Verify each link resolves to an existing file:
- `[[page-name]]` → look for `page-name.md` in any folder
- Links that don't resolve → **Broken wikilink**

### Step 4 — Find orphan pages

Pages that:
- Are not linked FROM any other page
- Are not listed in index.md
→ **Orphan page** (consider linking or removing)

### Step 5 — Check frontmatter

Every page should have:
- `title` — present?
- `created` — valid date?
- `updated` — valid date? Is it older than file modification date?
- `tags` — at least one tag?
- `sources` — present? (optional for meta pages)

Missing fields → **Incomplete frontmatter**

### Step 6 — Check for stale content

Pages where `updated` date is older than 30 days → **Potentially stale**
(Flag but don't auto-fix — user decides if still current)

### Step 7 — Report

Format the report:

```markdown
# Wiki Lint Report — [YYYY-MM-DD]

## Summary
- Total pages: X
- Issues found: Y
- Health score: Z/100

## Critical Issues (fix now)
- 🔴 [Broken wikilinks, broken index entries]

## Warnings (fix soon)
- 🟡 [Orphan pages, incomplete frontmatter]

## Info (optional fixes)
- 🔵 [Stale content, missing from index]

## Suggested Actions
1. [Specific action with command]
2. [Specific action with command]
```

### Step 8 — Offer to fix

"Quer que eu corrija os problemas automaticamente?"

If yes:
- Fix broken index entries (add/remove as needed)
- Add missing frontmatter fields
- Add orphan pages to index.md
- Log the lint pass in `log.md`

Do NOT auto-fix:
- Contradictions (need human judgment)
- Stale content (might still be valid)

## Log entry

After lint, append to `~/states-media/wiki/log.md`:

```markdown
## [YYYY-MM-DD] lint | Wiki Audit
- Pages scanned: X
- Issues found: Y
- Issues fixed: Z
- Health score: W/100
```
