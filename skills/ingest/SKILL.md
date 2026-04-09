---
name: ingest
description: "Ingest a URL (article, blog post, paper, documentation) into the Obsidian vault. Auto-classifies by BU and domain, creates atomic note with frontmatter, suggests related wikilinks, updates the relevant _index.md. Triggers on: /ingest {url}, save this article, ingest url"
user-invocable: true
argument-hint: "{url}"
---

# Ingest — URL → Vault Atomic Note

## Purpose

This skill is the missing piece of the vault: **ingesting external content** (articles, blog posts, papers, documentation). The other ingest pipelines handle specific types (meeting-notes for call transcripts, course-extractor for courses, daily-coach for reflection). This one handles everything else that lives on the web.

Based on Karpathy's "LLM Wiki" pattern: user provides source → LLM reads → discusses key takeaways → writes summary → updates index → classifies correctly → links to related content.

## When to use

- User provides a URL: `/ingest https://example.com/article`
- User shares a link they want to save: "save this article for later"
- User wants to add a research reference to the vault

## Protocol

### Step 1: Fetch the content

**Primary: Jina AI Reader** (free, fast, clean markdown output, no API key):

```bash
curl -sf "https://r.jina.ai/${URL}" -H "Accept: text/plain" -o /tmp/ingest-raw.md
```

Check if the output has meaningful content (>500 chars, not an error page):
- If YES → proceed to Step 2
- If NO or curl failed → use Playwright fallback

**Fallback: Playwright local** (when Jina fails, site blocks it, or returns empty):

```bash
~/.claude/vault-scripts/playwright-fetch.js "${URL}" > /tmp/ingest-raw.md
```

The Playwright script renders the page, extracts title + main content as text, outputs basic markdown.

**Final fallback:** If both fail, ask the user to paste the content manually.

### Step 2: Read and analyze

Read `/tmp/ingest-raw.md`. Extract:

1. **Title** — from the first `# ` heading or from the URL metadata
2. **Author** — if mentioned
3. **Publication date** — if mentioned
4. **Main topics** — what the article is about (3-5 topics)
5. **Key claims/insights** — the actual content value

### Step 3: Classify

Decide WHERE this belongs in the vault. Consider:

**BU detection:**
- `boostedmeds` — mentions telehealth, E.D., PT-141, HIPAA, FDA 503A, Hims, Ro, Rugiet, Mach 1, Triple-Axis, compounded medication
- `nutradr` — mentions direct response, nutraceuticals, Meta ads, RedTrack, WHITE/BLACK compliance, supplements, weight loss, diabetes, prostate, memory
- `octane` — mentions YouTube dark channels, AI creators, Sofia Reyes, faceless channels, Instagram monetization, Fanvue
- `shared` — applies to multiple BUs: media buying, copywriting, tools, frameworks, AI/LLM topics, productivity, operations
- Default if unclear: `shared`

**Domain detection:**
- `technical` — code, infrastructure, tools, AI/LLM, integrations
- `marketing` — ads, copy, funnels, positioning, branding
- `compliance` — FDA, FTC, HIPAA, Meta policies, legal
- `operations` — processes, automation, team, management
- `financial` — pricing, revenue, costs, metrics
- `product` — features, UX, pricing strategy, product specs

**Subfolder routing:**
Based on BU + domain, pick the right subfolder. Examples:
- BM + marketing → `10-BoostedMeds/operations/` or `40-SharedKnowledge/media-buying/`
- BM + compliance → `10-BoostedMeds/compliance/`
- Shared + technical → `40-SharedKnowledge/tech-stack/`
- Shared + marketing → `40-SharedKnowledge/media-buying/` or `40-SharedKnowledge/copywriting/`
- Shared + research → `40-SharedKnowledge/research/`

If it doesn't fit any specific subfolder, default to `{namespace}/research/` (creating the folder if needed).

### Step 4: Generate the atomic note

**Filename:** Create a URL-safe slug from the title. Format: `{slug}.md`. Example: `karpathy-llm-wiki-pattern.md`.

**Full path:** `~/obsidian/{namespace}/{subfolder}/{slug}.md`

**Frontmatter (required):**

```yaml
---
type: reference
title: "{Article title}"
status: evergreen
confidence: medium
consumers: [{relevant roles based on domain}]
bu: [{detected_bu}]
token_estimate: {calculate from body: words * 1.3}
created: {today YYYY-MM-DD}
last_updated: {today YYYY-MM-DD}
last_verified: {today YYYY-MM-DD}
domain: {detected_domain}
tags: [ingested, {additional topic tags}]
source: external
source_url: "{original URL}"
source_author: "{author if known, else omit}"
source_date: "{publication date if known, else omit}"
ingested_via: "jina | playwright | manual"
---
```

