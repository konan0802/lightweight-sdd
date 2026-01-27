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

# 既存ファイルの確認
EXISTING_FILES=()
if [ -f "$TARGET_DIR/.cursorrules" ]; then
    EXISTING_FILES+=(".cursorrules")
fi
if [ -d "$TARGET_DIR/.cursor/commands" ]; then
    EXISTING_FILES+=(".cursor/commands/")
fi
if [ -f "$TARGET_DIR/STEERING.md" ]; then
    EXISTING_FILES+=("STEERING.md")
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
        if [ -e "$TARGET_DIR/$file" ]; then
            echo "  バックアップ: $file → ${file}${BACKUP_SUFFIX}"
            mv "$TARGET_DIR/$file" "$TARGET_DIR/${file}${BACKUP_SUFFIX}"
        fi
    done
    echo ""
fi

# インストール開始
echo -e "${GREEN}インストール中...${NC}"
echo ""

# .cursorrules のコピー
echo "  [1/3] .cursorrules をコピー"
cp "$SCRIPT_DIR/.cursorrules" "$TARGET_DIR/.cursorrules"

# .cursor/commands/ のコピー
echo "  [2/3] .cursor/commands/ をコピー"
mkdir -p "$TARGET_DIR/.cursor/commands"
cp "$SCRIPT_DIR/.cursor/commands/"*.md "$TARGET_DIR/.cursor/commands/"

# STEERING.md のコピー（テンプレートから）
echo "  [3/3] STEERING.md を作成（テンプレートから）"
cp "$SCRIPT_DIR/templates/STEERING.template.md" "$TARGET_DIR/STEERING.md"

echo ""
echo -e "${GREEN}✓ インストール完了！${NC}"
echo ""
echo -e "${GREEN}=== 次のステップ ===${NC}"
echo ""
echo "1. STEERING.md を編集してプロジェクト情報を記入"
echo "2. Cursor で $TARGET_DIR を開く"
echo "3. 自然な会話でアイデアを話す"
echo "4. 必要に応じて以下のコマンドを使用:"
echo "   - /spec     : 会話を仕様書に整理"
echo "   - /tasks    : 仕様をタスクに分解"
echo "   - /implement: 実装ガイドラインを確認"
echo ""
echo -e "${YELLOW}カスタマイズ例:${NC}"
echo "  - クラウド環境の場合: $SCRIPT_DIR/examples/.cursorrules.cloud-restrictions を参考"
echo "  - 記入例: $SCRIPT_DIR/examples/STEERING.example.md を参考"
echo ""
