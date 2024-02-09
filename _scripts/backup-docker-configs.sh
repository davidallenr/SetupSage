#!/bin/bash

# Configuration
SOURCE_DIR="$HOME/docker"
BACKUP_ROOT="/mnt/docker-config/"
LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/$(date +%Y-%m-%d)_backup_log.txt"  # Adjusted log file naming for better organization

# Start backup process
echo "$(date '+%Y-%m-%d %H:%M:%S'): Starting the backup process." | tee -a "$LOG_FILE"

# Ensure necessary directories exist
mkdir -p "$SOURCE_DIR" "$LOG_DIR" "$BACKUP_ROOT" || { echo "Failed to ensure source, log, or backup directories exist. Exiting."; exit 1; } | tee -a "$LOG_FILE"

# Backup preparation
BACKUP_DEST="$BACKUP_ROOT$(date +%Y-%m-%d)"
mkdir -p "$BACKUP_DEST" && echo "$(date '+%Y-%m-%d %H:%M:%S'): Created backup directory $BACKUP_DEST." | tee -a "$LOG_FILE"

cd "$SOURCE_DIR" || { echo "$(date '+%Y-%m-%d %H:%M:%S'): Could not navigate to source directory. Exiting."; tee -a "$LOG_FILE"; exit 1; }

# Building service list with validation for special characters
services=$(find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | grep -v '^\.' | tr '\n' ' ')
if echo "$services" | grep -q "[^a-zA-Z0-9_\- ]"; then
    echo "$(date '+%Y-%m-%d %H:%M:%S'): Service names contain special characters. Exiting." | tee -a "$LOG_FILE"
    exit 1
fi

# Adjust services format for tar command
services_formatted=$(echo $services | tr ' ' '\n' | grep -v '^\.' | tr '\n' '-' | sed 's/-$//')
BACKUP_FILENAME="${services_formatted}_backup_$(date +%Y-%m-%d).tar.gz"

# Check read/write permissions before attempting backup
if [ ! -r "$SOURCE_DIR" ] || [ ! -w "$BACKUP_DEST" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S'): Check permissions. Source directory read permission or backup destination write permission denied." | tee -a "$LOG_FILE"
    exit 1
fi

# Backup creation with error logging
if tar -zcf "$BACKUP_DEST/$BACKUP_FILENAME" docker-compose.yml $services > /dev/null 2>>"$LOG_FILE"; then
    echo "$(date '+%Y-%m-%d %H:%M:%S'): Backup successful. File: $BACKUP_DEST/$BACKUP_FILENAME" | tee -a "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S'): Backup failed. Check log for details." | tee -a "$LOG_FILE"
    exit 1
fi

# Running this file as a cron job
# To run this script as a cron job, you can add it to the crontab file. Open the crontab file for editing:
# crontab -e
# Add the following line to run the script every day at 3:00 AM:
# 0 3 * * * /bin/bash /path/to/backup-docker-configs.sh