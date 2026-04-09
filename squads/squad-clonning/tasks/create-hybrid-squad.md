# Create Hybrid Squad — Mixed Clone + Domain Pipeline

> Create a squad mixing mind-cloned agents with domain specialists.

## Execution

1. Read the clonning-chief agent at `~/.claude/squads/squad-clonning/agents/clonning-chief.md`
2. Read the workflow at `~/.claude/squads/squad-clonning/workflows/wf-hybrid-squad.yaml`
3. Execute: Pre-flight → Per-agent routing (clone or domain) → Build Squad → Validate
4. Clone and domain extraction run in parallel

## Usage

```
/squad-clonning:tasks:create-hybrid-squad "Design: Brad Frost (clone), Dan Mall (clone), generic chief"
/squad-clonning:tasks:create-hybrid-squad "Marketing: Gary Halbert (clone), domain traffic specialist, domain analytics specialist"
```

## Per-Agent Routing

Each agent is classified as `mind_clone` or `domain`:
- **mind_clone agents**: Get full DNA extraction (voice + thinking + specialist)
- **domain agents**: Get domain knowledge extraction (decision architecture + voice guide + specialist)
- Both types pass the **same quality bar** (1,200+ lines, 12 mandatory sections)
