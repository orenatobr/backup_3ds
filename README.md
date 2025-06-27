# 📦 Backup and Restore Nintendo 3DS SD Card (macOS)

This repository provides two scripts to **fully back up** and **restore** SD cards used in **Nintendo 3DS** systems, using native macOS terminal tools.

---

## 🗂️ Contents

- `backup_3ds.sh` – Creates a full `.img` image of your 3DS SD card
- `restore_3ds.sh` – Restores a `.img` image back to your SD card
- `format_3ds:sd.sh` – Format 3DS SD card properly

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

```text
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

### ♻️ 4. Format 3DS SD card

Edit `format_3ds_sd.sh`:

- Confirm the correct disk ID

Then run:

```bash
chmod +x format_3ds_sd.sh
./format_3ds_sd.sh
```

You will be prompted to confirm before overwriting the SD card.

---

## 🧩 VSCode Integration (Optional)

You can now run these scripts directly from **Visual Studio Code** using `zsh` as the interpreter.

### ▶️ Running via `launch.json`

To enable this, add the following to your `.vscode/launch.json`:

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

### 💡 Tip

- Make sure the scripts have executable permission:  

  ```bash
  chmod +x backup_3ds.sh restore_3ds.sh format_3ds_sd.sh
  ```

- Ensure `zsh` is installed (default in modern macOS versions).

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
