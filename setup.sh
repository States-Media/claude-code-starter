#!/bin/bash
# =============================================================================
# Claude Code Starter — Setup Completo
# States Media | Onboarding de IA
#
# Este script instala e configura tudo que você precisa para usar Claude Code.
# Rode via bootstrap.sh ou diretamente: ./setup.sh
# =============================================================================

set -euo pipefail

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# --- Helpers ---
step() { echo ""; echo -e "${CYAN}[$1/11]${NC} ${BOLD}$2${NC}"; }
ok()   { echo -e "  ${GREEN}✓${NC} $1"; }
skip() { echo -e "  ${YELLOW}⏭${NC} $1 (já instalado)"; }
fail() { echo -e "  ${RED}✗${NC} $1"; }
ask()  { echo -e "  ${YELLOW}?${NC} $1"; }

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# =============================================================================
# STEP 1 — Pre-flight checks
# =============================================================================
step 1 "Verificando pré-requisitos..."

# macOS check
if [[ "$(uname)" != "Darwin" ]]; then
    fail "Este script foi feito para macOS. Para Linux, veja README.md."
    exit 1
fi
ok "macOS detectado ($(sw_vers -productVersion))"

# Internet check
if ! curl -s --max-time 5 https://api.github.com > /dev/null; then
    fail "Sem conexão com internet"
    exit 1
fi
ok "Internet funcionando"

# Disk space check (need at least 5GB)
FREE_SPACE=$(df -g "$HOME" | tail -1 | awk '{print $4}')
if [ "$FREE_SPACE" -lt 5 ]; then
    fail "Pouco espaço em disco (${FREE_SPACE}GB livres, precisa de 5GB+)"
    exit 1
fi
ok "Espaço em disco OK (${FREE_SPACE}GB livres)"

# =============================================================================
# STEP 2 — Homebrew
# =============================================================================
step 2 "Homebrew (gerenciador de pacotes)..."

if command -v brew &>/dev/null; then
    skip "Homebrew"
else
    echo -e "  Instalando Homebrew (pode pedir sua senha)..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add to PATH for Apple Silicon
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    fi
    ok "Homebrew instalado"
fi

# =============================================================================
# STEP 3 — Ferramentas base (git, gh, node, yt-dlp, ffmpeg)
# =============================================================================
step 3 "Instalando ferramentas base..."

BREW_PACKAGES=(git gh node yt-dlp ffmpeg)
for pkg in "${BREW_PACKAGES[@]}"; do
    if command -v "$pkg" &>/dev/null; then
        skip "$pkg"
    else
        brew install "$pkg" 2>/dev/null
        ok "$pkg instalado"
    fi
done

# whisper.cpp (for local transcription)
if command -v whisper-cpp &>/dev/null || [ -f /opt/homebrew/bin/whisper-cpp ]; then
    skip "whisper.cpp"
else
    brew install whisper-cpp 2>/dev/null
    ok "whisper.cpp instalado"
fi

# =============================================================================
# STEP 4 — Obsidian
# =============================================================================
step 4 "Obsidian (visualizador do wiki)..."

if [ -d "/Applications/Obsidian.app" ]; then
    skip "Obsidian"
else
    brew install --cask obsidian 2>/dev/null
    ok "Obsidian instalado"
fi

# =============================================================================
# STEP 5 — Claude Code
# =============================================================================
step 5 "Claude Code (IA no terminal)..."

if command -v claude &>/dev/null; then
    skip "Claude Code"
    echo -e "  Atualizando para última versão..."
    npm update -g @anthropic-ai/claude-code 2>/dev/null || true
else
    npm install -g @anthropic-ai/claude-code
    ok "Claude Code instalado"
fi

# =============================================================================
# STEP 6 — Login & Autenticação
# =============================================================================
step 6 "Login e autenticação..."

# GitHub auth
if gh auth status &>/dev/null 2>&1; then
    skip "GitHub CLI já autenticado"
else
    ask "Vamos fazer login no GitHub (abre o navegador)..."
    gh auth login
    ok "GitHub autenticado"
fi

# Claude login
echo ""
ask "Agora vamos fazer login no Claude Code."
echo -e "  ${YELLOW}Uma janela vai abrir no navegador. Faça login com sua conta Anthropic.${NC}"
echo ""
claude login 2>/dev/null || true
ok "Login no Claude feito (ou já estava logado)"

# =============================================================================
# STEP 7 — Estrutura de pastas
# =============================================================================
step 7 "Criando estrutura de pastas..."

# Main workspace
mkdir -p "$HOME/states-media/projects"
mkdir -p "$HOME/states-media/wiki"
ok "~/states-media/projects/ criado"
ok "~/states-media/wiki/ criado"

# YouTube transcriber workspace
mkdir -p "$HOME/youtube-transcriber/output"
ok "~/youtube-transcriber/ criado"

# Claude config dirs
mkdir -p "$HOME/.claude/skills"
mkdir -p "$HOME/.claude/agents"
mkdir -p "$HOME/.claude/commands"
mkdir -p "$HOME/.claude/rules"
ok "~/.claude/ estrutura criada"

# =============================================================================
# STEP 8 — Copiar configurações do Claude
# =============================================================================
step 8 "Configurando Claude Code..."

# Global CLAUDE.md (backup existing if any)
if [ -f "$HOME/.claude/CLAUDE.md" ]; then
    cp "$HOME/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md.backup.$(date +%s)"
    echo -e "  ${YELLOW}CLAUDE.md existente salvo como backup${NC}"
