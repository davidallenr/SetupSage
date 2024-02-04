#!/bin/bash

echo "Starting the cleanup process."

BACKUP_ROOT="/mnt/docker-config/"
LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/cleanup_log_$(date +%Y-%m-%d).txt"

mkdir -p "$LOG_DIR" || { echo "Failed to ensure log directory exists. Exiting."; exit 1; }

# Logging cleanup start
echo "$(date): Cleanup process initiated." >> "$LOG_FILE"

# Cleanup operation
find "$BACKUP_ROOT" -mindepth 1 -maxdepth 1 -type d | sort -r | tail -n +6 | while read -r dir; do
    echo "Removing old backup directory: $dir" >> "$LOG_FILE"
    rm -rf "$dir"
done

echo "Cleanup process completed."
echo "$(date): Cleanup completed." >> "$LOG_FILE"


# Running this file as a cron job
# To run this script as a cron job, you can add it to the crontab file. Open the crontab file for editing:
# crontab -e
# Add the following line to run the script every day at 8:00 AM:
# 0 8 * * * /bin/bash /path/to/backup-cleanup-old.sh