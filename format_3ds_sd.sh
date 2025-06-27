#!/bin/bash

echo "📀 Available disks:"
diskutil list

echo ""
echo -n "Enter the SD card identifier (e.g., disk2): "
read DISK

echo "⚠️ This will erase everything on /dev/$DISK. Continue? (y/n): "
read CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
    echo "❌ Cancelled."
    exit 1
fi

# Unmount the disk
diskutil unmountDisk /dev/$DISK

# Erase and repartition the disk using MBR + FAT32 with 64KB clusters
diskutil eraseDisk FAT32 RENATO-3DS MBRFormat /dev/$DISK

PARTITION_IDENTIFIER=$(diskutil list /dev/$DISK | grep -E 'EFI|FAT32|DOS_FAT_32' | awk '{print $NF; exit}')

if [[ -z "$PARTITION_IDENTIFIER" ]]; then
    echo "❌ Could not find FAT32 partition. Aborting."
    exit 1
fi

echo "🔎 Using partition identifier: /dev/$PARTITION_IDENTIFIER"

# Unmount before formatting
diskutil unmount /dev/$PARTITION_IDENTIFIER

# Apply FAT32 format with 64KB clusters
sudo newfs_msdos -F 32 -c 128 -v RENATO-3DS /dev/$PARTITION_IDENTIFIER

echo "✅ SD card successfully formatted as FAT32 (MBR, 64KB clusters)"

exit 0
