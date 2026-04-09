# Clone Mind — Full Mind Clone Pipeline

> Clone a person's mind into a squad of specialized agents at Hormozi-level quality.

## Execution

1. Read the clonning-chief agent at `~/.claude/squads/squad-clonning/agents/clonning-chief.md`
2. Read the workflow at `~/.claude/squads/squad-clonning/workflows/wf-full-clone.yaml`
3. Execute the full pipeline: Pre-flight → Extract Mind → Build Squad → Validate
4. Quality threshold: 85/100

## Usage

```
/squad-clonning:tasks:clone-mind "Gary Halbert"
/squad-clonning:tasks:clone-mind "Naval Ravikant"
```

## Pipeline Phases

| Phase | Agent | Output |
|-------|-------|--------|
| 0: Pre-Flight | clonning-chief | pipeline-state.yaml, source tier |
| 1: Mind Extraction | mind-extractor | Voice DNA, Thinking DNA, Specialist DNAs, frameworks, cases, antipatterns |
| 2: Squad Construction | process-architect | Agents (1200+L), workflows, SOPs, vetos, handoffs |
| 3: Validation | clonning-chief | Quality score, smoke tests, validation report |
