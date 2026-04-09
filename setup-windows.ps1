# =============================================================================
# Claude Code Starter — Setup Windows
# States Media | Onboarding de IA
#
# Uso: Abra PowerShell como Administrador e rode:
#   Set-ExecutionPolicy Bypass -Scope Process -Force; .\setup-windows.ps1
# =============================================================================

$ErrorActionPreference = "Stop"

function Step($num, $msg) { Write-Host "`n[$num/11] $msg" -ForegroundColor Cyan }
function Ok($msg)   { Write-Host "  ✓ $msg" -ForegroundColor Green }
function Skip($msg) { Write-Host "  ⏭ $msg (ja instalado)" -ForegroundColor Yellow }
function Fail($msg) { Write-Host "  ✗ $msg" -ForegroundColor Red }
function Ask($msg)  { Write-Host "  ? $msg" -ForegroundColor Yellow }

Write-Host ""
Write-Host "╔══════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  States Media — Claude Code Starter      ║" -ForegroundColor Cyan
Write-Host "║  Setup Windows                           ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path

# =============================================================================
# STEP 1 — Pre-flight
# =============================================================================
Step 1 "Verificando pre-requisitos..."

# Windows version
$osVersion = [System.Environment]::OSVersion.Version
if ($osVersion.Major -lt 10) {
    Fail "Windows 10 ou superior necessario"
    exit 1
}
Ok "Windows $($osVersion.Major) detectado"

# Internet
try {
    Invoke-WebRequest -Uri "https://api.github.com" -UseBasicParsing -TimeoutSec 5 | Out-Null
    Ok "Internet funcionando"
} catch {
    Fail "Sem conexao com internet"
    exit 1
}

# Admin check
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "  ⚠ Rode como Administrador para melhor experiencia (algumas instalacoes precisam)" -ForegroundColor Yellow
}

# =============================================================================
# STEP 2 — Scoop (package manager)
# =============================================================================
Step 2 "Scoop (gerenciador de pacotes)..."

if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Skip "Scoop"
} else {
    Write-Host "  Instalando Scoop..."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    Ok "Scoop instalado"
}

# Add extras bucket for GUI apps
scoop bucket add extras 2>$null

# =============================================================================
# STEP 3 — Ferramentas base
# =============================================================================
Step 3 "Instalando ferramentas base..."

$packages = @("git", "gh", "nodejs", "yt-dlp", "ffmpeg", "python")
foreach ($pkg in $packages) {
    if (Get-Command $pkg -ErrorAction SilentlyContinue) {
        Skip $pkg
    } else {
        scoop install $pkg 2>$null
        if ($LASTEXITCODE -eq 0) { Ok "$pkg instalado" }
        else {
            # Try winget as fallback
            winget install --id "$(switch($pkg) { 'nodejs' {'OpenJS.NodeJS'} 'git' {'Git.Git'} 'gh' {'GitHub.cli'} 'python' {'Python.Python.3.12'} default {$pkg} })" --accept-package-agreements --accept-source-agreements 2>$null
            Ok "$pkg instalado (via winget)"
        }
    }
}

# Python whisper (easier than whisper.cpp on Windows)
Write-Host "  Instalando whisper (transcricao)..."
pip install openai-whisper 2>$null
Ok "whisper instalado (via pip)"

# =============================================================================
# STEP 4 — Obsidian
# =============================================================================
Step 4 "Obsidian (visualizador do wiki)..."

$obsidianPath = "$env:LOCALAPPDATA\Obsidian\Obsidian.exe"
if (Test-Path $obsidianPath) {
    Skip "Obsidian"
} else {
    Write-Host "  Instalando Obsidian..."
    scoop install obsidian 2>$null
    if ($LASTEXITCODE -ne 0) {
        winget install --id Obsidian.Obsidian --accept-package-agreements --accept-source-agreements 2>$null
    }
    Ok "Obsidian instalado"
}

# =============================================================================
# STEP 5 — Claude Code
# =============================================================================
Step 5 "Claude Code (IA no terminal)..."

if (Get-Command claude -ErrorAction SilentlyContinue) {
    Skip "Claude Code"
    Write-Host "  Atualizando para ultima versao..."
    npm update -g @anthropic-ai/claude-code 2>$null
} else {
    npm install -g @anthropic-ai/claude-code
    Ok "Claude Code instalado"
}

# =============================================================================
# STEP 6 — Login
# =============================================================================
Step 6 "Login e autenticacao..."

$ghStatus = gh auth status 2>&1
if ($ghStatus -match "Logged in") {
    Skip "GitHub CLI ja autenticado"
} else {
    Ask "Vamos fazer login no GitHub (abre o navegador)..."
    gh auth login
    Ok "GitHub autenticado"
}

Write-Host ""
Ask "Agora vamos fazer login no Claude Code."
Write-Host "  Uma janela vai abrir no navegador. Faca login com sua conta Anthropic." -ForegroundColor Yellow
Write-Host ""
claude login 2>$null
Ok "Login no Claude feito"

# =============================================================================
# STEP 7 — Estrutura de pastas
# =============================================================================
Step 7 "Criando estrutura de pastas..."

$HOME_DIR = $env:USERPROFILE

$dirs = @(
    "$HOME_DIR\states-media\projects",
    "$HOME_DIR\states-media\wiki",
    "$HOME_DIR\youtube-transcriber\output",
    "$HOME_DIR\.claude\skills",
    "$HOME_DIR\.claude\agents",
    "$HOME_DIR\.claude\commands",
    "$HOME_DIR\.claude\rules"
)

foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}
Ok "Estrutura de pastas criada"

# =============================================================================
# STEP 8 — Config Claude
# =============================================================================
Step 8 "Configurando Claude Code..."

$claudeDir = "$HOME_DIR\.claude"

# Backup existing
if (Test-Path "$claudeDir\CLAUDE.md") {
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    Copy-Item "$claudeDir\CLAUDE.md" "$claudeDir\CLAUDE.md.backup.$timestamp"
    Write-Host "  CLAUDE.md existente salvo como backup" -ForegroundColor Yellow
}
Copy-Item "$SCRIPT_DIR\claude-config\CLAUDE.md" "$claudeDir\CLAUDE.md" -Force
Ok "CLAUDE.md global configurado"

if (Test-Path "$claudeDir\settings.json") {
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    Copy-Item "$claudeDir\settings.json" "$claudeDir\settings.json.backup.$timestamp"
}
Copy-Item "$SCRIPT_DIR\claude-config\settings.json" "$claudeDir\settings.json" -Force
Ok "settings.json configurado"

# =============================================================================
# STEP 9 — Skills, agents, squads
# =============================================================================
Step 9 "Instalando skills, agentes e squads..."

# Skills
$skillCount = 0
Get-ChildItem -Path "$SCRIPT_DIR\skills" -Directory | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination "$claudeDir\skills\$($_.Name)" -Recurse -Force
    $skillCount++
}
Ok "$skillCount skills instaladas"

# Agents
$agentCount = 0
Get-ChildItem -Path "$SCRIPT_DIR\agents" -Directory | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination "$claudeDir\agents\$($_.Name)" -Recurse -Force
    $agentCount++
}
Ok "$agentCount agentes instalados"

# Squads
if (Test-Path "$SCRIPT_DIR\squads\squad-clonning") {
    Copy-Item -Path "$SCRIPT_DIR\squads\squad-clonning" -Destination "$claudeDir\commands\squad-clonning" -Recurse -Force
    Ok "Squad 'squad-clonning' instalado"
}

# =============================================================================
# STEP 10 — Wiki template
# =============================================================================
Step 10 "Configurando wiki da States Media..."

$wikiDir = "$HOME_DIR\states-media\wiki"

if (Test-Path "$wikiDir\index.md") {
    Write-Host "  Wiki ja existe. Pulando." -ForegroundColor Yellow
    Skip "Wiki ja configurado"
} else {
    Copy-Item -Path "$SCRIPT_DIR\wiki-template\*" -Destination $wikiDir -Recurse -Force
    # Also copy hidden .obsidian folder
    if (Test-Path "$SCRIPT_DIR\wiki-template\.obsidian") {
        Copy-Item -Path "$SCRIPT_DIR\wiki-template\.obsidian" -Destination "$wikiDir\.obsidian" -Recurse -Force
    }
    Ok "Wiki template copiado"

    # Init git
    Push-Location $wikiDir
    if (-not (Test-Path ".git")) {
        git init -q
        git add -A
        git commit -q -m "Initial wiki setup from claude-code-starter"
        Ok "Git inicializado no wiki"
    }
    Pop-Location
}

# =============================================================================
# STEP 11 — Validacao
# =============================================================================
Step 11 "Validacao final..."

$errors = 0

if (Get-Command claude -ErrorAction SilentlyContinue) { Ok "claude esta no PATH" }
else { Fail "claude nao encontrado"; $errors++ }

if (Test-Path "$claudeDir\CLAUDE.md") { Ok "CLAUDE.md global existe" }
else { Fail "CLAUDE.md nao encontrado"; $errors++ }

if (Test-Path "$wikiDir\index.md") { Ok "Wiki configurado" }
else { Fail "Wiki nao encontrado"; $errors++ }

$installedSkills = (Get-ChildItem "$claudeDir\skills" -Directory).Count
Ok "$installedSkills skills instaladas"

Write-Host ""
Write-Host "══════════════════════════════════════════" -ForegroundColor Cyan

if ($errors -eq 0) {
    Write-Host ""
    Write-Host "  ✅ SETUP COMPLETO! Tudo funcionando." -ForegroundColor Green
    Write-Host ""
    Write-Host "  Proximos passos:" -ForegroundColor White
    Write-Host ""
    Write-Host "  1. Abra o PowerShell e digite: " -NoNewline; Write-Host "claude" -ForegroundColor Cyan
    Write-Host "  2. Abra o Obsidian e selecione o vault: " -NoNewline; Write-Host "$wikiDir" -ForegroundColor Cyan
    Write-Host "  3. Experimente: " -NoNewline; Write-Host '/tech-search "o que e Claude Code"' -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Pastas importantes:" -ForegroundColor White
    Write-Host ""
    Write-Host "  📁 $HOME_DIR\states-media\projects\  → seus projetos"
    Write-Host "  📁 $HOME_DIR\states-media\wiki\      → wiki da empresa"
    Write-Host "  📁 $HOME_DIR\youtube-transcriber\    → transcricoes"
    Write-Host "  📁 $HOME_DIR\.claude\                → config do Claude"
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "  ⚠️  Setup concluido com $errors erro(s). Veja acima." -ForegroundColor Red
    Write-Host ""
}

Write-Host "══════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
