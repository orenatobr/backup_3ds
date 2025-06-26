# 📦 Backup and Restore Nintendo 3DS SD Card (macOS)

This repository provides two scripts to **fully back up** and **restore** SD cards used in **Nintendo 3DS** systems, using native macOS terminal tools.

---

## 🗂️ Contents

- `backup_3ds.sh` – Creates a full `.img` image of your 3DS SD card
- `restore_3ds.sh` – Restores a `.img` image back to your SD card

---

## ⚙️ Requirements

- macOS with Terminal access
- Administrator permissions (sudo)
- SD card inserted via USB reader or SD slot

---

## 🚀 Usage

### 🔍 1. Identify the SD card

In your terminal, run:

```bash
diskutil list
```

Look for a line like:

```
/dev/disk5 (external, physical):
```

⚠️ **Important:** double-check the correct disk number (`disk5`, etc). Using the wrong disk could erase your system!

---

### 🧱 2. Back up the SD card

Edit `backup_3ds.sh` and set the correct disk ID:

```bash
DISK_ID="/dev/disk5"
```

Then run:

```bash
chmod +x backup_3ds.sh
./backup_3ds.sh
```

The script will create a `.img` file on your Desktop with the current date and time in the filename.

---

### ♻️ 3. Restore the SD card

Edit `restore_3ds.sh`:

- Update the path to the `.img` file
- Confirm the correct disk ID

Then run:

```bash
chmod +x restore_3ds.sh
./restore_3ds.sh
```

You will be prompted to confirm before overwriting the SD card.

---

## 💡 Tips

- **Unmount the SD card** before using these scripts
- The image includes **partition table, bootloader, and data** — it's a full 1:1 clone
- Great for backing up before modifying files like `boot.firm`, CIAs, or saves
- Works with SD cards up to 128GB (or more depending on format)

---

## ⚠️ Warning

These scripts are powerful — double check you're targeting the correct disk. Incorrect use could wipe other drives.

---

## 📄 License

For personal use. No warranty. Feel free to modify and adapt as needed.
