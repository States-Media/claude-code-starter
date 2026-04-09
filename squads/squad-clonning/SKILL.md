---
name: squad-clonning
description: Squad Clonning — The Definitive Squad Creator. Creates Hormozi-level squads for any mind or domain. Supports mind_clone, domain, and hybrid types.
triggers:
  - /squad-clonning
  - /clonning
  - clone mind
  - create squad
  - clone squad
  - squad clonning
  - criar squad
  - clonar mente
---

# Squad Clonning — The Definitive Squad Creator

## Purpose
Creates AI agent squads at Hormozi-level quality (158K+ lines, 16+ specialized agents). Supports 3 types: Mind Clone, Domain Squad, Hybrid.

## How to Use

### Mind Clone (clone a real person)
```
@clonning-chief *clone-mind "Gary Halbert"
```

### Domain Squad (domain specialists, no person clone)
```
@clonning-chief *create-domain-squad "Paid Traffic Management"
```

### Hybrid (mix of clones + domain agents)
```
@clonning-chief *create-hybrid-squad "Design: Brad Frost (clone), Dan Mall (clone), generic chief"
```

### Validate Existing Squad
```
@clonning-chief *validate-squad ~/.claude/squads/{squad-name}
```

## Execution

When this skill is triggered:

1. Load the clonning-chief agent from `~/.claude/squads/squad-clonning/agents/clonning-chief.md`
2. The chief will:
   - Detect squad type (mind_clone / domain / hybrid)
   - Classify source sufficiency (RICH / MEDIUM / LEAN)
   - Select the correct workflow
   - Orchestrate mind-extractor and process-architect
   - Validate output against gold standard (85/100 threshold)

## Agents

| Agent | Location | Lines | Role |
|-------|----------|-------|------|
| clonning-chief | `squads/squad-clonning/agents/clonning-chief.md` | 1,935 | Orchestrator |
| mind-extractor | `squads/squad-clonning/agents/mind-extractor.md` | 1,843 | Knowledge Extraction |
| process-architect | `squads/squad-clonning/agents/process-architect.md` | 1,800 | Process Engineering |

## Quality Bar (Same for All Types)

- Agents: 1,200+ lines, 12 mandatory sections
- Voice/Thinking DNA: 300+/250+ lines (or domain equivalents)
- SOP Pairs: 5+ (narrative + blueprint)
- Veto Conditions: 3+ tiers, 8+ total
- Case Library: 5+ cases with numbers
- Frameworks: 3+, 200+ lines each

## References

- Gold Standard Spec: `squads/squad-clonning/data/gold-standard-spec.yaml`
- Hormozi Anatomy: `squads/squad-clonning/data/hormozi-anatomy.yaml`
- Source Requirements: `squads/squad-clonning/docs/source-requirements.md`
- Methodology: `squads/squad-clonning/docs/methodology.md`