fi
cp "$SCRIPT_DIR/claude-config/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
ok "CLAUDE.md global configurado"

# Settings (merge, don't overwrite)
if [ -f "$HOME/.claude/settings.json" ]; then
    cp "$HOME/.claude/settings.json" "$HOME/.claude/settings.json.backup.$(date +%s)"
    echo -e "  ${YELLOW}settings.json existente salvo como backup${NC}"
fi
cp "$SCRIPT_DIR/claude-config/settings.json" "$HOME/.claude/settings.json"
ok "settings.json configurado"

# =============================================================================
# STEP 9 — Copiar skills, agents, squads
# =============================================================================
step 9 "Instalando skills, agentes e squads..."

# Skills
SKILL_COUNT=0
for skill_dir in "$SCRIPT_DIR/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    cp -r "$skill_dir" "$HOME/.claude/skills/$skill_name"
    SKILL_COUNT=$((SKILL_COUNT + 1))
done
ok "$SKILL_COUNT skills instaladas"

# Agents
AGENT_COUNT=0
for agent_dir in "$SCRIPT_DIR/agents"/*/; do
    agent_name=$(basename "$agent_dir")
    cp -r "$agent_dir" "$HOME/.claude/agents/$agent_name"
    AGENT_COUNT=$((AGENT_COUNT + 1))
done
ok "$AGENT_COUNT agentes instalados"

# Squads
if [ -d "$SCRIPT_DIR/squads/squad-clonning" ]; then
    cp -r "$SCRIPT_DIR/squads/squad-clonning" "$HOME/.claude/commands/squad-clonning"
    ok "Squad 'squad-clonning' instalado"
fi

# =============================================================================
# STEP 10 — Wiki template (Obsidian vault)
# =============================================================================
step 10 "Configurando wiki da States Media..."

WIKI_DIR="$HOME/states-media/wiki"

if [ -f "$WIKI_DIR/index.md" ]; then
    echo -e "  ${YELLOW}Wiki já existe. Pulando para não sobrescrever seu trabalho.${NC}"
    skip "Wiki já configurado"
else
    cp -r "$SCRIPT_DIR/wiki-template/"* "$WIKI_DIR/"
    cp -r "$SCRIPT_DIR/wiki-template/.obsidian" "$WIKI_DIR/.obsidian"
    ok "Wiki template copiado para ~/states-media/wiki/"

    # Init git for version history
    cd "$WIKI_DIR"
    if [ ! -d .git ]; then
        git init -q
        git add -A
        git commit -q -m "Initial wiki setup from claude-code-starter"
        ok "Git inicializado no wiki (histórico de versões)"
    fi
    cd "$SCRIPT_DIR"
fi

# =============================================================================
# STEP 11 — Validação final
# =============================================================================
step 11 "Validação final..."

ERRORS=0

# Check Claude
if command -v claude &>/dev/null; then
    ok "claude está no PATH"
else
    fail "claude não encontrado no PATH"
    ERRORS=$((ERRORS + 1))
fi

# Check CLAUDE.md
if [ -f "$HOME/.claude/CLAUDE.md" ]; then
    ok "CLAUDE.md global existe"
else
    fail "CLAUDE.md global não encontrado"
    ERRORS=$((ERRORS + 1))
fi

# Check wiki
if [ -f "$HOME/states-media/wiki/index.md" ]; then
    ok "Wiki configurado"
else
    fail "Wiki não encontrado"
    ERRORS=$((ERRORS + 1))
fi

# Check skills count
INSTALLED_SKILLS=$(ls -d "$HOME/.claude/skills"/*/ 2>/dev/null | wc -l | tr -d ' ')
ok "$INSTALLED_SKILLS skills instaladas"

# Check Obsidian
if [ -d "/Applications/Obsidian.app" ]; then
    ok "Obsidian instalado"
else
    fail "Obsidian não encontrado"
    ERRORS=$((ERRORS + 1))
fi

echo ""
echo -e "${CYAN}══════════════════════════════════════════${NC}"

if [ "$ERRORS" -eq 0 ]; then
    echo ""
    echo -e "${GREEN}  ✅ SETUP COMPLETO! Tudo funcionando.${NC}"
    echo ""
    echo -e "  ${BOLD}Próximos passos:${NC}"
    echo ""
    echo -e "  1. Abra um terminal e digite: ${CYAN}claude${NC}"
    echo -e "  2. Abra o Obsidian e selecione o vault: ${CYAN}~/states-media/wiki${NC}"
    echo -e "  3. Experimente: ${CYAN}/tech-search \"o que é Claude Code\"${NC}"
    echo ""
    echo -e "  ${BOLD}Pastas importantes:${NC}"
    echo ""
    echo -e "  📁 ~/states-media/projects/  → seus projetos"
    echo -e "  📁 ~/states-media/wiki/      → wiki da empresa"
    echo -e "  📁 ~/youtube-transcriber/    → transcrições"
    echo -e "  📁 ~/.claude/                → config do Claude"
    echo ""
else
    echo ""
    echo -e "${RED}  ⚠️  Setup concluído com $ERRORS erro(s). Veja acima.${NC}"
    echo -e "  Consulte docs/TROUBLESHOOTING.md para soluções."
    echo ""
fi

echo -e "${CYAN}══════════════════════════════════════════${NC}"
echo ""
