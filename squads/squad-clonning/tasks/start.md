# Start — Squad Creation Pipeline

> Ponto de entrada universal. Descreva sua dor e o sistema pesquisa, classifica e propõe tudo.

## Execution

1. Read the clonning-chief agent at `~/.claude/squads/squad-clonning/agents/clonning-chief.md`
2. Read the discovery task at `~/.claude/squads/squad-clonning/tasks/discovery-interview.md`
3. Follow the 9-step discovery process:

### Fluxo Completo

```
STEP 1-2: Usuário descreve a dor
    ↓
STEP 3: Interview rápido (2-3 perguntas max — pain, domain, workflow)
    ↓
STEP 4: RESEARCH AUTOMÁTICO (o sistema pesquisa)
    ├── Quem são as top autoridades nesse domínio?
    ├── Quanto material cada uma tem publicado?
    ├── Qual o tier de cada uma? (RICH/MEDIUM/LEAN)
    ├── Quem é viável pra clonar? Quem não é?
    └── Pergunta ao usuário: "Tem material adicional dessas pessoas?"
    ↓
STEP 5: Classificação automática (mind_clone / domain / hybrid)
    ↓
STEP 6-7: Proposta de arquitetura com tabela de autoridades
    ↓
STEP 8: Refinamento com feedback do usuário
    ↓
STEP 9: Aprovação → Pipeline inicia
```

## Usage

```
/squad-clonning:tasks:start
```

Então descreva o que precisa. Exemplos:
- "Preciso de um squad para gerenciar tráfego pago"
- "Quero um squad para criar copy de vendas diretas"
- "Preciso de um squad para customer success no meu SaaS"
- "Quero um squad de design para minha marca"

O sistema faz o resto: pesquisa as autoridades, avalia material, classifica o tipo, propõe a arquitetura.

## Key Principle

O usuário NUNCA precisa saber o que é "mind clone", "domain squad" ou "hybrid". Ele descreve o problema, o sistema pesquisa e decide. A classificação é baseada em DADOS (material publicado das autoridades), não em achismo.
