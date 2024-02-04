#!/bin/bash

# Configuration
BACKUP_ROOT="/mnt/docker-config/"
LOG_DIR="$HOME/logs"
MAX_BACKUPS=5
LOG_FILE="$LOG_DIR/cleanup_log_$(date +%Y-%m-%d).txt"

# Start cleanup process
echo "$(date '+%Y-%m-%d %H:%M:%S'): Starting the cleanup process." | tee -a "$LOG_FILE"

# Ensure log directory exists
mkdir -p "$LOG_DIR" || { echo "$(date '+%Y-%m-%d %H:%M:%S'): Failed to ensure log directory exists. Exiting."; tee -a "$LOG_FILE"; exit 1; }

# Cleanup operation
find "$BACKUP_ROOT" -mindepth 1 -maxdepth 1 -type d | sort -r | tail -n +$((MAX_BACKUPS+1)) | while read -r dir; do
    if [[ "$dir" =~ ^$BACKUP_ROOT[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S'): Removing old backup directory: $dir" | tee -a "$LOG_FILE"
        rm -rf "$dir"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S'): Skipping non-conforming directory: $dir" | tee -a "$LOG_FILE"
    fi
done

echo "$(date '+%Y-%m-%d %H:%M:%S'): Cleanup completed." | tee -a "$LOG_FILE"

# Running this file as a cron job
# To run this script as a cron job, you can add it to the crontab file. Open the crontab file for editing:
# crontab -e
# Add the following line to run the script every day at 8:00 AM:
# 0 8 * * * /bin/bash /path/to/backup-cleanup-old.sh