#!/bin/bash

echo "📀 Available disks:"
diskutil list

echo ""
read -p "Enter the SD card identifier (e.g., disk2): " DISK

echo "⚠️ This will erase everything on /dev/$DISK. Continue? (y/n)"
read CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
    echo "❌ Cancelled."
    exit 1
fi

# Unmount the disk
diskutil unmountDisk /dev/$DISK

# Format as FAT32 with MBR scheme (required for 3DS)
sudo diskutil eraseDisk FAT32 3DS MBRFormat /dev/$DISK

echo "✅ SD card successfully formatted as FAT32 (MBR, 32KB)"
