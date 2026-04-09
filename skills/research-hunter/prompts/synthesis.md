# Synthesis — Instructions for Main Model

These instructions guide the MAIN MODEL (not a worker) in Phase 3: Synthesis.
The main model receives all worker outputs and produces the final analysis in PT-BR.

## INPUT

- All 3 worker outputs (YouTube, Reddit, Twitter JSON)
- Coverage evaluation results
- Original query and preparation data

## SYNTHESIS PROCESS

### 1. ORGANIZE BY THEME, NOT BY SOURCE

Do NOT write "YouTube says X, Reddit says Y, Twitter says Z."
Do NOT write shallow summaries like "several sources discussed approaches to solve this."
WRITE the actual substance: the specific techniques, the exact configs, the real debates.

The synthesis should be so complete that the user can ACT on it immediately.
If the user asked "how to do X", the synthesis should contain the actual step-by-step
instructions, not a summary that says "multiple approaches were found."

Instead, organize by THEMES that emerge across sources:

Example themes:
- "Como configurar" (practical steps)
- "Limitacoes conhecidas" (warnings)
- "Alternativas" (other approaches)
- "Opiniao da comunidade" (consensus)

For each theme, weave together findings from ALL sources that touch on it.
Cite sources inline: "[YouTube: @channel]", "[Reddit: r/sub, u/user]", "[Twitter: @handle]"

### 2. CONTRADICTION DETECTION (MANDATORY)

For EVERY key finding, check:
- Does another source contradict this?
- Is there a more recent source that updates this?

Format contradictions explicitly:

```
### Contradicao Detectada
- **Posicao A**: [source] diz que X funciona assim
- **Posicao B**: [source] diz que X foi deprecado/mudou
- **Veredicto**: [sua analise de qual e mais provavel ser correto, baseado em recencia e autoridade]
```

If NO contradictions found, state: "Nenhuma contradicao significativa detectada entre as fontes."

### 3. AUTHORITY-WEIGHTED CONCLUSIONS

Not all sources are equal. Weight conclusions by:

| Authority Score | Weight |
|----------------|--------|
| 5 (official/creator) | 5x |
| 4 (known expert) | 3x |
| 3 (experienced user) | 2x |
| 2 (regular user) | 1x |
| 1 (unknown) | 0.5x |

When sources disagree, the higher-authority source wins UNLESS:
- The lower-authority source is significantly more recent
- Multiple lower-authority sources converge on the same point
- The higher-authority source has known bias (e.g., creator promoting own tool)

### 4. TEMPORAL INTELLIGENCE (MANDATORY)

For EVERY major finding, note:
- When was this information published?
- Is this still likely current?

Flag explicitly:
```
⚠️ Informacao de [data]. Pode estar desatualizada para [motivo].
```

Especially flag if:
- Information is >6 months old for fast-moving tech topics
- A newer source contradicts an older one
- The tool/feature discussed has had major updates since

### 5. ACTIONABLE RECOMMENDATIONS

End with concrete, actionable steps the user can take:

```
## Proximos Passos

1. [Acao concreta 1] — [por que]
2. [Acao concreta 2] — [por que]
3. [Recurso para aprofundar] — [link]
```

Recommendations should be:
- Specific (not "research more" — say what to research)
- Ordered by priority (most impactful first)
- Linked to sources when possible

### 6. OUTPUT LANGUAGE

ALL output MUST be in Portuguese (PT-BR).
- Technical terms can stay in English (e.g., "MCP server", "webhook")
- Tool names stay in English
- Everything else in Portuguese

### 7. OUTPUT FORMAT

The synthesis output goes into 04-synthesis.md with this structure:

```markdown
# Sintese: {titulo da pesquisa}

> Pesquisa realizada em {data} | {N} videos + {N} threads + {N} tweets analisados

---

## TL;DR

- [3-5 bullets com as descobertas mais importantes]

---

## Analise por Tema

### {Tema 1}
[Findings woven from all sources]

### {Tema 2}
[...]

---

## Contradicoes Detectadas

[Explicit contradiction analysis or "Nenhuma contradicao significativa"]

---

## Ranking de Fontes por Autoridade

| Fonte | Tipo | Autoridade | Contribuicao Principal |
|-------|------|-----------|----------------------|
| [best source] | YouTube/Reddit/Twitter | 5/5 | [what it contributes] |
| [...] | | | |

---

## Alertas Temporais

[Temporal flags for potentially outdated information]

---

## Proximos Passos

1. [Action 1]
2. [Action 2]
3. [Action 3]

---

## Fontes Completas

### YouTube
- [Video 1 title](url) — @channel, {views} views, {date}
- [...]

### Reddit
- [Thread 1 title](url) — r/sub, {score} upvotes, {date}
- [...]

### Twitter
- [@handle](url): "tweet excerpt" — {likes} likes, {date}
- [...]
```

## QUALITY CHECKLIST

Before finishing synthesis, verify:
- [ ] All themes cover findings from multiple sources (not single-source themes)
- [ ] Contradictions section is present (even if "none found")
- [ ] Temporal flags are present for information >3 months old
- [ ] Every claim cites at least one specific source
- [ ] Recommendations are concrete and actionable
- [ ] Output is entirely in PT-BR (except technical terms)
- [ ] TL;DR captures the 3-5 MOST important points (not 10)
- [ ] Authority ranking table is present
