#!/bin/bash

# Read the source and destination directories from command-line arguments
source="$1"
destination="$2"

# Check if the source and destination directories were provided
if [ -z "$source" ] || [ -z "$destination" ]; then
  # Print an error message and exit
  echo "Error: Please provide the source and destination directories as arguments."
  exit 1
fi

# Get the drive of the destination directory
destination_drive=$(df -P "$destination" | tail -1 | awk '{print $1}')

# Check if the drive is full
if df -H "$destination_drive" | grep -E '^100%' >/dev/null 2>&1; then
  # Tell you off for being a data hoarder
  echo "Hey, you're a data hoarder! You need to clean up your drive and make some space before I can run the backup."
  exit 1
fi

# Run the backup
rsync -av --delete --hard-links --perms $source $destination
