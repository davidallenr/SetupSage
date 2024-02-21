#!/bin/bash

# Load environment variables
if [ -f "~/jobs/setup/restic/.env" ]; then
    source "~/jobs/setup/restic/.env"
else
    echo ".env file not found."
    exit 1
fi

# Update package lists to ensure you can download the latest version
echo "Updating package lists..."
sudo apt-get update

# Check if Restic is already installed
if command -v restic &> /dev/null; then
    echo "Restic is already installed. Version: $(restic version)"
else
    echo "Installing Restic..."
    # Install Restic using sudo
    sudo apt-get install -y restic

    # Verify the installation
    if command -v restic &> /dev/null; then
        echo "Restic installation successful. Version: $(restic version)"
    else
        echo "Restic installation failed."
        exit 1
    fi
fi

# Initialize Restic repository if not already initialized
if [ -z "$RESTIC_REPOSITORY" ] || [ -z "$RESTIC_PASSWORD" ]; then
    echo "RESTIC_REPOSITORY and RESTIC_PASSWORD must be set in .env.example"
    exit 1
else
    # Check if the repository is already initialized
    if restic -r "$RESTIC_REPOSITORY" snapshots &> /dev/null; then
        echo "Restic repository at $RESTIC_REPOSITORY is already initialized."
    else
        echo "Initializing Restic repository at $RESTIC_REPOSITORY..."
        echo "$RESTIC_PASSWORD" | restic -r "$RESTIC_REPOSITORY" init
        if [ $? -eq 0 ]; then
            echo "Restic repository initialized successfully."
        else
            echo "Failed to initialize Restic repository."
            exit 1
        fi
    fi
fi
