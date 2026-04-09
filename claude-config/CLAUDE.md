# States Media — Claude Code Configuration

You are an AI assistant for a States Media team member. Follow these rules exactly.

---

## Language

- **Talk to user:** Portuguese (BR)
- **Write docs/code/prompts:** English

---

## Core Rules

### 1. Research Rule (MANDATORY)

**Every deep research MUST go through prompt-engineer first, then deep-research.**

```
1. Use prompt-engineer agent → get optimized research prompt
2. Use deep-research agent → execute with the optimized prompt
```

Never do deep research without optimizing the prompt first. This produces dramatically better results.

### 1b. Agent Creation Process (MANDATORY, No Exceptions)

**Every new agent MUST follow 3 sequential steps — NEVER in parallel, NEVER skip:**

```
1. prompt-engineer → optimized research prompt → WAIT for result
2. deep-research → complete research on the domain → WAIT for result
3. agent-creator → create agent based on research
```

This produces 1,500+ line agents (vs 300-500 without research). This rule overrides all others.

### 2. Wiki Auto-Save (MANDATORY)

The wiki at `~/states-media/wiki/` is the company's living knowledge base. **You MUST save automatically — never ask, just do it.**

Rules:
- Before answering questions about the company, search the wiki first (index.md → relevant pages)
- After ANY research (`/tech-search`, `/research-hunter`, deep-research), automatically save key findings to the wiki using the wiki-ingest pattern (create page, update index.md, cross-reference, log)
- After analyzing ANY document (PDF, XLSX, DOCX), automatically save a summary page to the wiki
- After ANY significant conversation that produces new knowledge about the company, projects, tools, or processes, save it to the wiki
- **Never ask "do you want me to save this to the wiki?" — just save it.** The user can always delete later.
- Always log ingests in `~/states-media/wiki/log.md`

### 3. Check Before Creating

- **Files:** Search first → Read → only Write if not found. Use Edit for existing files.
- **Folders:** Check for existing folders before creating. Never create duplicates.

### 4. Permissions Pre-Approved

All these are pre-approved — use directly without asking:
- All Bash commands
- WebSearch, WebFetch
- Google Drive, Gmail, Calendar MCPs
- All installed skills — use automatically when task matches

### 5. Project Structure

When working on any project, always work inside `~/states-media/projects/<project-name>/`.

Each project should have:
```
project-name/
├── CLAUDE.md       # Project-specific instructions
├── docs/           # Documentation
└── README.md       # Project overview
```

### 6. Quality & Security Review

After every response that generates code, files, or significant content, review it from a security and quality perspective before presenting to the user.

### 7. YouTube Transcription

Use the `/youtube-transcribe` skill for video transcription. It uses yt-dlp + whisper locally — no API keys needed.

Output goes to `~/youtube-transcriber/output/`.

---

## Available Skills

| Skill | What it does | How to use |
|-------|-------------|-----------|
| `/pdf` | Read, create, manipulate PDFs | `/pdf analyze report.pdf` |
| `/docx` | Work with Word documents | `/docx create proposal` |
| `/xlsx` | Work with spreadsheets | `/xlsx analyze data.xlsx` |
| `/pptx` | Work with presentations | `/pptx create deck` |
| `/excel-analysis` | Deep spreadsheet analysis | `/excel-analysis sales.xlsx` |
| `/agent-browser` | Browse websites, screenshots, forms | `/agent-browser check site.com` |
| `/tech-search` | Deep research on any topic | `/tech-search "topic"` |
| `/research-hunter` | Exhaustive research: YouTube + Reddit + Twitter + deep-research | `/research-hunter "topic"` |
| `/skill-creator` | Create new custom skills | `/skill-creator` |
| `/ingest` | Save a URL to the company wiki | `/ingest https://article.com` |
| `/youtube-transcribe` | Transcribe YouTube videos locally | `/youtube-transcribe <url>` |
| `/wiki-ingest` | Ingest a document into the wiki | `/wiki-ingest <file>` |
| `/wiki-query` | Search the wiki with citations | `/wiki-query "question"` |
| `/wiki-lint` | Audit wiki for issues | `/wiki-lint` |

## Available Agents

| Agent | Expertise | When to use |
|-------|----------|-------------|
| `prompt-engineer` | Prompt optimization | Before any deep research (mandatory) |
| `deep-research` | Comprehensive research | After prompt-engineer optimizes the query |
| `agent-creator` | Create new AI agents | When you need a specialized agent |

## Available Squads

| Squad | What it does | How to use |
|-------|-------------|-----------|
| `squad-clonning` | Create new agent squads from scratch | `/squad-clonning:tasks:start` |
