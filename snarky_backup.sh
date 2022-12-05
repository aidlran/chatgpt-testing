#!/bin/bash

# Check if the drive is full
if df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | grep -E '^100%' >/dev/null 2>&1; then
  # Tell you off for being a data hoarder
  echo "Hey, you're a data hoarder! You need to clean up your drive and make some space before I can run the backup."
  exit 1
fi

# Run the backup
rsync -av --delete /source/ /destination/
