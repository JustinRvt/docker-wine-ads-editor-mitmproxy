#!/bin/bash

DATE=$(date +'%Y-%m-%d_%H-%M')
BACKUP_DIR="./backups"
SRC_DIR="./data"
DEST="$BACKUP_DIR/ads_data_backup_$DATE.tar.gz"

mkdir -p "$BACKUP_DIR"

tar -czf "$DEST" "$SRC_DIR"

echo "✔️ Backup enregistré ici : $DEST"
