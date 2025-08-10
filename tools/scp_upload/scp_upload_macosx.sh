#!/bin/bash
set -e

LOCAL_ELF="$1"
READELF="$2"
REMOTE_PATH="$3"

PASSWD=$($READELF $LOCAL_ELF -x .scp_passwd  | awk '/0x/{for(i=2;i<=NF;i++)printf $i} END{print ""}' | xxd -r -p | strings)
REMOTE_USER=$($READELF $LOCAL_ELF -x .scp_username | awk '/0x/{for(i=2;i<=NF;i++)printf $i} END{print ""}' | xxd -r -p | strings)
REMOTE_HOST=$($READELF $LOCAL_ELF -x .scp_hostname | awk '/0x/{for(i=2;i<=NF;i++)printf $i} END{print ""}' | xxd -r -p | strings)

echo "Uploading $LOCAL_ELF to $REMOTE_USER@$:$REMOTE_PATH"
sshpass -p $PASSWD scp -O "$LOCAL_ELF" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"