**Consumers mapping by domain:**
- technical → `[dev, architect, data-engineer]`
- marketing → `[copywriter, media-buyer, pm, analyst]`
- compliance → `[compliance, pm, qa]`
- operations → `[pm, analyst, architect]`
- financial → `[cfo, pm, analyst]`
- product → `[pm, po, analyst]`
- research → `[analyst, pm]`

**Body structure:**

```markdown
# {Article Title}

> **Source:** [{article title}]({URL})
> **Author:** {if known}
> **Ingested:** {today}

## TL;DR
{2-3 sentences — YOUR synthesis of what this article says and why it matters to Denis's work}

## Key Insights
{Bullet list of 3-7 key claims/insights from the article}

## Relevance to Denis's work
{1-2 sentences — WHY this matters given Denis's BUs and current projects. This is the synthesis that makes the note valuable.}

## Related
{Suggested wikilinks to 2-3 existing notes in the vault — use the "search for related" step below}

## Raw content
{The markdown content from Jina/Playwright, indented as a collapsible or kept as-is}
```

### Step 5: Suggest related wikilinks

Before writing, search the vault for 2-3 related notes. Use:

```bash
# Search existing notes by topic keywords
grep -rl -iE "keyword1|keyword2" ~/obsidian/{00-System,10-BoostedMeds,20-NutraDR,30-OctaneDigital,40-SharedKnowledge} --include="*.md" 2>/dev/null | head -5
```

Or use the Obsidian CLI:
```bash
obsidian search query="keyword" 2>/dev/null | head -5
```

For each match, add a `- [[path/to/note]]` link in the `## Related` section.

### Step 6: Write the atomic note

Use Write tool to create the file at `~/obsidian/{namespace}/{subfolder}/{slug}.md`.

### Step 7: Update the namespace `_index.md`

Read the `_index.md` of the target namespace (e.g., `~/obsidian/40-SharedKnowledge/_index.md`).

Find the appropriate section (e.g., "### Research") and add a new row to the link table:

```markdown
| [[{namespace}/{subfolder}/{slug}]] | {token_estimate} | evergreen | {1-line summary} |
```

If the section doesn't exist, create it under "## Navigation by Domain".

Update the `last_updated` frontmatter of the `_index.md`.

### Step 8: Confirm and show summary

Output to the user:

```
✓ Ingested: {Article Title}
  BU: {detected_bu}
  Domain: {detected_domain}
  Saved to: {full path relative to vault}
  Tokens: {estimate}
  Fetched via: {jina|playwright|manual}

TL;DR: {the TL;DR from the note}

Related notes found:
- {link 1}
- {link 2}

Next steps:
- Open in Obsidian: {obsidian:// URI}
- Or continue: I can read this back to you if you want discussion
```

### Step 9: Offer to discuss

Ask the user if they want to discuss key takeaways or if this was a fire-and-forget save.

## Error handling

**If fetch fails:**
- Try Jina first
- Try Playwright fallback
- If both fail, ask user: "Both fetchers failed for {URL}. Please paste the content manually, or share a different URL."

**If classification is ambiguous:**
- Default to `40-SharedKnowledge/research/`
- Tell the user: "Couldn't confidently classify this. Saved to SharedKnowledge/research/ — you can move it if you prefer."

**If the slug conflicts with an existing file:**
- Append a numeric suffix: `{slug}-2.md`
- Do NOT overwrite

**If the URL is already in the vault:**
- Search for `source_url: "{URL}"` in all markdown files
- If found, tell the user: "Already ingested at {path}. Last updated {date}. Want to re-ingest (replace) or skip?"

## Critical rules

- **NEVER overwrite existing notes without explicit user confirmation**
- **ALWAYS include source URL in frontmatter** for provenance
- **NEVER invent author/date** — if not in the source, omit from frontmatter
- **Respect the vault structure** — don't create random folders outside the existing namespace conventions
- **Skip credentials/PII** — if the article contains sensitive data, reference generically
- **Don't summarize if the article is short** (<500 words) — just save the content with minimal header

## Files in this skill

| File | Purpose |
|------|---------|
| `SKILL.md` | This file — protocol |
| (external) `~/.claude/vault-scripts/playwright-fetch.js` | Playwright fallback fetcher |

## Dependencies

- `curl` (built-in macOS)
- `node` + `playwright` (installed via npm global: `~/.npm-global/bin/playwright` v1.57.0)
- Write/Read/Edit/Bash tools from Claude Code
