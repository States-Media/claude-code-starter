---
name: research-hunter
description: |
  Exhaustive multi-source research across YouTube, Reddit, and Twitter/X.
  Pipeline: Prepare > Parallel Hunt (3 source workers) + Deep Research (prompt-engineer → deep-research) > Evaluate > Synthesize > Document.
  Uses yt-dlp + whisper (YouTube, local, zero API) + WebSearch (Reddit) + TwitterAPI.io (Twitter/X).
  Output: Terminal summary (PT) + full report + Obsidian note.
  Saves to docs/research/{YYYY-MM-DD}-{slug}/.
---

# Research Hunter

Exhaustive multi-source research system. Searches YouTube, Reddit, and Twitter/X in parallel,
transcribes ALL relevant videos, reads ALL relevant threads, and synthesizes findings into
actionable intelligence in Portuguese.

## Quick Start

```
/research-hunter "I heard you can make Obsidian the permanent memory for Claude Code"
```

## Activation

1. Parse query from `$ARGUMENTS` (or ask if not provided)
2. Execute 6-phase workflow
3. Save to `docs/research/{YYYY-MM-DD}-{slug}/`
4. Sync to `~/obsidian/Research/{Title}.md`

**CRITICAL:**
- NEVER implement code. Redirect to @pm or @dev.
- Output ALWAYS in Portuguese (PT-BR). Search ALWAYS in English.
- Depth > Speed. No artificial limits on content consumed.

---

## SKILL DEFINITION

