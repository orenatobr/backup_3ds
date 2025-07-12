# 📦 Backup and Restore Nintendo 3DS SD Card (macOS)

This repository provides three scripts to **fully back up**, **restore**, and **format** SD cards used in **Nintendo 3DS** systems, using native macOS terminal tools.

---

## 🗂️ Contents

- `backup_3ds.sh` – Creates a full `.img` image of your 3DS SD card
- `restore_3ds.sh` – Restores a `.img` image back to your SD card
- `format_3ds_sd.sh` – Formats the 3DS SD card properly for use

---

## ⚙️ Requirements

- macOS with Terminal access
- Administrator permissions (`sudo`)
- SD card inserted via USB reader or SD slot

---

## 🚀 Usage

### 🔍 1. Identify the SD card

In your terminal, run:

```bash
diskutil list
```

Look for a line like:

```text
/dev/disk5 (external, physical):
```

⚠️ **Important:** double-check the correct disk number (`disk5`, etc). Using the wrong disk could erase your system!

---

### 🧱 2. Back up the SD card

Edit `config.yml` and set the correct `disk_name` (volume label) and `output_path`:

```yaml
disk_name: RENATO-3DS
output_path: /Users/youruser/Backups
```

Then run:

```bash
chmod +x backup_3ds.sh
./backup_3ds.sh
```

---

### ♻️ 3. Restore the SD card

Ensure the most recent `.img` file is in the `output_path`. Then run:

```bash
chmod +x restore_3ds.sh
./restore_3ds.sh
```

You will be prompted to confirm before overwriting the SD card.

---

### 🧼 4. Format the 3DS SD card

```bash
chmod +x format_3ds_sd.sh
./format_3ds_sd.sh
```

You will be prompted to confirm before formatting. The script uses MBR + FAT32 (64KB clusters) format.

---

## 🧩 VSCode Integration (Optional)

You can run the scripts directly from **Visual Studio Code** using `zsh`.

### ▶️ `launch.json`

Add this to `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Run 3DS Backup Script",
      "type": "node",
      "request": "launch",
      "runtimeExecutable": "zsh",
      "args": [
        "${workspaceFolder}/backup_3ds.sh"
      ],
      "console": "integratedTerminal"
    },
    {
      "name": "Run 3DS Restore Script",
      "type": "node",
      "request": "launch",
      "runtimeExecutable": "zsh",
      "args": [
        "${workspaceFolder}/restore_3ds.sh"
      ],
      "console": "integratedTerminal"
    },
    {
      "name": "Format 3DS SD Script",
      "type": "node",
      "request": "launch",
      "runtimeExecutable": "zsh",
      "args": [
        "${workspaceFolder}/format_3ds_sd.sh"
      ],
      "console": "integratedTerminal"
    }
  ]
}
```

> ⚠️ These scripts require `sudo`. You’ll be prompted to enter your password in the terminal during execution.

---

## 🔓 Optional: Run Without Prompting for `sudo` Password

You can allow these scripts to run **without typing your password**, using a secure `sudoers` rule.

### Step 1: Open the `sudoers` file

```bash
sudo visudo
```

### Step 2: Add this line at the end (replace `youruser` with your actual macOS username):

```bash
youruser ALL=(ALL) NOPASSWD: /Users/youruser/Workspace/backup_3ds/backup_3ds.sh, /Users/youruser/Workspace/backup_3ds/restore_3ds.sh, /Users/youruser/Workspace/backup_3ds/format_3ds_sd.sh, /sbin/newfs_msdos
```

> 🔐 This allows only these scripts and the `newfs_msdos` formatter to run without a password prompt. It does **not** affect other `sudo` commands.

### Step 3: Inside each script, make sure this logic is at the top:

```bash
if [[ "$EUID" -ne 0 ]]; then
  exec sudo "$0" "$@"
fi
```

This ensures the script self-elevates if not already run with `sudo`.

---

## 💡 Tips

- **Unmount the SD card** before using these scripts
- The backup includes **partition table, bootloader, and data** — it's a full 1:1 clone
- Useful before modifying files like `boot.firm`, CIAs, or save games
- Works with SD cards up to 128GB or more

---

## ⚠️ Warning

These scripts are powerful — always double check you're targeting the correct disk. Incorrect use could wipe important data.

---

## 📄 License

For personal use. No warranty. Feel free to modify and adapt.
