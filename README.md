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
├── .cursorrules              # Cursor AIの動作ルール
├── .cursor/
│   └── commands/
│       ├── spec.md           # /spec コマンド定義
│       ├── tasks.md          # /tasks コマンド定義
│       └── implement.md      # /implement コマンド定義
└── STEERING.md               # プロジェクトの意思決定記録
```

## 🎨 カスタマイズ

### .cursorrules のカスタマイズ

基本的な `.cursorrules` に加えて、プロジェクトの特性に応じたルールを追加できます：

- **クラウド環境の場合**: `examples/.cursorrules.cloud-restrictions` を参考に、破壊的コマンドの実行制限を追加
- **最小構成**: `examples/.cursorrules.minimal` を参考に、必要最小限のルールのみ適用

### STEERING.md のカスタマイズ

`templates/STEERING.template.md` をベースに、プロジェクトの意思決定を記録します。

記入例は `examples/STEERING.example.md` を参照してください。

## 📚 ドキュメント構成の推奨

Lightweight SDDでは、以下のドキュメント構成を推奨します：

| ファイル | 役割 | 内容 |
|---------|------|------|
| `README.md` | プロジェクト紹介 | 外部向けの概要、セットアップ手順 |
| `STEERING.md` | 意思決定の記録 | なぜこうなったか、選択の背景と理由 |
| `BACKLOG.md` | 今後の計画 | やりたいこと、Phase計画、優先順位 |

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

詳細は `examples/.cursorrules.cloud-restrictions` を参照してください。

## 💡 他のSDDスタイルとの違い

| 特徴 | Lightweight SDD | 従来のSDD |
|-----|----------------|----------|
| ワークフロー | 柔軟（シンプルなコマンド） | 厳格（ステップを踏む） |
| 自動化 | 最小限 | 複雑な自動化 |
| コンテキスト管理 | STEERING.mdで蓄積 | なし or 複雑 |
| 学習コスト | 低い | 高い |

## 🛠️ 開発の背景

このSDDスタイルは、[swing-trade-bot](https://github.com/your-username/swing-trade-bot) プロジェクトでの実践から生まれました。

cc-sdd スタイルのSDDを使っていましたが、以下の課題がありました：

- ワークフローが硬く、自動化されすぎて理解が浅くなる
- コンテキストが肥大化しやすい
- ユーザー主導で進められない

そこで、**自然な会話 → 必要に応じて整理** というシンプルなフローを採用し、実用性を重視したスタイルを確立しました。

## 📄 ライセンス

MIT License - 詳細は [LICENSE](LICENSE) を参照

## 🤝 コントリビューション

Issue や Pull Request は大歓迎です！

## 🔗 リンク

- [Examples](examples/) - 実例とカスタマイズ例
- [Templates](templates/) - テンプレート集
