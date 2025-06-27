#!/bin/bash

# Path to the backup image (edit as needed)
IMAGE="$HOME/Downloads/backup_3ds.img"

# Path to the SD card device
DISK_ID="/dev/disk5"

echo "📥 Restoring image to SD card ($DISK_ID)..."
echo "⚠️ This will overwrite all data on the SD card!"

# Confirm action
read -p "Do you want to continue? (y/n): " CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
  echo "❌ Operation cancelled."
  exit 1
fi

# Unmount the SD card
diskutil unmountDisk $DISK_ID

# Restore the image to the SD card
sudo dd if="$IMAGE" of=$DISK_ID bs=1m status=progress

# Flush disk write buffers
sync

echo "✅ Image successfully restored."

exit 0
