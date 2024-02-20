#!/bin/bash

# Load environment variables from .env file
if [ -f ".env" ]; then
    source .env
else
    echo ".env file not found, please ensure it exists in the same directory as this script."
    exit 1
fi

# Configuration
REPO_PATH="$RESTIC_REPOSITORY" # Updated to use variable from .env
SOURCE_DIR="$HOME/docker"
LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/restic_backup_$(date +%Y-%m-%d).txt"

# Ensure necessary directories exist
mkdir -p "$LOG_DIR" || { echo "Failed to ensure log directory exists. Exiting."; exit 1; } | tee -a "$LOG_FILE"

# VM Identifier
VM_ID=$(hostname)

# Generate tag based on VM ID and service directories
TAG="${VM_ID}-$(find "$SOURCE_DIR" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort | tr '\n' '-' | sed 's/-$//')"

echo "$(date '+%Y-%m-%d %H:%M:%S'): Starting Restic backup process with tag $TAG." | tee -a "$LOG_FILE"

# Restic environment variables
export RESTIC_REPOSITORY
export RESTIC_PASSWORD

# Perform the backup with the dynamically generated tag
restic backup "$SOURCE_DIR" --tag "$TAG" >> "$LOG_FILE" 2>&1

# Check the backup status
if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S'): Backup successful with tag $TAG." | tee -a "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S'): Backup failed. Check log for details." | tee -a "$LOG_FILE"
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S'): Restic backup process completed." | tee -a "$LOG_FILE"

# Running this file as a cron job and restoration example comments remain unchanged...

# Running this file as a cron job
# To run this script as a cron job, you can add it to the crontab file. Open the crontab file for editing:
# crontab -e
# Add the following line to run the script every day at 3:00 AM:
# 0 3 * * * /bin/bash /path/to/restic-docker-backup.sh

# Example on how to restore (included in comments for reference):
# To restore a specific service setup from the backup, replace 'TAG_TO_RESTORE' with the actual tag used during backup.
# Example TAG_TO_RESTORE: "arroverseer-server-overseerr-radarr-sabnzbd-sonarr"
# Example restoration command:
# export RESTIC_REPOSITORY="/path/to/restic/repo"
# export RESTIC_PASSWORD="your_restic_repo_password"
# restic restore latest --target "/path/to/restore_dir" --tag "TAG_TO_RESTORE"
