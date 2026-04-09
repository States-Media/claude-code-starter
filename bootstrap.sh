#!/bin/bash
# =============================================================================
# Claude Code Starter — Bootstrap
# States Media | Onboarding de IA
#
# Uso: curl -fsSL <raw-url>/bootstrap.sh | bash
# =============================================================================

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║  States Media — Claude Code Starter      ║${NC}"
echo -e "${CYAN}║  Configuração automática de IA            ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════╝${NC}"
echo ""

# Check if gh is installed for private repo clone
if ! command -v gh &>/dev/null; then
    echo -e "${YELLOW}GitHub CLI (gh) não encontrado. Instalando...${NC}"
    if command -v brew &>/dev/null; then
        brew install gh
    else
        echo -e "${RED}Homebrew não encontrado. Instale primeiro: https://brew.sh${NC}"
        exit 1
    fi
fi

# Auth check
if ! gh auth status &>/dev/null 2>&1; then
    echo -e "${YELLOW}Fazendo login no GitHub...${NC}"
    gh auth login
fi

# Clone repo
REPO="states-media/claude-code-starter"
DEST="$HOME/claude-code-starter"

if [ -d "$DEST" ]; then
    echo -e "${YELLOW}Diretório $DEST já existe. Atualizando...${NC}"
    cd "$DEST" && git pull
else
    echo -e "${CYAN}Clonando repositório...${NC}"
    gh repo clone "$REPO" "$DEST"
fi

cd "$DEST"

# Run setup
echo ""
echo -e "${GREEN}Repositório pronto. Iniciando setup...${NC}"
echo ""
chmod +x setup.sh
./setup.sh

echo ""
echo -e "${GREEN}✅ Bootstrap concluído!${NC}"
