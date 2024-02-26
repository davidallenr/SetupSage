#!/bin/bash

# Define the source and target directories with absolute paths
SOURCE_DIR="$HOME/SetupSage/_scripts"
TARGET_DIR="$HOME/jobs"

echo "Ensuring $TARGET_DIR exists..."
mkdir -p "$TARGET_DIR"

echo "Copying files to $TARGET_DIR and keeping folder structure..."

# Find all files, including hidden ones, excluding the move script, and replicate the folder structure in the target directory
# Adjust the find command to include hidden files
find "$SOURCE_DIR" \( -type f -name "*.sh" -or -name ".*" \) ! -name "copy-all-scripts-to-jobs-folder.sh" -print0 | while IFS= read -r -d $'\0' file; do
    # Calculate the subdirectory path relative to SOURCE_DIR
    subdir=$(dirname "${file#$SOURCE_DIR/}")
    # Full path for the target subdirectory
    target_subdir="$TARGET_DIR/$subdir"
    
    echo "Creating $target_subdir..."
    mkdir -p "$target_subdir"
    
    # Calculate the target file path
    target_file="$target_subdir/$(basename "$file")"
    echo "Copying $file to $target_file"
    cp "$file" "$target_file"
done

echo "Making all shell scripts in $TARGET_DIR and subdirectories executable..."
# Ensure only shell scripts (.sh files) are made executable
find "$TARGET_DIR" -type f -name "*.sh" -exec chmod +x {} +

echo "File copying and permission update completed."
