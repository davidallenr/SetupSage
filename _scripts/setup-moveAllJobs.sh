#!/bin/bash

# Define the target directory
TARGET_DIR="$HOME/jobs"

# Create target directory if it doesn't exist
echo "Ensuring $TARGET_DIR exists..."
mkdir -p "$TARGET_DIR"

# Copy shell scripts to the target directory
echo "Copying shell scripts to $TARGET_DIR..."
cp ./*.sh "$TARGET_DIR"

# Make all files in the target directory executable
echo "Making all files in $TARGET_DIR executable..."
chmod +x "$TARGET_DIR"/*.sh

# Preparing to update crontab
echo "Preparing to update crontab with backup jobs..."

# Backup current crontab
CRONTAB_BACKUP="crontab_backup.txt"
crontab -l > "$CRONTAB_BACKUP"
echo "Current crontab backed up to $CRONTAB_BACKUP"

# Define start time
hour=7

# Remove existing backup jobs from crontab to avoid duplicates
grep -v 'backup-.*\.sh' "$CRONTAB_BACKUP" | crontab -
echo "Removed existing backup jobs from crontab."

# Find and schedule backup scripts
find "$TARGET_DIR" -type f -name "backup-*.sh" | sort | while read -r script; do
    # Check if we've reached 24 hours. Reset if needed.
    if [ $hour -ge 24 ]; then
        echo "Warning: More than 17 backup scripts found. Scheduling overlaps into the next day."
        hour=$(($hour % 24))
    fi

    # Format script for crontab
    job="0 $hour * * * $script"

    # Add new job to the crontab
    (crontab -l; echo "$job") | crontab -
    echo "Scheduled: $script to run at $hour:00"

    # Increment the hour for the next script
    hour=$((hour + 1))
done

echo "Crontab update completed. Backup scripts scheduled to run starting at 7 AM, one hour apart."
