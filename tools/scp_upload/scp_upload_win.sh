#!/bin/bash
set -e

LOCAL_ELF="$1"
READELF="$2"
REMOTE_PATH="$3"
SSHPASS_PATH="$4"

PASSWD="$($READELF $(wslpath -w $LOCAL_ELF) -p .scp_passwd  | grep -A1 "\.scp_passwd" | tail -n1 | sed -E 's/^\s*\[[^]]*\]\s*//' | xargs | tr -d '\n' | sed 's/\r//g' )"
REMOTE_USER="$($READELF $(wslpath -w $LOCAL_ELF) -p .scp_username | grep -A1 "\.scp_username" | tail -n1 | sed -E 's/^\s*\[[^]]*\]\s*//' | xargs | tr -d '\n' | sed 's/\r//g')"
REMOTE_HOST="$($READELF $(wslpath -w $LOCAL_ELF) -p .scp_hostname | grep -A1 "\.scp_hostname" | tail -n1 | sed -E 's/^\s*\[[^]]*\]\s*//' | xargs | tr -d '\n' | sed 's/\r//g')"

REMOTE_ELF="${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"

echo "Uploading $LOCAL_ELF to $REMOTE_ELF"
$SSHPASS_PATH -p $PASSWD scp -O "$(wslpath -w $LOCAL_ELF)" "$REMOTE_ELF"