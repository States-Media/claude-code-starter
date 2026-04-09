# Validate Squad — Gold Standard Quality Check

> Validate an existing squad against the Hormozi-level gold standard specification.

## Execution

1. Read the clonning-chief agent at `~/.claude/squads/squad-clonning/agents/clonning-chief.md`
2. Read the gold standard at `~/.claude/squads/squad-clonning/data/gold-standard-spec.yaml`
3. Read the validation workflow at `~/.claude/squads/squad-clonning/workflows/wf-validate.yaml`
4. Execute: Structure validation → Gold standard check → Smoke tests → Final report

## Usage

```
/squad-clonning:tasks:validate-squad ~/.claude/squads/hormozi
/squad-clonning:tasks:validate-squad ~/.claude/squads/design
/squad-clonning:tasks:validate-squad {any-squad-path}
```

## Scoring (4 Categories)

| Category | Weight | Checks |
|----------|--------|--------|
| Agent Quality | 30% | Line counts (1200+), 12 mandatory sections, output examples |
| DNA Depth | 25% | Voice/Thinking DNA lines, specialist DNA per agent |
| Squad Artifacts | 25% | SOPs (5+), vetos (8+), cases (5+), antipatterns (5+), frameworks (3+) |
| Integration | 20% | Workflows (3+), handoff protocol, source index |

**Pass**: >= 85/100 | **Conditional**: 70-84 | **Fail**: < 70
