#!/bin/bash
# =============================================================================
# Wiki Lint — Cron Script
# Runs weekly to audit and auto-fix wiki health
# Installed by setup.sh as a launchd agent (macOS)
# =============================================================================

WIKI_DIR="$HOME/states-media/wiki"
LOG_FILE="$WIKI_DIR/log.md"
DATE=$(date +%Y-%m-%d)

# Only run if wiki exists
if [ ! -f "$WIKI_DIR/index.md" ]; then
    exit 0
fi

# Run claude with wiki-lint skill in non-interactive mode
cd "$WIKI_DIR"
claude --print "/wiki-lint" 2>/dev/null

# Append cron run to log
echo "" >> "$LOG_FILE"
echo "## [$DATE] auto-lint | Weekly Cron" >> "$LOG_FILE"
echo "- Triggered by: launchd cron (automatic)" >> "$LOG_FILE"
echo "- Action: wiki-lint executed" >> "$LOG_FILE"