```yaml
skill:
  name: Research Hunter
  id: research-hunter

veto_conditions:
  - id: VETO_NO_RESULTS
    trigger: "ALL 3 source workers return 0 results"
    action: "STOP + Report: 'Nenhum resultado encontrado nas 3 fontes. Reformule a query.'"

  - id: VETO_IMPLEMENTATION_REQUEST
    trigger: "User asks to implement, code, create agent/skill, or deploy"
    action: "REDIRECT: 'Implementacao nao e meu escopo. Use @pm para priorizar ou @dev para executar.'"

  - id: VETO_TOOLS_UNAVAILABLE
    trigger: "yt-dlp AND WebSearch both fail"
    action: "STOP + Report: 'Ferramentas indisponiveis. Verifique: yt-dlp esta instalado? Internet funcionando?'"

constraints:
  forbidden_actions:
    - NEVER implement code, agents, skills, or production artifacts
    - NEVER write files outside docs/research/ and ~/obsidian/Research/
    - NEVER limit the number of videos transcribed or threads read (exhaustive by design)
    - NEVER output research in English (always PT-BR)

tool_hierarchy:
  youtube:
    primary: "yt-dlp ytsearch (search) + yt-dlp download + whisper-cpp/whisper (transcribe)"
    fallback: "WebSearch with site:youtube.com + WebFetch for transcript services"
    note: "Zero API, zero MCP, zero credits. All local. yt-dlp and whisper must be installed."

  reddit:
    primary: "WebSearch with site:reddit.com + WebFetch on old.reddit.com URLs"
    note: "No MCP needed. WebSearch + WebFetch is sufficient for Reddit."

  twitter:
    primary: "TwitterAPI.io REST API via Bash curl (advanced_search, get_tweet_replies_v2, get_tweet_thread_context, search_user)"
    auth: "X-API-Key header. Key from ~/.claude/aios/.env TWITTERAPI_IO_KEY"
    base_url: "https://api.twitterapi.io"
    fallback: "WebSearch with site:twitter.com OR site:x.com (very limited)"
    note: "Workers use Bash curl, NOT WebFetch (needs custom headers). NOT Xpoz (Twitter blocked on free tier)."

  workers:
    type: "general-purpose"
    model: "sonnet"
    max_parallel: 3
    note: "Use Sonnet (not Haiku) for workers — they need to process large transcripts and make quality judgments"

workflow:
  phases:

    # ──────────────────────────────────────────────
    # PHASE 0: PREPARATION
    # ──────────────────────────────────────────────
    0_preparation:
      name: "Query Preparation & Source Routing"
      model_tier: "MAIN MODEL (inline)"
      description: |
        Parse query, translate to EN, generate source-specific search variants,
        classify query type for intelligent source routing.

      execution: |
        ultrathink

        1. READ user query from $ARGUMENTS (original text, any language)

        2. TRANSLATE/REFORMULATE to optimized English search queries:
           Even if user typed in English, reformulate for better search results.
           Generate 3 SOURCE-SPECIFIC search variants:

           a) youtube_query: Optimized for YouTube search
              - Add "tutorial", "how to", "guide", "explained" if applicable
              - Remove filler words, keep core technical terms
              - Example: "how to configure Obsidian permanent memory Claude Code tutorial"

           b) reddit_query: Optimized for Reddit discussion search
              - Add context words that appear in Reddit discussions
              - Think about which subreddits would discuss this
              - Example: "Obsidian permanent memory Claude Code setup experience"

           c) twitter_query: Optimized for Twitter/X discourse
              - Shorter, more keyword-focused
              - Include hashtags or tool names people would mention
              - Example: "Obsidian Claude Code memory integration"

        3. CLASSIFY QUERY TYPE for source routing:

           Categories (detect via keyword patterns + extended thinking):

           a) TUTORIAL/HOW-TO:
              Keywords: "how to", "como", "setup", "configure", "install", "tutorial"
              → source_weights: {youtube: 50, reddit: 35, twitter: 15}

           b) OPINION/EXPERIENCE:
              Keywords: "best", "melhor", "worth it", "vale a pena", "experience",
                        "recommendation", "should I", "devo"
              → source_weights: {youtube: 20, reddit: 50, twitter: 30}

           c) BREAKING/TRENDING:
              Keywords: "new", "novo", "just released", "lancou", "announced",
                        "update", "atualizacao", current year references
              → source_weights: {youtube: 20, reddit: 30, twitter: 50}

           d) TECHNICAL_DEEP_DIVE:
              Keywords: "architecture", "implementation", "internals", "benchmark",
                        "performance", "comparison", "vs"
              → source_weights: {youtube: 33, reddit: 34, twitter: 33}

           e) TROUBLESHOOTING:
              Keywords: "error", "bug", "not working", "nao funciona", "issue",
                        "problem", "fix", "workaround"
              → source_weights: {youtube: 25, reddit: 50, twitter: 25}

           DEFAULT (if no clear match):
              → source_weights: {youtube: 33, reddit: 34, twitter: 33}

        4. LOAD API CREDENTIALS:
           - Read ~/.claude/aios/.env to get TWITTERAPI_IO_KEY
           - TwitterAPI.io key is needed for the Twitter worker (passed via prompt)

        5. CHECK TOOL AVAILABILITY:
           - YouTube: Check yt-dlp is installed (`which yt-dlp`)
           - YouTube transcription: Check whisper-cpp or whisper is installed
           - Reddit: WebSearch is always available (built-in)
           - TwitterAPI.io: Read key from .env, verify non-empty

        6. OUTPUT:
           {
             "original_query": "user's original text",
             "youtube_query": "optimized EN query for YouTube",
             "reddit_query": "optimized EN query for Reddit",
             "twitter_query": "optimized EN query for Twitter",
             "query_type": "TUTORIAL|OPINION|BREAKING|DEEP_DIVE|TROUBLESHOOTING",
             "source_weights": {youtube: N, reddit: N, twitter: N},
             "ytdlp_available": true|false,
             "whisper_available": true|false,
             "twitterapi_key": "key from .env (passed to Twitter worker)"
           }

      output: "preparation_result object"

    # ──────────────────────────────────────────────
    # PHASE 1: PARALLEL HUNT (3 Source Workers)
    # ──────────────────────────────────────────────
    1_parallel_hunt:
      name: "Parallel Source Hunt"
      model_tier: "SONNET (via Agent tool, general-purpose)"
      description: |
        Dispatches 3 parallel workers — one per source (YouTube, Reddit, Twitter).
        Each worker is EXHAUSTIVE: no artificial limits on content consumed.
        Workers use source-specific MCPs for optimal extraction.

      execution: |
        DISPATCH 3 WORKERS IN A SINGLE MESSAGE (parallel execution):

        Agent(
          subagent_type: "general-purpose",
          model: "sonnet",
          prompt: <YOUTUBE_HUNTER_PROMPT from prompts/youtube-hunter.md>
        )

        Agent(
          subagent_type: "general-purpose",
          model: "sonnet",
          prompt: <REDDIT_HUNTER_PROMPT from prompts/reddit-hunter.md>
        )

        Agent(
          subagent_type: "general-purpose",
          model: "sonnet",
          prompt: <TWITTER_HUNTER_PROMPT from prompts/twitter-hunter.md>
        )

        Pass to each worker:
        - The source-specific optimized query
        - The MCP availability flags
        - The query type and source weight
        - Instruction to be EXHAUSTIVE (no limits on content)

        HANDLE FAILURES:
        - If a worker fails or returns empty → log warning
        - If worker's MCP is unavailable → worker uses fallback tools
        - Minimum: at least 1 worker must return results to proceed

      output: |
        3 worker responses with source-specific findings (JSON)

    # ──────────────────────────────────────────────
    # PHASE 1.5: DEEP RESEARCH (MANDATORY)
    # ──────────────────────────────────────────────
    1_5_deep_research:
      name: "Deep Research (prompt-engineer → deep-research)"
      model_tier: "SONNET (sub-agents)"
      mandatory: true
      description: |
        In ADDITION to the 3 source workers, EVERY research request MUST also
        run a full deep-research pass following the standard 2-step pattern:
        prompt-engineer optimizes the prompt FIRST, then deep-research executes.
        This is non-negotiable and runs in parallel with Phase 1 hunters when possible.

      execution: |
        STEP 1 — Optimize prompt (REQUIRED, never skip):
          Agent(
            subagent_type: "prompt-engineer",
            prompt: "Optimize this query for an exhaustive deep-research pass:
                     {original_query}. Context: multi-source intelligence gathering,
                     output will feed cross-source synthesis with YouTube/Reddit/Twitter
                     findings. Return an optimized research prompt."
          )
          → WAIT for optimized prompt.

        STEP 2 — Execute deep research with the optimized prompt:
          Agent(
            subagent_type: "deep-research",
            prompt: <optimized prompt from Step 1>
          )
          → WAIT for full deep-research report.

        RULES:
        - NEVER call deep-research without prompt-engineer first.
        - NEVER skip this phase, even on simple queries.
        - Findings from this phase feed Phase 2 (evaluate) and Phase 3 (synthesize)
          alongside the 3 source-worker outputs.
        - Can be dispatched in parallel with Phase 1 hunters to save time.

      output: "Deep research report (added to aggregate findings)"

    # ──────────────────────────────────────────────
    # PHASE 2: EVALUATE COVERAGE
    # ──────────────────────────────────────────────
    2_evaluate_coverage:
      name: "Coverage Evaluation & Gap Detection"
      model_tier: "MAIN MODEL (inline)"
      description: |
        Evaluates if the 3 source workers found sufficient information.
        Detects gaps and contradictions. Decides if Wave 2 is needed.

      execution: |
        1. AGGREGATE results from all 3 workers

        2. EVALUATE per source:
           For each source, score:
           - result_count: How many items found?
           - relevance: Are findings directly answering the query?
           - depth: Do we have full content (transcripts, threads) or just snippets?
           - authority: Are sources credible (high-view videos, expert accounts)?

        3. CROSS-SOURCE ANALYSIS:
           - Do findings from different sources AGREE or CONTRADICT?
           - Is there information in one source NOT covered by others?
           - Are there temporal discrepancies (old video vs new Reddit post)?

        4. GAP DETECTION:
           - "YouTube has tutorials but no one on Reddit confirms it works"
           - "Twitter shows excitement but no detailed how-to found anywhere"
           - "All sources are from 2024 — is this still current?"

        5. DECISION:
           IF all sources returned rich results AND no critical gaps:
             → decision: "SUFFICIENT", proceed to Phase 3

           IF one or more sources returned thin results OR critical gaps detected:
             → decision: "WAVE_2_NEEDED"
             → Generate 1-3 targeted follow-up queries per source with gaps
             → Re-dispatch ONLY the workers that need more data
             → Max 1 additional wave (total max 2 waves)

        6. After Wave 2 (if triggered):
           → Always proceed to Phase 3 regardless of coverage

      output: |
        {
          "decision": "SUFFICIENT|WAVE_2_NEEDED",
          "per_source_score": {youtube: {}, reddit: {}, twitter: {}},
          "gaps": [...],
          "contradictions": [...],
          "wave_2_queries": {...} (if WAVE_2_NEEDED)
        }

    # ──────────────────────────────────────────────
    # PHASE 3: SYNTHESIZE
    # ──────────────────────────────────────────────
    3_synthesize:
      name: "Cross-Source Synthesis"
      model_tier: "MAIN MODEL"
      description: |
        Combines findings from all sources into a coherent, actionable report.
        Output ALWAYS in Portuguese (PT-BR).
        Uses extended thinking for deep analysis.

      execution: |
        ultrathink

        1. DEEP CROSS-REFERENCE (use extended thinking):
           For each key finding:
           - Which sources confirm it?
           - Which sources contradict it?
           - How recent is the information?
           - How credible are the sources?

        2. CONTRADICTION DETECTION:
           Explicitly identify and document:
           - "Video X diz que funciona, mas thread no Reddit Y relata que foi deprecado"
           - "Tweet de @expert diz A, mas tutorial no YouTube mostra B"
           Include BOTH sides with links.

        3. AUTHORITY SCORING:
           Rate each source on a 1-5 scale:
           - YouTube: views, channel subscriber count, video date
           - Reddit: subreddit relevance, upvotes, expert replies, account age
           - Twitter: followers, verified status, known expert

        4. TEMPORAL INTELLIGENCE:
           Flag information that may be outdated:
           - "Esta informacao e de [data]. Pode estar desatualizada."
           - Highlight the MOST RECENT finding on each sub-topic

        5. GENERATE SYNTHESIS (PT-BR):
           - TL;DR: 3-5 bullets com as descobertas mais importantes
           - Detailed findings organized by theme (not by source)
           - Contradiction analysis
           - Source ranking by authority
           - Actionable recommendations
           - Complete source list with links

      output: "Complete synthesis in PT-BR"

    # ──────────────────────────────────────────────
    # PHASE 4: DOCUMENT & OUTPUT
    # ──────────────────────────────────────────────
    4_document:
      name: "Document & Output"
      model_tier: "MAIN MODEL"
      description: |
        Save full research report to disk, create Obsidian note,
        and display terminal summary.

      execution: |
        1. GENERATE SLUG:
           - From original query, create URL-friendly slug
           - Format: {YYYY-MM-DD}-{slug}
           - Example: 2026-03-30-obsidian-claude-code-memory

        2. SAVE FULL REPORT to docs/research/{date}-{slug}/:

           a) README.md — Index + TL;DR
              - Research title, date, query
              - TL;DR (3-5 bullets)
              - File index with descriptions
              - Total sources: N videos, N threads, N tweets

           b) 00-query.md — Original query + search variants
              - Original user query
              - Generated search variants per source
              - Query classification and source weights

           c) 01-youtube-findings.md — YouTube analysis
              - Each video: title, channel, views, date, link
              - Key insights per video with timestamps
              - Full transcripts (or relevant segments for long videos)
              - Authority scores

           d) 02-reddit-findings.md — Reddit analysis
              - Each thread: subreddit, title, score, date, link
              - Original post + top comments
              - Expert replies highlighted
              - Consensus and dissent patterns

           e) 03-twitter-findings.md — Twitter/X analysis
              - Key tweets with engagement metrics
              - Thread reconstructions
              - Expert accounts identified
              - Trending analysis

           f) 04-synthesis.md — Cross-source synthesis (main deliverable)
              - Complete synthesis from Phase 3
              - Contradiction analysis
              - Temporal intelligence flags
              - Authority-weighted conclusions

           g) 05-recommendations.md — Actionable intelligence
              - Concrete next steps
              - Resources to explore further
              - People/accounts to follow
              - Implementation guidance (redirect to @dev)

           h) sources.json — Structured metadata
              - All sources with URLs, dates, authority scores
              - Machine-readable for future reference

        3. CREATE OBSIDIAN NOTE at ~/obsidian/Research/{Title}.md:
           Follow template from ~/.claude/references/obsidian-sync.md:
           ```
           # {Title}

           > Research Hunter | {date} | Sources: {N} videos, {N} threads, {N} tweets

           ---

           ## Executive Summary
           [3-5 bullets]

           ---

           ## Main Findings
           [Condensed version — 100-200 lines max]
           [Tables for comparisons]
           [Links to full report files]

           ---

           ## Contradictions
           [If any]

           ## Next Steps
           [Actionable items]

           ---

           ## Related
           - [[link to relevant notes]]

           ---
           Tags: #research #{topic-tags}
           ```

        4. DISPLAY TERMINAL SUMMARY (PT-BR):
           Print directly to user:

           ## Pesquisa: "{original_query}"

           ### TL;DR
           - [bullets]

           ### Fontes
           - YouTube: N videos analisados — [best video link]
           - Reddit: N threads analisados — [best thread link]
           - Twitter: N tweets relevantes — [top expert]

           ### Contradicoes Detectadas
           - [if any, otherwise skip section]

           ### Proximos Passos
           - [concrete actions]

           Relatorio completo: docs/research/{date}-{slug}/
           Nota Obsidian: ~/obsidian/Research/{Title}.md

      output: "Terminal summary + files saved"

    # ──────────────────────────────────────────────
    # PHASE 5: CLEANUP
    # ──────────────────────────────────────────────
    5_cleanup:
      name: "Cleanup & Cost Report"
      model_tier: "MAIN MODEL (inline)"
      description: "Log research session and report estimated costs."

      execution: |
        1. Report to user:
           - Number of sources consumed per platform
           - Videos transcribed locally (zero cost)
           - TwitterAPI.io calls made
           - Total estimated cost (Twitter API only, everything else is free)
           - Time elapsed

        2. Done. Do not ask follow-up questions.

      output: "Cost report appended to terminal output"

security:
  - Never include API keys or secrets in research docs
  - Sanitize sensitive paths before saving
  - Validate URLs before fetching
  - NEVER write files outside docs/research/ and ~/obsidian/Research/
  - NEVER create agents, skills, or production code

scope_boundaries:
  allowed_paths:
    - "docs/research/**"
    - "~/obsidian/Research/**"
  forbidden_paths:
    - ".claude/agents/"
    - ".claude/skills/"
    - "squads/"
    - "app/"
    - "lib/"
    - "src/"
```

