#!/bin/bash
# Token Saver — one-line install for Claude Code, Cursor, or GitHub Copilot.
# curl -fsSL https://raw.githubusercontent.com/YunhaoDou/token-saver/main/install.sh | bash
set -e

REPO="https://raw.githubusercontent.com/YunhaoDou/token-saver/main"
PLATFORM=""

# auto-detect
if [ -d "$HOME/.claude" ] || [ -n "$CLAUDE_CODE_SKILLS" ]; then
    PLATFORM="claude-code"
elif [ -f ".cursorrules" ] || [ -d ".cursor" ]; then
    PLATFORM="cursor"
elif [ -f ".github/copilot-instructions.md" ] || [ -n "$COPILOT_INSTRUCTIONS" ]; then
    PLATFORM="copilot"
else
    PLATFORM="claude-code"  # default
fi

echo "Token Saver — installing for $PLATFORM"

case "$PLATFORM" in
    claude-code)
        DIR="${CLAUDE_CODE_SKILLS:-$HOME/.claude/skills}/token-saver"
        mkdir -p "$DIR"
        curl -fsSL "$REPO/platforms/claude-code/SKILL.md" -o "$DIR/SKILL.md"
        echo "✓ installed to $DIR"
        echo "  Usage: /token-saver"
        ;;
    cursor)
        curl -fsSL "$REPO/platforms/cursor/.cursorrules" -o .cursorrules
        echo "✓ installed to .cursorrules"
        echo "  Active on next Cursor session"
        ;;
    copilot)
        mkdir -p .github
        curl -fsSL "$REPO/platforms/copilot/copilot-instructions.md" -o .github/copilot-instructions.md
        echo "✓ installed to .github/copilot-instructions.md"
        echo "  Active on next Copilot session"
        ;;
esac

echo "  Deactivate: /clear (Claude Code) or restart session"
