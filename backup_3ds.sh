#!/bin/bash

# Path to the SD card device - update this if necessary
DISK_ID="/dev/disk5"

# Path where the backup image will be saved
DESTINATION=~/Downloads/backup_3ds_$(date +%Y-%m-%d_%H-%M-%S).img

echo "📤 Creating image of the SD card ($DISK_ID)..."
echo "💡 Make sure the SD card is unmounted!"

# Unmount the SD card to safely access it
diskutil unmountDisk $DISK_ID

# Create a full image of the SD card using dd
sudo dd if=$DISK_ID of="$DESTINATION" bs=1m status=progress

# Ensure all write buffers are flushed to disk
sync

echo "✅ Backup created at: $DESTINATION"

exit 0
