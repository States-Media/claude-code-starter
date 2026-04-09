# Claude Code Starter — States Media

Setup automático de IA para o time da States Media.

## TL;DR

```bash
curl -fsSL https://raw.githubusercontent.com/states-media/claude-code-starter/main/bootstrap.sh | bash
```

Este comando instala e configura tudo: Claude Code, Obsidian, wiki da empresa, skills, agentes, e ferramentas.

---

## O que é instalado

### Ferramentas

| Ferramenta | O que faz |
|-----------|-----------|
| **Claude Code** | IA no terminal — seu assistente principal |
| **Obsidian** | Visualizador do wiki da empresa |
| **yt-dlp + whisper** | Transcrição local de vídeos |
| **git + GitHub CLI** | Controle de versão |

### Skills (comandos especiais)

| Skill | O que faz |
|-------|-----------|
| `/pdf` | Trabalha com PDFs |
| `/docx` | Trabalha com Word |
| `/xlsx` | Trabalha com Excel |
| `/pptx` | Trabalha com PowerPoint |
| `/excel-analysis` | Análise profunda de planilhas |
| `/agent-browser` | Navega sites, tira screenshots, preenche formulários |
| `/tech-search "tema"` | Pesquisa profunda sobre qualquer assunto |
| `/skill-creator` | Cria skills personalizadas |
| `/ingest URL` | Salva artigos da web no wiki |
| `/youtube-transcribe URL` | Transcreve vídeos do YouTube |
| `/wiki-ingest arquivo` | Adiciona documentos ao wiki |
| `/wiki-query "pergunta"` | Busca no wiki com citações |
| `/wiki-lint` | Audita saúde do wiki |

### Agentes

| Agente | Expertise |
|--------|-----------|
| `prompt-engineer` | Otimiza prompts (use antes de pesquisas) |
| `deep-research` | Pesquisa profunda e abrangente |
| `agent-creator` | Cria novos agentes personalizados |

### Squads

| Squad | O que faz |
|-------|-----------|
| `squad-clonning` | Cria novos squads de agentes do zero |

---

## Estrutura de pastas (após setup)

```
~/
├── states-media/
│   ├── projects/          # Seus projetos (um CLAUDE.md por projeto)
│   └── wiki/              # Wiki da empresa (abre no Obsidian)
│
├── youtube-transcriber/
│   └── output/            # Transcrições de vídeos
│
└── .claude/
    ├── CLAUDE.md           # Configuração global do Claude
    ├── settings.json       # Permissões
    ├── skills/             # Skills instaladas
    ├── agents/             # Agentes instalados
    └── commands/           # Squads/comandos
```

---

## Conceitos importantes

### CLAUDE.md — O "manual de instruções" do Claude

O Claude lê automaticamente o arquivo `CLAUDE.md` da pasta onde você está. Isso ensina ele como se comportar:

- **Global** (`~/.claude/CLAUDE.md`): regras que valem em qualquer lugar
- **Por projeto** (`~/states-media/projects/meu-projeto/CLAUDE.md`): regras específicas daquele projeto

### Skills — Atalhos prontos

Skills são como "receitas" que o Claude segue. Você invoca com `/nome-da-skill`.
Exemplo: `/tech-search "tendências de IA"` faz uma pesquisa profunda e salva o resultado.

### Wiki — Base de conhecimento viva

O wiki da empresa fica em `~/states-media/wiki/` e é mantido pelo Claude Code:

- **Ingest**: adiciona conhecimento novo → `/wiki-ingest`
- **Query**: busca informação → `/wiki-query`
- **Lint**: verifica saúde → `/wiki-lint`

Abra no Obsidian para ver o graph view (mapa visual de conexões).

### Research Rule — Pesquisa em 2 passos

Para pesquisas profundas, SEMPRE faça em 2 passos:
1. Peça pro Claude otimizar o prompt primeiro (prompt-engineer)
2. Depois pesquise com o prompt otimizado (deep-research)

Isso produz resultados dramaticamente melhores.

---

## Criando um projeto novo

```bash
# 1. Copie o template
cp -r ~/states-media/projects-template/exemplo-projeto ~/states-media/projects/meu-projeto

# 2. Edite o CLAUDE.md com informações do projeto
open ~/states-media/projects/meu-projeto/CLAUDE.md

# 3. Use o Claude nesse projeto
cd ~/states-media/projects/meu-projeto
claude
```

---

## Troubleshooting

Veja [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) para soluções de problemas comuns.

## Próximos passos

Veja [docs/NEXT-STEPS.md](docs/NEXT-STEPS.md) para o que fazer depois do setup.

---

*States Media — Claude Code Starter v1.0*
