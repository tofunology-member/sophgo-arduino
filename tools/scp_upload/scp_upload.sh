#!/bin/bash
set -e

LOCAL_ELF="$1"
READELF="$2"
REMOTE_PATH="$3"

PASSWD=$($READELF $LOCAL_ELF -p .scp_passwd | grep -oP '\]\s*\K.*' | tr -d '\n')
REMOTE_USER=$($READELF $LOCAL_ELF -p .scp_username | grep -oP '\]\s*\K.*' | tr -d '\n')
REMOTE_HOST=$($READELF $LOCAL_ELF -p .scp_hostname | grep -oP '\]\s*\K.*' | tr -d '\n')

echo "Uploading $LOCAL_ELF to $REMOTE_USER@$:$REMOTE_PATH"
sshpass -p $PASSWD scp -O "$LOCAL_ELF" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"