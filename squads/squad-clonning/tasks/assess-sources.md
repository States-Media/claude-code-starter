# Assess Sources — Source Sufficiency Check

> Quick assessment of available source material before starting a squad creation pipeline.

## Execution

1. Read the clonning-chief agent at `~/.claude/squads/squad-clonning/agents/clonning-chief.md`
2. Read the source sufficiency matrix at `~/.claude/squads/squad-clonning/data/source-sufficiency-matrix.yaml`
3. Score the available material across 5 dimensions (0-3 each, total 0-15)
4. Classify tier: RICH (11-15), MEDIUM (6-10), LEAN (0-5)
5. Report expected fidelity and any pipeline adjustments

## Usage

```
/squad-clonning:tasks:assess-sources "Gary Halbert"
/squad-clonning:tasks:assess-sources "Paid Traffic domain"
```

## 5 Assessment Dimensions (Mind Clone)

| Dimension | 0 | 1 | 2 | 3 |
|-----------|---|---|---|---|
| Written Material | None | 1 book | 2-3 books | 4+ books |
| Video/Audio | < 2h | 2-10h | 10-30h | 30+ hours |
| Frameworks | None | 1-3 partial | 3-5 well documented | 5+ with formulas |
| Case Studies | None | 1-3 mentioned | 3-8 detailed | 8+ with metrics |
| Source Diversity | 1 type | 2 types | 3 types | 4+ types |
