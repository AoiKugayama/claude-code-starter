# Claude Code スターターパック

Render推奨のMCP・プラグインを**3コマンドで一括セットアップ**するパッケージ。

非エンジニアでも「これを実行すれば全部入る」を目指して設計しました。

---

## インストール手順

```bash
# 1. このマーケットプレイスを追加
claude plugins add marketplace cc-starter github:AoiKugayama/claude-code-starter

# 2. セットアップウィザードをインストール
claude plugin install setup@cc-starter

# 3. ウィザードを起動（Claude Codeのチャットで入力）
/cc-setup
```

---

## このパッケージで入るもの

### MCP サーバー（無料）
| ツール | 機能 |
|---|---|
| Context7 | ライブラリの最新ドキュメントをAIが直接参照 |
| Memory | 会話をまたぐ永続メモリ |
| Linear | タスク管理ツールとの連携 |
| TaskMaster AI | AIによるタスク自動分解 |

### MCP サーバー（APIキー要）
| ツール | 機能 | APIキー取得先 |
|---|---|---|
| Exa | 意味理解型Web検索 | [exa.ai](https://exa.ai)（無料枠あり） |
| Firecrawl | Webスクレイピング | [firecrawl.dev](https://firecrawl.dev)（無料枠あり） |

### プラグイン（公式・無料）
`github` / `playwright` / `superpowers` / `security-guidance` / `atomic-agents` / `claude-code-setup` / `skill-creator` / `plugin-dev` / `claude-md-management` / `Notion` / `company(cc-company)`

---

## 詳しいガイド

各ツールの機能・活用シーン・特徴 →
**https://render-portal.pages.dev/claude-code-tools.html**

---

## 作成者

[AoiKugayama / Render](https://github.com/AoiKugayama)