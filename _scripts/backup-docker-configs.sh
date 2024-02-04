#!/bin/bash

# Configuration
SOURCE_DIR="$HOME/docker"
BACKUP_ROOT="/mnt/docker-config/"
LOG_DIR="$HOME/logs"
MAX_BACKUPS=5 # This is not used in the backup script but added for consistency
LOG_FILE="$LOG_DIR/backup_log_$(date +%Y-%m-%d).txt"

# Start backup process
echo "$(date '+%Y-%m-%d %H:%M:%S'): Starting the backup process." | tee -a "$LOG_FILE"

# Ensure necessary directories exist
mkdir -p "$SOURCE_DIR" "$LOG_DIR" "$BACKUP_ROOT" || { echo "Failed to ensure source, log, or backup directories exist. Exiting."; exit 1; }

# Backup preparation
BACKUP_DEST="$BACKUP_ROOT$(date +%Y-%m-%d)"
mkdir -p "$BACKUP_DEST" && echo "$(date '+%Y-%m-%d %H:%M:%S'): Created backup directory $BACKUP_DEST." | tee -a "$LOG_FILE"

cd "$SOURCE_DIR" || { echo "$(date '+%Y-%m-%d %H:%M:%S'): Could not navigate to source directory. Exiting."; tee -a "$LOG_FILE"; exit 1; }

# Building service list
services=$(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | grep -v '^\.' | tr '\n' '-' | sed 's/-$//')
BACKUP_FILENAME="${services}_backup_$(date +%Y-%m-%d).tar.gz"

# Backup creation
if tar -zcf "$BACKUP_DEST/$BACKUP_FILENAME" docker-compose.yml ${services// /}; then
    echo "$(date '+%Y-%m-%d %H:%M:%S'): Backup successful. File: $BACKUP_DEST/$BACKUP_FILENAME" | tee -a "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S'): Backup failed." | tee -a "$LOG_FILE"
    exit 1
fi

# Running this file as a cron job
# To run this script as a cron job, you can add it to the crontab file. Open the crontab file for editing:
# crontab -e
# Add the following line to run the script every day at 3:00 AM:
# 0 3 * * * /bin/bash /path/to/backup-docker-configs.sh