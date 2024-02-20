#!/bin/bash

# Define the source and target directories
SOURCE_DIR="./_scripts" # Adjusted to specify the new source directory
TARGET_DIR="$HOME/jobs"

# Ensure the target directory exists
echo "Ensuring $TARGET_DIR exists..."
mkdir -p "$TARGET_DIR"

# Move shell scripts to the target directory, excluding the specified script
echo "Moving shell scripts to $TARGET_DIR..."
find "$SOURCE_DIR" -type f -name "*.sh" ! -name "move-all-scripts-to-jobs-folder.sh" -exec mv {} "$TARGET_DIR" \;

# Make all files in the target directory executable
echo "Making all files in $TARGET_DIR executable..."
chmod +x "$TARGET_DIR"/*.sh

echo "Script migration and permission update completed."
