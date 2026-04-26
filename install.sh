#!/bin/bash
# Claude Code Starter Pack - Mac/Linux インストーラー
# 使い方: ターミナルで以下を実行
#   curl -fsSL https://raw.githubusercontent.com/AoiKugayama/claude-code-starter/main/install.sh | bash

set -e

echo ""
echo "  Claude Code Starter Pack"
echo "  ================================"
echo "  MCP・プラグイン 一括セットアップ"
echo ""

# claude コマンドの確認
if ! command -v claude &> /dev/null; then
    echo "[エラー] claude コマンドが見つかりません。"
    echo "         Claude Code をインストールして一度起動してから再実行してください。"
    echo "         https://claude.ai/download"
    exit 1
fi

# settings.json の場所
SETTINGS="$HOME/.claude/settings.json"
if [ ! -f "$SETTINGS" ]; then
    echo "[エラー] settings.json が見つかりません。"
    echo "         Claude Code を一度起動してから再実行してください。"
    exit 1
fi

# ---- Step 1: settings.json にマーケットプレイス + プラグインを追加 ----
echo "[1/3] プラグインを登録中..."

python3 - "$SETTINGS" << 'PYEOF'
import json, sys

path = sys.argv[1]
with open(path, encoding="utf-8") as f:
    data = json.load(f)

if "extraKnownMarketplaces" not in data:
    data["extraKnownMarketplaces"] = {}

if "cc-starter" not in data["extraKnownMarketplaces"]:
    data["extraKnownMarketplaces"]["cc-starter"] = {
        "source": {"source": "github", "repo": "AoiKugayama/claude-code-starter"}
    }
    print("     + cc-starter マーケットプレイスを追加")
else:
    print("     = cc-starter は登録済み")

if "enabledPlugins" not in data:
    data["enabledPlugins"] = {}

if "setup@cc-starter" not in data["enabledPlugins"]:
    data["enabledPlugins"]["setup@cc-starter"] = True
    print("     + setup@cc-starter プラグインを有効化")
else:
    print("     = setup@cc-starter は有効済み")

with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
PYEOF

echo ""

# ---- Step 2: 無料 MCP のインストール ----
echo "[2/3] 無料MCPをインストール中..."

install_mcp() {
    local name="$1" desc="$2"; shift 2
    printf "     %s (%s)..." "$name" "$desc"
    if "$@" > /dev/null 2>&1; then
        echo " OK"
    else
        echo " スキップ（既存 or 失敗）"
    fi
}

install_mcp "context7"       "ライブラリドキュメント参照" \
    claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp@latest

install_mcp "memory"         "永続メモリ" \
    claude mcp add --scope user memory -- npx -y @modelcontextprotocol/server-memory

install_mcp "linear"         "タスク管理連携" \
    claude mcp add --scope user --transport http linear https://mcp.linear.app/mcp

install_mcp "task-master-ai" "タスク自動分解" \
    claude mcp add --scope user task-master-ai -- npx -y task-master-ai@0.43.1

echo ""

# ---- Step 3: APIキーが必要なMCP ----
echo "[3/3] APIキーが必要なMCP（不要なら Enter でスキップ）"
echo ""

echo "  [Exa] 意味理解型Web検索"
echo "        APIキー取得 → https://exa.ai （無料）"
read -r -p "        キーを貼り付け（スキップ: そのまま Enter）: " EXA_KEY
if [ -n "$EXA_KEY" ]; then
    claude mcp add --scope user -e "EXA_API_KEY=$EXA_KEY" exa -- npx -y exa-mcp-server > /dev/null 2>&1
    echo "        + Exa をインストールしました"
else
    echo "        - スキップ"
fi
echo ""

echo "  [Firecrawl] Webスクレイピング"
echo "        APIキー取得 → https://firecrawl.dev （無料）"
read -r -p "        キーを貼り付け（スキップ: そのまま Enter）: " FC_KEY
if [ -n "$FC_KEY" ]; then
    claude mcp add --scope user -e "FIRECRAWL_API_KEY=$FC_KEY" firecrawl -- npx -y firecrawl-mcp > /dev/null 2>&1
    echo "        + Firecrawl をインストールしました"
else
    echo "        - スキップ"
fi

echo ""
echo "  ================================"
echo "  セットアップ完了！"
echo ""
echo "  次のステップ:"
echo "    1. Claude Code を再起動する"
echo "    2. チャットに /cc-setup と入力 → プラグイン確認"
echo ""
echo "  ツール一覧 → https://render-portal.pages.dev/claude-code-tools.html"
echo ""