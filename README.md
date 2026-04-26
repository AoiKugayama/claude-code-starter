# Claude Code スターターパック

Render推奨のMCP・プラグインを**1コマンドで一括セットアップ**するパッケージ。

非エンジニアでも「これを貼るだけで全部入る」を目指して設計しました。

---

## インストール — Windows

PowerShell を開いて、以下を貼り付けて Enter：

```powershell
irm https://raw.githubusercontent.com/AoiKugayama/claude-code-starter/main/install.ps1 | iex
```

> PowerShell は スタートメニュー → 「powershell」と検索 → 起動

---

## インストール — Mac

ターミナルを開いて、以下を貼り付けて Enter：

```bash
curl -fsSL https://raw.githubusercontent.com/AoiKugayama/claude-code-starter/main/install.sh | bash
```

> ターミナルは Finder → アプリケーション → ユーティリティ → ターミナル.app

---

## インストール後

1. **Claude Code を再起動**する
2. チャットに `/cc-setup` と入力 → 設定状況を確認

---

## インストールされるもの

### MCP サーバー（無料・自動）
| ツール | 機能 |
|---|---|
| Context7 | ライブラリの最新ドキュメントをAIが直接参照 |
| Memory | 会話をまたぐ永続メモリ |
| Linear | タスク管理ツールとの連携 |
| TaskMaster AI | AIによるタスク自動分解 |

### MCP サーバー（APIキー要・対話式）
スクリプト実行中にAPIキーを聞かれます。持っていなければ Enter でスキップ可。

| ツール | 機能 | APIキー取得先 |
|---|---|---|
| Exa | 意味理解型Web検索 | [exa.ai](https://exa.ai)（無料枠あり） |
| Firecrawl | Webスクレイピング | [firecrawl.dev](https://firecrawl.dev)（無料枠あり） |

### プラグイン（settings.json に自動登録）
`setup@cc-starter` — `/cc-setup` スキルを提供するセットアップウィザード

---

## 詳しいガイド

各ツールの機能・活用シーン・特徴 →
**https://render-portal.pages.dev/claude-code-tools.html**

---

## 作成者

[AoiKugayama / Render](https://github.com/AoiKugayama)