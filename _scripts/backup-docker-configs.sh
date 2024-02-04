#!/bin/bash

echo "Starting the backup process."

# Define the source directory for docker-compose and configs
SOURCE_DIR="$HOME/docker"
BACKUP_ROOT="/mnt/docker-config/"
LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/backup_log_$(date +%Y-%m-%d).txt"

# Ensure necessary directories exist
mkdir -p "$SOURCE_DIR" "$LOG_DIR" "$BACKUP_ROOT" || { echo "Failed to ensure source, log, or backup directories exist. Exiting."; exit 1; }

# Log start
echo "$(date): Backup process initiated." >> "$LOG_FILE"

# Backup preparation
BACKUP_DEST="$BACKUP_ROOT$(date +%Y-%m-%d)"
mkdir -p "$BACKUP_DEST" || { echo "Could not create backup directory. Exiting."; exit 1; }
cd "$SOURCE_DIR" || { echo "Could not navigate to source directory. Exiting."; exit 1; }

# Building service list
services=$(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | grep -v '^\.' | tr '\n' '-' | sed 's/-$//')
BACKUP_FILENAME="${services}_backup_$(date +%Y-%m-%d).tar.gz"

# Removing existing backup for today, if any
if [ -f "$BACKUP_DEST/$BACKUP_FILENAME" ]; then
  echo "Removing existing backup file for today." >> "$LOG_FILE"
  rm "$BACKUP_DEST/$BACKUP_FILENAME" || { echo "Could not remove existing backup file. Exiting."; exit 1; }
fi

# Creating new backup
echo "Creating backup file: $BACKUP_FILENAME"
tar -zcf "$BACKUP_DEST/$BACKUP_FILENAME" docker-compose.yml ${services// /} || { echo "Backup failed. Exiting."; exit 1; }

echo "Backup completed successfully. File is stored in $BACKUP_DEST/$BACKUP_FILENAME"
echo "$(date): Backup successful. File: $BACKUP_DEST/$BACKUP_FILENAME" >> "$LOG_FILE"


# Running this file as a cron job
# To run this script as a cron job, you can add it to the crontab file. Open the crontab file for editing:
# crontab -e
# Add the following line to run the script every day at 3:00 AM:
# 0 3 * * * /bin/bash /path/to/backup-docker-configs.sh