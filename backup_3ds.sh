#!/bin/bash
set -e

# If not running as root, re-execute with sudo
if [[ "$EUID" -ne 0 ]]; then
    exec sudo "$0" "$@"
fi

# Check for config file
if [[ ! -f config.yml ]]; then
    echo "❌ config.yml not found. Aborting."
    exit 1
fi

# Read disk name and output path from config
DISK_NAME=$(grep '^disk_name:' config.yml | awk '{print $2}')
OUTPUT_PATH=$(grep '^output_path:' config.yml | awk '{print $2}')

# Resolve /dev/diskX from volume name
DISK_ID=$(diskutil list | grep "$DISK_NAME" | awk '{print "/dev/" $NF}' | sed 's/s[0-9]*$//')

# Validate disk
if [[ ! -e $DISK_ID ]]; then
    echo "❌ Disk device not found for volume '$DISK_NAME'."
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_PATH"

# Compose final destination path
DESTINATION="${OUTPUT_PATH}/backup_3ds_$(date +%Y-%m-%d_%H-%M-%S).img"

# Unmount and backup
echo "📤 Creating image of the SD card ($DISK_ID)..."
echo "💡 Make sure the SD card is unmounted!"
diskutil unmountDisk $DISK_ID
sudo dd if=$DISK_ID of="$DESTINATION" bs=1m status=progress
sync

echo -e "\n✅ SD card successfully backed up to:\n$DESTINATION\n"
exit 0