---

## Execution Flow

```
User Query
    |
    v
PHASE 0: PREPARATION (Main Model, ~30s)
├── Translate to EN
├── Generate 3 source-specific queries
├── Classify query type → source weights
└── Check tool availability (yt-dlp, whisper, TwitterAPI.io key)
    |
    v
PHASE 1: PARALLEL HUNT (3 Sonnet Workers, ~5-15min)
├── [YouTube Hunter]     ← yt-dlp ytsearch + whisper (local, zero API)
├── [Reddit Hunter]      ← WebSearch + WebFetch (site:reddit.com)
└── [Twitter/X Hunter]   ← TwitterAPI.io REST API (curl)
    |
    v
PHASE 2: EVALUATE (Main Model, ~30s)
├── Score coverage per source
├── Detect gaps & contradictions
└── (WAVE 2 if needed, max 1 extra)
    |
    v
PHASE 3: SYNTHESIZE (Main Model + ultrathink, ~2-3min)
├── Cross-reference all sources
├── Contradiction detection
├── Authority scoring
├── Temporal intelligence
└── Generate PT-BR synthesis
    |
    v
PHASE 4: DOCUMENT (Main Model, ~1-2min)
├── Save full report: docs/research/{date}-{slug}/
├── Create Obsidian note: ~/obsidian/Research/{Title}.md
└── Display terminal summary (PT-BR)
    |
    v
PHASE 5: CLEANUP (~10s)
└── Cost report
```

