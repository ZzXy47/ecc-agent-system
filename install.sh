#!/bin/bash
# ECC Agent System — Install Script
# 安装脚本

set -e

echo "🚀 Installing ECC Agent System..."

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check VS Code
if ! command -v code &> /dev/null; then
    echo "❌ VS Code not found. Please install VS Code first."
    exit 1
fi

# Create directories
mkdir -p ~/.copilot/agents
mkdir -p ~/.copilot/hooks
mkdir -p ~/.copilot/skills
mkdir -p ~/.copilot/prompts
mkdir -p ~/.claude/rules

# Copy files
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📁 Copying agents..."
cp -r "$SCRIPT_DIR/agents/"* ~/.copilot/agents/

echo "📁 Copying hooks..."
cp -r "$SCRIPT_DIR/hooks/"* ~/.copilot/hooks/

echo "📁 Copying skills..."
cp -r "$SCRIPT_DIR/skills/"* ~/.copilot/skills/

echo "📁 Copying prompts..."
cp -r "$SCRIPT_DIR/prompts/"* ~/.copilot/prompts/

echo "📁 Copying rules..."
cp -r "$SCRIPT_DIR/rules/ecc" ~/.claude/rules/

echo "📁 Copying lefthook config..."
cp "$SCRIPT_DIR/lefthook.yml" ~/.copilot/

# Install lefthook if not present
if ! command -v lefthook &> /dev/null; then
    echo "📦 Installing lefthook..."
    if command -v npm &> /dev/null; then
        npm install -g lefthook
    elif command -v brew &> /dev/null; then
        brew install lefthook
    else
        echo "⚠️  lefthook not installed. Please install manually:"
        echo "   npm install -g lefthook"
        echo "   or: brew install lefthook"
    fi
fi

echo ""
echo -e "${GREEN}✅ ECC Agent System installed successfully!${NC}"
echo ""
echo "📋 Next steps:"
echo "   1. Restart VS Code"
echo "   2. Open a project and run: lefthook install"
echo "   3. Start using Conductor in Copilot Chat!"
echo ""
echo "📖 Read the guide: docs/GUIDE-zh.md (中文) or docs/GUIDE-en.md (English)"
