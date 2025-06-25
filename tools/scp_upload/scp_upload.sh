#!/bin/bash
# $1: elfファイルのパス
# $2: リモートユーザー名
# $3: リモートホスト
# $4: リモート側の保存パス

set -e

LOCAL_ELF="$1"
REMOTE_USER="$2"
REMOTE_HOST="$3"
REMOTE_PATH="$4"

echo "Uploading $LOCAL_ELF to $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"
whoami
sleep 2
sshpass -p "milkv" scp -O "$LOCAL_ELF" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"