## Dependencies

| Tool | Purpose | Install | Cost |
|------|---------|---------|------|
| **yt-dlp** | YouTube search + audio download | `brew install yt-dlp` | Free |
| **whisper-cpp** or **openai-whisper** | Audio transcription | `brew install whisper-cpp` or `pip install openai-whisper` | Free |
| **ffmpeg** | Audio processing | `brew install ffmpeg` | Free |
| **TwitterAPI.io** | Twitter/X search, threads, replies | REST API via curl. Key in `~/.claude/aios/.env` | Paid (low cost) |

**No MCPs required.** YouTube and Reddit use local tools + WebSearch. Only Twitter uses an API key.

## Fallback Behavior

- **YouTube**: If yt-dlp fails → WebSearch(`site:youtube.com`) + yt-dlp auto-subs as transcript
- **Reddit**: WebSearch + WebFetch is the primary method (no MCP needed)
- **Twitter**: If TwitterAPI.io key missing → WebSearch(`site:x.com`) — very limited

## Output Structure

```
docs/research/{YYYY-MM-DD}-{slug}/
├── README.md                    # Index + TL;DR
├── 00-query.md                  # Query + search variants + classification
├── 01-youtube-findings.md       # ALL video analyses + transcripts
├── 02-reddit-findings.md        # ALL thread analyses + comments
├── 03-twitter-findings.md       # ALL tweet analyses + threads
├── 04-synthesis.md              # Cross-source synthesis (PT-BR)
├── 05-recommendations.md        # Actionable intelligence (PT-BR)
└── sources.json                 # Structured source metadata

~/obsidian/Research/{Title}.md   # Condensed Obsidian note
```
