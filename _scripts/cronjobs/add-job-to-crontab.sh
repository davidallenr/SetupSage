#!/bin/bash

# Define the cron job command and schedule
CRON_SCHEDULE="0 3 * * *"
CRON_CMD="/bin/bash /path/to/script.sh"
CRON_JOB="$CRON_SCHEDULE $CRON_CMD"

# Check if the cron job already exists
CRON_EXISTS=$(crontab -l | grep -F "$CRON_CMD" | wc -l)

if [ "$CRON_EXISTS" -eq "0" ]; then
    # The job doesn't exist, add it to crontab
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    echo "Cron job added: $CRON_JOB"
else
    # The job already exists, no action required
    echo "Cron job already exists, no action taken."
fi
