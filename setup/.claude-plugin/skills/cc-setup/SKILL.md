# Claude Code スターターパック セットアップウィザード

## 概要

このスキルはRender推奨のMCP・プラグインを対話式でインストールする。
非エンジニアでも「これを実行すれば全部入る」ことを目的に設計されている。

---

## Input

なし（/cc-setup で起動）

---

## Instructions

### ステップ 0: 挨拶・確認

まず現在の状態を確認し、何をインストールするかを説明する。

```
Claude Code スターターパック へようこそ。

以下のツールをインストールします：

【無料MCP（APIキー不要）】
  ✓ Context7      — ライブラリ最新ドキュメント参照
  ✓ Memory        — 会話をまたぐ永続メモリ
  ✓ Linear        — タスク管理連携
  ✓ TaskMaster AI — AI タスク自動分解

【APIキー必要なMCP】
  ✓ Exa           — 意味理解型 Web 検索（exa.ai で無料取得）
  ✓ Firecrawl     — Web スクレイピング（firecrawl.dev で無料取得）

【公式プラグイン（無料）】
  ✓ github / playwright / superpowers / security-guidance /
    atomic-agents / claude-code-setup / skill-creator /
    plugin-dev / claude-md-management / cc-company

続けますか？ (y/n)
```

ユーザーが y を返したらステップ1へ進む。

---

### ステップ 1: 無料 MCP のインストール

以下のコマンドを順番に実行する。各コマンドの前にどのツールを入れているか一言添える。

```bash
claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp@latest
```

```bash
claude mcp add --scope user memory -- npx -y @modelcontextprotocol/server-memory
```

```bash
claude mcp add --scope user --transport http linear https://mcp.linear.app/mcp
```

```bash
claude mcp add --scope user task-master-ai -- npx -y task-master-ai@0.43.1
```

完了したら確認メッセージを出す：
「無料MCPを4つインストールしました。次にAPIキーが必要なMCPをセットアップします。」

---

### ステップ 2: Exa MCP のセットアップ

```
【Exa — 次世代Web検索】

APIキーの取得方法：
  1. https://exa.ai にアクセス
  2. Sign Up（無料）
  3. Dashboard → API Keys → Create Key

取得したら貼り付けてください。
（スキップする場合は「skip」と入力）
```

ユーザーが API キーを入力したら：

```bash
claude mcp add --scope user -e EXA_API_KEY=<入力されたキー> exa -- npx -y exa-mcp-server
```

skip の場合はスキップして次へ。

---

### ステップ 3: Firecrawl MCP のセットアップ

```
【Firecrawl — Webスクレイピング】

APIキーの取得方法：
  1. https://firecrawl.dev にアクセス
  2. Sign Up（無料）
  3. Dashboard → API Keys → New Key

取得したら貼り付けてください。
（スキップする場合は「skip」と入力）
```

ユーザーが API キーを入力したら：

```bash
claude mcp add --scope user -e FIRECRAWL_API_KEY=<入力されたキー> firecrawl -- npx -y firecrawl-mcp
```

skip の場合はスキップして次へ。

---

### ステップ 4: マーケットプレイスの追加とプラグインインストール

まずマーケットプレイスを登録する：

```bash
claude plugins add marketplace claude-plugins-official github:anthropics/claude-plugins-official
```

```bash
claude plugins add marketplace cc-company github:Shin-sibainu/cc-company
```

次にプラグインをインストール：

```bash
claude plugin install github@claude-plugins-official
claude plugin install playwright@claude-plugins-official
claude plugin install superpowers@claude-plugins-official
claude plugin install security-guidance@claude-plugins-official
claude plugin install atomic-agents@claude-plugins-official
claude plugin install claude-code-setup@claude-plugins-official
claude plugin install skill-creator@claude-plugins-official
claude plugin install plugin-dev@claude-plugins-official
claude plugin install claude-md-management@claude-plugins-official
claude plugin install Notion@claude-plugins-official
claude plugin install company@cc-company
```

---

### ステップ 5: claude.ai 統合 MCP の案内

以下は claude.ai の設定画面から認証が必要なMCP。
コマンドではなくブラウザ操作が必要なことを説明する：

```
【claude.ai で認証が必要なMCP】
  → Googleカレンダー / Gmail / Google Drive / Slack / Notion / Canva / Buffer

手順：
  1. claude.ai をブラウザで開く
  2. 設定 → Integrations → 各サービスを Connect
  3. OAuth認証を完了する

これらはClaude Codeからも自動的に使えるようになります。
```

---

### ステップ 6: 完了報告

インストール結果を表形式で報告する：

```
✅ セットアップ完了！

【インストール済みMCP】
  ✓ context7      — ライブラリドキュメント参照
  ✓ memory        — 永続メモリ
  ✓ linear        — タスク管理
  ✓ task-master-ai — タスク自動分解
  [✓ exa]         — Web検索（APIキー設定済の場合）
  [✓ firecrawl]   — Webスクレイピング（APIキー設定済の場合）

【インストール済みプラグイン】
  ✓ github / playwright / superpowers / security-guidance
  ✓ atomic-agents / claude-code-setup / skill-creator
  ✓ plugin-dev / claude-md-management / Notion / company

次のステップ：
  → Claude Code を再起動してプラグインを有効化
  → /superpowers を実行してセッションを初期化
  → claude.ai で Google/Slack/Notion 等の認証を完了

詳しいガイド → https://render-portal.pages.dev/claude-code-tools.html
```

---

## Notes

- コマンドが失敗した場合は理由を表示して次のステップに進む
- 既にインストール済みのMCPは「スキップ（既存）」と表示する
- ユーザーが途中でやめたい場合は「abort」でいつでも中断できる