# Claude Code Starter Pack - Windows インストーラー
# 使い方: PowerShell で以下を実行
#   irm https://raw.githubusercontent.com/AoiKugayama/claude-code-starter/main/install.ps1 | iex

$ErrorActionPreference = "SilentlyContinue"

Write-Host ""
Write-Host "  Claude Code Starter Pack" -ForegroundColor Cyan
Write-Host "  ================================" -ForegroundColor Cyan
Write-Host "  MCP・プラグイン 一括セットアップ" -ForegroundColor Cyan
Write-Host ""

# Claude Code の確認
$claudeCmd = Get-Command claude -ErrorAction SilentlyContinue
if (-not $claudeCmd) {
    Write-Host "[エラー] claude コマンドが見つかりません。" -ForegroundColor Red
    Write-Host "         Claude Code をインストールして一度起動してから再実行してください。" -ForegroundColor Yellow
    Write-Host "         https://claude.ai/download" -ForegroundColor Yellow
    exit 1
}

# settings.json の場所
$settingsPath = "$env:USERPROFILE\.claude\settings.json"
if (-not (Test-Path $settingsPath)) {
    Write-Host "[エラー] settings.json が見つかりません。" -ForegroundColor Red
    Write-Host "         Claude Code を一度起動してから再実行してください。" -ForegroundColor Yellow
    exit 1
}

# ---- Step 1: settings.json にマーケットプレイス + プラグインを追加 ----
Write-Host "[1/3] プラグインを登録中..." -ForegroundColor Yellow

$raw = Get-Content $settingsPath -Raw
$json = $raw | ConvertFrom-Json

# extraKnownMarketplaces が存在しない場合は作成
if (-not $json.PSObject.Properties["extraKnownMarketplaces"]) {
    $json | Add-Member -NotePropertyName "extraKnownMarketplaces" -NotePropertyValue ([PSCustomObject]@{})
}
# cc-starter を追加
if (-not $json.extraKnownMarketplaces.PSObject.Properties["cc-starter"]) {
    $json.extraKnownMarketplaces | Add-Member -NotePropertyName "cc-starter" -NotePropertyValue (
        [PSCustomObject]@{ source = [PSCustomObject]@{ source = "github"; repo = "AoiKugayama/claude-code-starter" } }
    )
    Write-Host "     + cc-starter マーケットプレイスを追加" -ForegroundColor Green
} else {
    Write-Host "     = cc-starter は登録済み" -ForegroundColor Gray
}

# enabledPlugins が存在しない場合は作成
if (-not $json.PSObject.Properties["enabledPlugins"]) {
    $json | Add-Member -NotePropertyName "enabledPlugins" -NotePropertyValue ([PSCustomObject]@{})
}
# setup@cc-starter を追加
if (-not $json.enabledPlugins.PSObject.Properties["setup@cc-starter"]) {
    $json.enabledPlugins | Add-Member -NotePropertyName "setup@cc-starter" -NotePropertyValue $true
    Write-Host "     + setup@cc-starter プラグインを有効化" -ForegroundColor Green
} else {
    Write-Host "     = setup@cc-starter は有効済み" -ForegroundColor Gray
}

$json | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8
Write-Host ""

# ---- Step 2: 無料 MCP のインストール ----
Write-Host "[2/3] 無料MCPをインストール中..." -ForegroundColor Yellow

function Install-Mcp($name, $desc, $cmd) {
    Write-Host "     $name ($desc)..." -NoNewline
    $out = Invoke-Expression $cmd 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host " OK" -ForegroundColor Green
    } else {
        Write-Host " スキップ（既存 or 失敗）" -ForegroundColor Gray
    }
}

Install-Mcp "context7"       "ライブラリドキュメント参照" "claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp@latest"
Install-Mcp "memory"         "永続メモリ"               "claude mcp add --scope user memory -- npx -y @modelcontextprotocol/server-memory"
Install-Mcp "linear"         "タスク管理連携"            "claude mcp add --scope user --transport http linear https://mcp.linear.app/mcp"
Install-Mcp "task-master-ai" "タスク自動分解"           "claude mcp add --scope user task-master-ai -- npx -y task-master-ai@0.43.1"
Write-Host ""

# ---- Step 3: APIキーが必要なMCP ----
Write-Host "[3/3] APIキーが必要なMCP（不要なら Enter でスキップ）" -ForegroundColor Yellow
Write-Host ""

Write-Host "  [Exa] 意味理解型Web検索" -ForegroundColor Cyan
Write-Host "        APIキー取得 → https://exa.ai （無料）" -ForegroundColor Gray
$exaKey = Read-Host "        キーを貼り付け（スキップ: そのまま Enter）"
if ($exaKey.Trim() -ne "") {
    claude mcp add --scope user -e "EXA_API_KEY=$($exaKey.Trim())" exa -- npx -y exa-mcp-server 2>&1 | Out-Null
    Write-Host "        + Exa をインストールしました" -ForegroundColor Green
} else {
    Write-Host "        - スキップ" -ForegroundColor Gray
}
Write-Host ""

Write-Host "  [Firecrawl] Webスクレイピング" -ForegroundColor Cyan
Write-Host "        APIキー取得 → https://firecrawl.dev （無料）" -ForegroundColor Gray
$fcKey = Read-Host "        キーを貼り付け（スキップ: そのまま Enter）"
if ($fcKey.Trim() -ne "") {
    claude mcp add --scope user -e "FIRECRAWL_API_KEY=$($fcKey.Trim())" firecrawl -- npx -y firecrawl-mcp 2>&1 | Out-Null
    Write-Host "        + Firecrawl をインストールしました" -ForegroundColor Green
} else {
    Write-Host "        - スキップ" -ForegroundColor Gray
}

Write-Host ""
Write-Host "  ================================" -ForegroundColor Cyan
Write-Host "  セットアップ完了！" -ForegroundColor Green
Write-Host ""
Write-Host "  次のステップ:"
Write-Host "    1. Claude Code を再起動する"
Write-Host "    2. チャットに /cc-setup と入力 → プラグイン確認"
Write-Host ""
Write-Host "  ツール一覧 → https://render-portal.pages.dev/claude-code-tools.html"
Write-Host ""