# Claude Code Starter Pack

Render推奨のMCP・プラグインを3コマンドでまとめてセットアップするウィザード。

非エンジニアでもターミナル（PowerShell / Terminal）にコマンドを貼り付けるだけで完了する。

---

## インストール方法

### Step 1: マーケットプレイスを追加

```bash
claude plugin marketplace add AoiKugayama/claude-code-starter
```

### Step 2: プラグインをインストール

```bash
claude plugin install setup@claude-code-starter
```

### Step 3: セットアップウィザードを起動

Claude Code を開いて以下を入力：

```
/cc-setup
```

対話式で MCP・プラグインを順番にセットアップしてくれる。

---

## セットアップ内容

### 無料 MCP（APIキー不要）

| MCP | 機能 |
|-----|------|
| Context7 | ライブラリ最新ドキュメント参照 |
| Memory | 会話をまたぐ永続メモリ |
| Linear | タスク管理連携 |
| TaskMaster AI | AI タスク自動分解 |

### APIキーが必要な MCP

| MCP | 機能 | 取得先 |
|-----|------|--------|
| Exa | 意味理解型 Web 検索 | https://exa.ai（無料） |
| Firecrawl | Web スクレイピング | https://firecrawl.dev（無料） |

### プラグイン（無料）

`github` / `playwright` / `superpowers` / `security-guidance` / `atomic-agents` / `claude-code-setup` / `skill-creator` / `plugin-dev` / `claude-md-management` / `Notion` / `company`

---

## 詳しいガイド

各ツールの説明・使い方 → https://render-portal.pages.dev/claude-code-tools.html

---

## 作者

[AoiKugayama](https://github.com/AoiKugayama) / Render