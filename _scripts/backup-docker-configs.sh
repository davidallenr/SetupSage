#!/bin/bash

# Define the source directory for docker-compose and configs
SOURCE_DIR="$HOME/docker"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source directory does not exist. Exiting."
  exit 1
fi

# Backup destination directory on the NAS with YYYY-MM-DD format
BACKUP_ROOT="/mnt/docker-config/"
BACKUP_DEST="$BACKUP_ROOT$(date +%Y-%m-%d)"
# Ensure the backup directory exists, or create it
mkdir -p "$BACKUP_DEST" || { echo "Could not create backup directory. Exiting."; exit 1; }

# Navigate to the source directory
cd "$SOURCE_DIR" || { echo "Could not navigate to source directory. Exiting."; exit 1; }

# Dynamically build the list of directories (excluding hidden ones)
services=$(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | grep -v '^\.' | tr '\n' '-' | sed 's/-$//')

# Define the backup filename with a simple date format
BACKUP_FILENAME="${services}_backup.tar.gz"

# Check if the backup file for today already exists, and remove it
if [ -f "$BACKUP_DEST/$BACKUP_FILENAME" ]; then
  rm "$BACKUP_DEST/$BACKUP_FILENAME" || { echo "Could not remove existing backup file. Exiting."; exit 1; }
fi

# Create a single tarball including docker-compose.yml and all service directories
tar -zcf "$BACKUP_DEST/$BACKUP_FILENAME" docker-compose.yml ${services// /} || { echo "Backup failed. Exiting."; exit 1; }

echo "Backup completed successfully. File is stored in $BACKUP_DEST/$BACKUP_FILENAME"

# Ensure the logs directory exists
LOG_DIR="$HOME/logs"
mkdir -p "$LOG_DIR"

# Cleanup: Remove backups older than 5 days and log the deleted directories
find "$BACKUP_ROOT" -mindepth 1 -maxdepth 1 -type d -mtime +5 -exec sh -c 'echo "Removing directory: $1" >> "$HOME/logs/backup_cleanup.log"; rm -rf "$1"' _ {} \; || { echo "Cleanup failed. Old backups may still exist."; }

# Logging the completion
echo "$(date): Backup and cleanup completed." >> "$LOG_DIR/backup_log.txt"

# Running this file as a cron job
# To run this script as a cron job, you can add it to the crontab file. Open the crontab file for editing:
# crontab -e
# Add the following line to run the script every day at 3:00 AM:
# 0 3 * * * /bin/bash /path/to/backup-docker-configs.sh