#!/bin/bash
set -e

# If not running as root, re-execute with sudo
if [[ "$EUID" -ne 0 ]]; then
  exec sudo "$0" "$@"
fi

# Read disk name and output path from config
DISK_NAME=$(grep '^disk_name:' config.yml | awk '{print $2}')
OUTPUT_PATH=$(grep '^output_path:' config.yml | awk '{print $2}')

# Find the most recent backup image
IMAGE=$(ls -t "${OUTPUT_PATH}"/backup_3ds_*.img 2>/dev/null | head -n 1)

# Check if an image was found
if [[ -z "$IMAGE" ]]; then
  echo "❌ No backup image found in $OUTPUT_PATH"
  exit 1
fi

# Resolve /dev/diskX from volume name
DISK_ID=$(diskutil list | grep "$DISK_NAME" | awk '{print "/dev/" $NF}' | sed 's/s[0-9]*$//')

echo "📥 Restoring image to SD card ($DISK_ID)..."
echo "🗂️  Backup image: $IMAGE"
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
