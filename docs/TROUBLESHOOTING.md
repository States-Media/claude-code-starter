# Troubleshooting — Problemas Comuns

## Setup

### "command not found: brew"
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Para Apple Silicon (M1/M2/M3), depois rode:
eval "$(/opt/homebrew/bin/brew shellenv)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
```

### "command not found: claude"
```bash
npm install -g @anthropic-ai/claude-code
```

### "command not found: node" ou "command not found: npm"
```bash
brew install node
```

### Setup travou no login
Se o `claude login` ou `gh auth login` travou:
1. Feche o terminal (Cmd+Q)
2. Abra novamente
3. Rode `cd ~/claude-code-starter && ./setup.sh` (ele pula os passos já feitos)

### "Permission denied" no setup.sh
```bash
chmod +x setup.sh
./setup.sh
```

---

## Claude Code

### Claude não responde / muito lento
1. Verifique internet: `curl -s https://api.anthropic.com > /dev/null && echo OK`
2. Faça login novamente: `claude login`
3. Verifique sua assinatura em https://console.anthropic.com

### "Rate limit exceeded"
Você atingiu o limite de uso. Espere alguns minutos e tente novamente.

### Skills não aparecem
```bash
# Verifique se as skills estão instaladas
ls ~/.claude/skills/

# Se vazio, copie novamente do repo
cp -r ~/claude-code-starter/skills/* ~/.claude/skills/
```

### CLAUDE.md não está sendo lido
- O Claude lê automaticamente o `CLAUDE.md` da pasta onde você está
- Certifique-se que está no diretório correto: `pwd`
- O CLAUDE.md global fica em `~/.claude/CLAUDE.md`

---

## Wiki (Obsidian)

### Obsidian não encontra o vault
1. Abra Obsidian
2. Clique em "Open folder as vault"
3. Navegue até `~/states-media/wiki/`
4. Selecione a pasta

### Links não funcionam (aparecem em cinza)
- Verifique se o nome do arquivo corresponde ao wikilink
- Wikilinks usam o nome do arquivo SEM extensão: `[[nome-da-pagina]]`
- Nomes devem ser lowercase com hyphens: `nome-da-pagina.md`

### Graph view vazio
- O graph só mostra páginas com `[[wikilinks]]` entre elas
- Rode `/wiki-lint` para encontrar páginas desconectadas

---

## YouTube Transcription

### "yt-dlp not found"
```bash
brew install yt-dlp
```

### Download falha
```bash
# Tente com cookies do Chrome
yt-dlp -x --audio-format wav --cookies-from-browser chrome "<URL>"
```

### "whisper-cpp not found" ou "No model file"
```bash
brew install whisper-cpp
# Baixar modelo (roda uma vez, ~500MB)
whisper-cpp --download-model medium
```

### Transcrição muito lenta
- Vídeos longos (>1h) demoram. É normal.
- Para acelerar, use modelo menor: substitua `medium` por `small` ou `base`
- Qualidade: medium > small > base

---

## MCPs (Google Drive, Gmail, Calendar)

### "MCP server disconnected"
MCPs podem desconectar. Feche e abra o Claude Code novamente.

### OAuth expirou
Rode `claude` e tente usar o MCP — ele vai pedir login novamente.

### Drive/Gmail não conecta
Verifique se a conta Google está logada no navegador padrão.

---

## Precisa de mais ajuda?

1. Rode `/wiki-query "meu problema"` — talvez a resposta esteja no wiki
2. Pergunte no canal do time
3. Consulte a documentação: https://docs.anthropic.com/claude-code
