#!/bin/bash

# Define the source directory for docker-compose and configs
SOURCE_DIR="$HOME/docker"

# Backup destination directory on the NAS with YYYY-MM-DD format
BACKUP_ROOT="/mnt/docker-config/"
BACKUP_DEST="$BACKUP_ROOT/$(date +%Y-%m-%d)"
# Ensure the backup directory exists, or create it
mkdir -p "$BACKUP_DEST"

# Navigate to the source directory
cd "$SOURCE_DIR" || exit

# Dynamically build the list of directories (excluding hidden ones)
services=$(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | grep -v '^\.' | tr '\n' '-' | sed 's/-$//')

# Define the backup filename with a simple date format
BACKUP_FILENAME="${services}_backup.tar.gz"

# If the backup file for today already exists, remove it before creating a new one
[ -f "$BACKUP_DEST/$BACKUP_FILENAME" ] && rm "$BACKUP_DEST/$BACKUP_FILENAME"

# Create a single tarball including docker-compose.yml and all service directories
tar -zcvf "$BACKUP_DEST/$BACKUP_FILENAME" docker-compose.yml ${services// /}

echo "Backup completed successfully. File is stored in $BACKUP_DEST/$BACKUP_FILENAME"

# Cleanup: Remove backups older than 5 days
find "$BACKUP_ROOT/" -mindepth 1 -maxdepth 1 -type d -mtime +5 -exec rm -rf {} \;

echo "Old backups older than 5 days have been removed."


# Running this file as a cron job
# To run this script as a cron job, you can add it to the crontab file. Open the crontab file for editing:
# crontab -e
# Add the following line to run the script every day at 3:00 AM:
# 0 3 * * * /bin/bash /path/to/backup-docker-configs.sh