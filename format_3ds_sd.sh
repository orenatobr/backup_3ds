#!/bin/bash
set -e

# If not running as root, re-execute with sudo
if [[ "$EUID" -ne 0 ]]; then
    exec sudo "$0" "$@"
fi

# Read disk name and output path from config
DISK_NAME=$(grep '^disk_name:' config.yml | awk '{print $2}')

# Check if DISK_NAME is a raw disk ID like "disk4"
if [[ "$DISK_NAME" =~ ^disk[0-9]+$ ]]; then
  DISK_ID="/dev/$DISK_NAME"
else
  DISK_ID=$(diskutil list | grep "$DISK_NAME" | awk '{print "/dev/" $NF}' | sed 's/s[0-9]*$//')
fi

echo "⚠️ This will erase everything on $DISK_ID. Continue? (y/n): "
read CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
    echo "❌ Cancelled."
    exit 1
fi

# Unmount the disk
diskutil unmountDisk $DISK_ID

# Erase and repartition the disk using MBR + FAT32 with 64KB clusters
diskutil eraseDisk FAT32 RENATO-3DS MBRFormat $DISK_ID

PARTITION_IDENTIFIER=$(diskutil list $DISK_ID | grep -E 'EFI|FAT32|DOS_FAT_32' | awk '{print $NF; exit}')

if [[ -z "$PARTITION_IDENTIFIER" ]]; then
    echo "❌ Could not find FAT32 partition. Aborting."
    exit 1
fi

echo "🔎 Using partition identifier: /dev/$PARTITION_IDENTIFIER"

# Unmount before formatting
diskutil unmount /dev/$PARTITION_IDENTIFIER

# Apply FAT32 format with 64KB clusters
newfs_msdos -F 32 -c 128 -v RENATO-3DS /dev/$PARTITION_IDENTIFIER

echo "✅ SD card successfully formatted as FAT32 (MBR, 64KB clusters)"

exit 0
