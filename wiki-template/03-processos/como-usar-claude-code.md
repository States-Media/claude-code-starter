---
title: Como Usar Claude Code
created: 2026-04-09
updated: 2026-04-09
tags: [processo, ferramentas, claude-code]
---

# Como Usar Claude Code no Dia-a-Dia

Guia rápido para o time da States Media.

## Abrir o Claude Code

1. Abra o Terminal (Cmd+Espaço → "Terminal")
2. Navegue até seu projeto: `cd ~/states-media/projects/meu-projeto`
3. Digite: `claude`

## Comandos Mais Úteis

### Skills (/)

| Comando | O que faz |
|---------|-----------|
| `/tech-search "assunto"` | Pesquisa profunda sobre qualquer tema |
| `/pdf analyze arquivo.pdf` | Analisa um PDF |
| `/xlsx analyze planilha.xlsx` | Analisa uma planilha |
| `/ingest https://url` | Salva um artigo/site no wiki |
| `/youtube-transcribe <url>` | Transcreve um vídeo do YouTube |
| `/wiki-query "pergunta"` | Busca informação no wiki da empresa |

### Dicas

- **Seja específico.** "Analisa essa planilha e me mostra os top 10 clientes por receita" é melhor que "analisa isso".
- **Deixe ele trabalhar.** Não interrompa no meio — Claude Code funciona melhor quando você dá o contexto completo e deixa ele resolver.
- **Use o wiki.** Sempre que aprender algo novo sobre a empresa, peça pro Claude salvar no wiki: "Salva isso no wiki".
- **Pesquisa em 2 passos.** Para pesquisas profundas, sempre peça "otimiza o prompt primeiro" antes de pesquisar.

## Problemas Comuns

| Problema | Solução |
|----------|---------|
| "command not found: claude" | Rode `npm install -g @anthropic-ai/claude-code` |
| Claude não responde | Verifique internet. Rode `claude login` novamente. |
| Skill não funciona | Verifique se está na pasta certa: `ls ~/.claude/skills/` |
