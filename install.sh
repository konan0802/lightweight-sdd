#!/bin/bash

set -e

# カラー定義
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 使い方を表示
usage() {
    echo "Usage: $0 <target-project-directory>"
    echo ""
    echo "Example:"
    echo "  $0 /path/to/your/project"
    exit 1
}

# 引数チェック
if [ $# -ne 1 ]; then
    usage
fi

TARGET_DIR="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ターゲットディレクトリの存在確認
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}Error: Target directory does not exist: $TARGET_DIR${NC}"
    exit 1
fi

echo -e "${GREEN}=== Lightweight SDD インストール ===${NC}"
echo ""
echo "インストール先: $TARGET_DIR"
echo ""

# 既存ファイルの確認（lightweight-sdd が作成するファイルのみ）
EXISTING_FILES=()
if [ -f "$TARGET_DIR/.cursor/rules/lightweight-sdd.mdc" ]; then
    EXISTING_FILES+=(".cursor/rules/lightweight-sdd.mdc")
fi
if [ -f "$TARGET_DIR/.cursor/commands/spec.md" ]; then
    EXISTING_FILES+=(".cursor/commands/spec.md")
fi
if [ -f "$TARGET_DIR/.cursor/commands/tasks.md" ]; then
    EXISTING_FILES+=(".cursor/commands/tasks.md")
fi
if [ -f "$TARGET_DIR/.cursor/commands/implement.md" ]; then
    EXISTING_FILES+=(".cursor/commands/implement.md")
fi
if [ -f "$TARGET_DIR/STEERING.md" ]; then
    EXISTING_FILES+=("STEERING.md")
fi
if [ -d "$TARGET_DIR/specs" ]; then
    EXISTING_FILES+=("specs/")
fi

# 既存ファイルがある場合、バックアップの確認
if [ ${#EXISTING_FILES[@]} -gt 0 ]; then
    echo -e "${YELLOW}警告: 以下のファイル/ディレクトリが既に存在します:${NC}"
    for file in "${EXISTING_FILES[@]}"; do
        echo "  - $file"
    done
    echo ""
    echo -e "${YELLOW}既存のファイルは .backup-YYYYMMDD-HHMMSS サフィックスでバックアップされます。${NC}"
    read -p "続行しますか？ (y/N): " confirm
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo "インストールをキャンセルしました。"
        exit 0
    fi
    
    # バックアップ用のタイムスタンプ
    BACKUP_SUFFIX=".backup-$(date +%Y%m%d-%H%M%S)"
    
    # バックアップ作成
    for file in "${EXISTING_FILES[@]}"; do
        # 末尾スラッシュを除去してパスを正規化
        clean="${file%/}"
        if [ -e "$TARGET_DIR/$clean" ]; then
            echo "  バックアップ: $clean → ${clean}${BACKUP_SUFFIX}"
            mv "$TARGET_DIR/$clean" "$TARGET_DIR/${clean}${BACKUP_SUFFIX}"
        fi
    done
    echo ""
fi

# インストール開始
echo -e "${GREEN}インストール中...${NC}"
echo ""

# .cursor/rules/lightweight-sdd.mdc のコピー
echo "  [1/4] .cursor/rules/lightweight-sdd.mdc を作成"
mkdir -p "$TARGET_DIR/.cursor/rules"
cp "$SCRIPT_DIR/.cursor/rules/lightweight-sdd.mdc" "$TARGET_DIR/.cursor/rules/lightweight-sdd.mdc"

# .cursor/commands/ のコピー
echo "  [2/4] .cursor/commands/ をコピー"
mkdir -p "$TARGET_DIR/.cursor/commands"
cp "$SCRIPT_DIR/.cursor/commands/"*.md "$TARGET_DIR/.cursor/commands/"

# STEERING.md のコピー（テンプレートから）
echo "  [3/4] STEERING.md を作成（テンプレートから）"
cp "$SCRIPT_DIR/templates/STEERING.template.md" "$TARGET_DIR/STEERING.md"

# specs/ ディレクトリの作成
echo "  [4/4] specs/ ディレクトリを作成"
mkdir -p "$TARGET_DIR/specs"
touch "$TARGET_DIR/specs/.gitkeep"

# .git/info/exclude にインストールしたファイルをピンポイントで追加
if [ -d "$TARGET_DIR/.git" ]; then
    EXCLUDE_FILE="$TARGET_DIR/.git/info/exclude"
    EXCLUDE_MARKER="# lightweight-sdd"

    mkdir -p "$TARGET_DIR/.git/info"
    touch "$EXCLUDE_FILE"

    if ! grep -q "$EXCLUDE_MARKER" "$EXCLUDE_FILE"; then
        echo "" >> "$EXCLUDE_FILE"
        echo "$EXCLUDE_MARKER" >> "$EXCLUDE_FILE"
        echo ".cursor/rules/lightweight-sdd.mdc" >> "$EXCLUDE_FILE"
        echo ".cursor/commands/spec.md" >> "$EXCLUDE_FILE"
        echo ".cursor/commands/tasks.md" >> "$EXCLUDE_FILE"
        echo ".cursor/commands/implement.md" >> "$EXCLUDE_FILE"
        echo "STEERING.md" >> "$EXCLUDE_FILE"
        echo "specs/" >> "$EXCLUDE_FILE"
        echo "  .git/info/exclude に除外設定を追加しました"
    else
        echo "  .git/info/exclude は設定済みです（スキップ）"
    fi
fi

echo ""
echo -e "${GREEN}✓ インストール完了！${NC}"
echo ""
echo -e "${GREEN}=== 次のステップ ===${NC}"
echo ""
echo "1. STEERING.md を編集してプロジェクト情報を記入"
echo "2. Cursor で $TARGET_DIR を開く"
echo "3. 自然な会話でアイデアを話す"
echo "4. 必要に応じて以下のコマンドを使用:"
echo "   - /spec     : 会話を仕様書に整理 → specs/<YYYY-MM>-<slug>/spec.md を生成"
echo "   - /tasks    : 仕様をタスクに分解 → spec.md の Tasks セクションに追記"
echo "   - /implement: 実装ガイドラインを確認 → 完了後に spec.md を更新"
echo ""
echo -e "${YELLOW}カスタマイズ:${NC}"
echo "  - .cursor/rules/lightweight-sdd.mdc: 不要なセクションは削除してください"
echo "  - STEERING.md: プロジェクト情報を記入してください（コメントに記入例あり）"
echo ""
