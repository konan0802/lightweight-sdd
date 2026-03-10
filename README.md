# Lightweight SDD

**Lightweight SDD（軽量SDD）** は、従来のSDDを軽量化・柔軟化した、実用的なソフトウェア設計開発（SDD）スタイルです。

## 🎯 コンセプト

従来のSDDは厳格なワークフローを要求しがちですが、Lightweight SDDは：

- **自然な会話からスタート** - まずはアイデアを自由に話す
- **必要な時だけ整理** - `/spec` で仕様書化、`/tasks` でタスク分解
- **ユーザー主導** - AIが勝手に進めず、ユーザーが主導権を持つ
- **コンテキスト管理** - `STEERING.md` でプロジェクトメモリを蓄積

## 🚀 クイックスタート

### 1. インストール

```bash
# このリポジトリをクローン
git clone https://github.com/your-username/lightweight-sdd.git
cd lightweight-sdd

# プロジェクトにインストール
./install.sh /path/to/your/project
```

### 2. 使い方

Cursor AIとの会話で以下のコマンドを使います：

| コマンド | 用途 | タイミング |
|---------|------|-----------|
| `/spec` | 会話内容を仕様書に整理 | アイデアが広がってきたら |
| `/tasks` | 仕様をタスク一覧に分解 | 仕様が確定したら |
| `/implement` | タスク実装のガイドライン確認 | 実装開始時 |

### 3. 基本的なワークフロー

```
1. 自然な会話でアイデアを話す
   ↓
2. `/spec` で仕様書に整理
   ↓
3. `/tasks` でタスク分解
   ↓
4. `/implement` を確認しながら実装
   ↓
5. 重要な決定は STEERING.md に記録
```

## 📁 ファイル構成

このSDDスタイルを適用すると、プロジェクトに以下のファイルが追加されます：

```
your-project/
├── .cursor/
│   ├── rules/
│   │   └── lightweight-sdd.mdc  # Cursor AIの動作ルール
│   └── commands/
│       ├── spec.md              # /spec コマンド定義
│       ├── tasks.md             # /tasks コマンド定義
│       └── implement.md         # /implement コマンド定義
├── STEERING.md                  # プロジェクトの意思決定記録
└── specs/                       # Spec単位の作業記録
    └── <YYYY-MM>-<slug>/
        └── spec.md              # 仕様・タスク・実装メモ・チャット履歴
```

### spec.md の構成

`/spec` を実行すると `specs/<YYYY-MM>-<slug>/spec.md` が生成されます。1ファイルに仕様からタスク・実装メモまでを集約することで、日を跨いだ作業でもコンテキストを失わずに進められます。

```
specs/2026-03-user-authentication/
└── spec.md
    ├── Status / 作成日 / 関連チャット
    ├── Spec（仕様）
    ├── Tasks（タスク一覧 + 進捗）
    ├── Implementation Notes（実装メモ）
    └── Chat History（関連チャットの履歴）
```

## 🎨 カスタマイズ

### Cursor ルールのカスタマイズ

`.cursor/rules/lightweight-sdd.mdc` として既存の `.cursorrules` に干渉せずインストールされます。
Terraform / gcloud / AWS / Docker / Git などの破壊的コマンドの実行制限も含まれています。
プロジェクトに応じて不要なセクションを削除してください。

### STEERING.md のカスタマイズ

`templates/STEERING.template.md` に記入例をコメントで記載しています。
`<!-- 例: ... -->` を参考に、プロジェクト情報を記入してください。

## 📚 ドキュメント構成の推奨

Lightweight SDDでは、以下のドキュメント構成を推奨します：

| ファイル | 役割 | 内容 |
|---------|------|------|
| `README.md` | プロジェクト紹介 | 外部向けの概要、セットアップ手順 |
| `STEERING.md` | 意思決定の記録 | なぜこうなったか、選択の背景と理由 |
| `specs/<YYYY-MM>-<slug>/spec.md` | Spec単位の作業記録 | 仕様・タスク・実装メモ・チャット履歴 |

## 🤖 AIの振る舞い

このSDDスタイルでは、AIは以下のように振る舞います：

### ✅ AIがすること
- 自然な会話で要件を理解
- `/spec`, `/tasks`, `/implement` コマンドで構造化
- 技術的な問題を根本原因から分析
- 重要な決定を `STEERING.md` に記録（ユーザー確認後）

### ❌ AIがしないこと
- 勝手にコミット・プッシュ（ユーザーが明示的に依頼した場合を除く）
- 破壊的なコマンドを無断実行
- 不確実な推測を事実のように提示

## 🔒 安全性

`.cursorrules` には、破壊的なコマンド（`terraform apply`, `git push`, `docker build`等）の実行前に、必ずユーザーに確認を取るルールが含まれています。

破壊的コマンドの制限ルールは `.cursor/rules/lightweight-sdd.mdc` に含まれています。

## 💡 他のSDDスタイルとの違い

| 特徴 | Lightweight SDD | 従来のSDD |
|-----|----------------|----------|
| ワークフロー | 柔軟（シンプルなコマンド） | 厳格（ステップを踏む） |
| 自動化 | 最小限 | 複雑な自動化 |
| コンテキスト管理 | STEERING.mdで蓄積 | なし or 複雑 |
| 学習コスト | 低い | 高い |

## 📄 ライセンス

MIT License - 詳細は [LICENSE](LICENSE) を参照

## 🤝 コントリビューション

Issue や Pull Request は大歓迎です！

## 🔗 リンク

- [Templates](templates/) - テンプレート集
