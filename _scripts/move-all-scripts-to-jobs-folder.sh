#!/bin/bash

# Define the source and target directories with absolute paths
SOURCE_DIR="$HOME/SetupSage/_scripts"
TARGET_DIR="$HOME/jobs"

echo "Ensuring $TARGET_DIR exists..."
mkdir -p "$TARGET_DIR"

echo "Moving shell scripts to $TARGET_DIR and keeping folder structure..."

# Find all .sh files, excluding the move script, and replicate the folder structure in the target directory
find "$SOURCE_DIR" -type f -name "*.sh" ! -name "move-all-scripts-to-jobs-folder.sh" -print0 | while IFS= read -r -d $'\0' file; do
    # Calculate the subdirectory path relative to SOURCE_DIR
    subdir=$(dirname "${file#$SOURCE_DIR/}")
    # Full path for the target subdirectory
    target_subdir="$TARGET_DIR/$subdir"
    
    echo "Creating $target_subdir..."
    mkdir -p "$target_subdir"
    
    # Calculate the target file path
    target_file="$target_subdir/$(basename "$file")"
    echo "Moving $file to $target_file"
    mv "$file" "$target_file"
done

echo "Making all shell scripts in $TARGET_DIR and subdirectories executable..."
find "$TARGET_DIR" -type f -name "*.sh" -exec chmod +x {} +

echo "Script migration and permission update completed."
