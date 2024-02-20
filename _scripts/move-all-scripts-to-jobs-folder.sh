#!/bin/bash

# Define the source and target directories
SOURCE_DIR="$HOME/SetupSage/_scripts" # Ensure this is the absolute path
TARGET_DIR="$HOME/jobs"

# Ensure the target directory exists
echo "Ensuring $TARGET_DIR exists..."
mkdir -p "$TARGET_DIR"

# Move shell scripts to the target directory, excluding the specified script
echo "Moving shell scripts to $TARGET_DIR and keeping folder structure..."

# Find all .sh files, excluding the move script, and replicate the folder structure in the target directory
find "$SOURCE_DIR" -type f -name "*.sh" ! -name "move-all-scripts-to-jobs-folder.sh" -print0 | while IFS= read -r -d $'\0' file; do
    # Extract the subdirectory path
    subdir=$(dirname "${file#$SOURCE_DIR/}")
    # Create the corresponding subdirectory in the target directory
    mkdir -p "$TARGET_DIR/$subdir"
    # Move the file to the corresponding subdirectory in the target directory
    mv "$file" "$TARGET_DIR/$subdir/"
done

# Make all .sh files in the target directory and subdirectories executable
echo "Making all shell scripts in $TARGET_DIR and subdirectories executable..."
find "$TARGET_DIR" -type f -name "*.sh" -exec chmod +x {} +

echo "Script migration and permission update completed."
