# Próximos Passos — Depois do Setup

Parabéns! Seu Claude Code está configurado. Aqui está o que fazer agora.

---

## Semana 1: Fundamentos

### Dia 1-2: Experimente

- [ ] Abra o terminal e rode `claude`
- [ ] Peça algo simples: "Me explica o que é o CLAUDE.md"
- [ ] Teste uma skill: `/tech-search "tendências de marketing digital 2026"`
- [ ] Abra o Obsidian e explore o wiki

### Dia 3-4: Use no trabalho real

- [ ] Pegue um PDF que você precisa analisar → `/pdf analyze arquivo.pdf`
- [ ] Pegue uma planilha → `/xlsx analyze planilha.xlsx`
- [ ] Pesquise um tema do seu trabalho → `/tech-search "tema"`

### Dia 5: Alimente o wiki

- [ ] Salve algo útil no wiki: `/wiki-ingest ~/Downloads/artigo.pdf`
- [ ] Faça uma pergunta pro wiki: `/wiki-query "o que eu salvei?"`
- [ ] Rode uma auditoria: `/wiki-lint`

---

## Semana 2: Intermediário

### Crie seu primeiro projeto

```bash
# Copie o template
cp -r ~/states-media/projects-template/exemplo-projeto ~/states-media/projects/meu-projeto

# Edite o CLAUDE.md do projeto
# (abra no editor de texto e preencha)

# Use Claude no contexto do projeto
cd ~/states-media/projects/meu-projeto
claude
```

### Use a research rule

Para pesquisas profundas, SEMPRE em 2 passos:

1. "Otimiza esse prompt de pesquisa pra mim: [sua pergunta]"
   (Claude usa o prompt-engineer automaticamente)
2. "Agora pesquisa com o prompt otimizado"
   (Claude usa o deep-research)

### Transcreva um vídeo

```
/youtube-transcribe https://www.youtube.com/watch?v=VIDEO_ID
```

---

## Semana 3+: Avançado

### Crie uma skill personalizada

```
/skill-creator
```

Diga pro Claude o que você quer automatizar e ele cria a skill pra você.

### Crie um agente especializado

Use o processo de 3 passos:
1. Otimize o prompt de pesquisa (prompt-engineer)
2. Pesquise profundamente (deep-research)
3. Crie o agente com base na pesquisa (agent-creator)

### Crie um squad

```
/squad-clonning:tasks:start
```

---

## Dicas de Ouro

1. **Seja específico.** "Analisa essa planilha e me mostra os top 10 por receita" > "analisa isso"
2. **Deixe ele trabalhar.** Dê contexto completo, depois deixe o Claude resolver sem interromper.
3. **Alimente o wiki.** Cada documento interessante que você encontrar → `/wiki-ingest`. O wiki fica mais útil a cada dia.
4. **Use a research rule.** Sempre passe pelo prompt-engineer antes de pesquisar.
5. **Não tenha medo de errar.** O terminal não vai explodir. Se algo der errado, é só fechar e abrir de novo.

---

## Recursos

- Documentação Claude Code: https://docs.anthropic.com/claude-code
- Troubleshooting: [docs/TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
- Wiki da empresa: `~/states-media/wiki/` (abra no Obsidian)
