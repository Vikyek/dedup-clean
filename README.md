# Dedup & Clean

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A premium Python utility designed to scan directory structures, detect duplicate files by hash values, remove empty files (0-byte size), cleanup Windows leftover files (like `desktop.ini` and `thumbs.db`), clean up copy suffixes (renaming `file - Copy.txt` to `file.txt`), and purge empty directories.

This project packages the core deduplication and cleanup features into a modular package with three convenient interfaces.

---

## 📋 Requirements & Dependencies

- **Python:** Python 3.8+
- **System Utilities:** `libnotify` (`notify-send` for desktop notification alerts)
- **GUI & Web Dependencies:**
  - `python-tkinter` (standard library for standalone desktop GUI)
  - `Flask>=2.0.0` (for local Web Dashboard, see `requirements.txt`)

Install on Arch Linux:
```bash
sudo pacman -S python python-flask libnotify tk
```

---

## 🛠️ Features

1. **Deduplication:** Groups files by size first (to save hashing overhead), hashes size-duplicates using SHA-256, sorts candidates by modification time and path length, and deletes duplicate copies while preserving the oldest copy.
2. **Empty File Cleanup:** Purges all 0-byte size files.
3. **Windows remnant removal:** Deletes `desktop.ini`, `thumbs.db`, `.lnk` files, and system folders like `$RECYCLE.BIN` and `System Volume Information`.
4. **Name Cleanup:** Safely strips ` - Copy` suffixes from file names if no naming conflicts exist.
5. **Empty Directory purge:** Bottom-up recursive delete of folders containing no files.

---

## 🚀 Installation & Setup

### Automated Installation
```bash
git clone https://github.com/Vikyek/dedup-clean.git
cd dedup-clean
chmod +x install.sh
./install.sh
```

### Manual Installation
```bash
cd dedup-clean
pip install -r requirements.txt
```

---

## 💻 Running the Interfaces & Usage Examples

### 1. Command Line Interface (CLI)
Run the script, passing targets as arguments:

```bash
# Basic run on current folder
dedup-clean

# Scan specific directories
dedup-clean /path/to/folder1 /path/to/folder2

# Turn off copy suffix renaming or Windows file cleanups
dedup-clean --no-rename --no-win-clean

# Run a simulation only (Dry Run)
dedup-clean -d

# Non-interactive desktop notification run (perfect for shortcuts)
dedup-clean --notify /path/to/folder
```

### 2. Standalone Desktop GUI
Launch the dark-themed desktop Tkinter interface:

```bash
dedup-clean-gui
# Or: python3 gui.py
```

### 3. Local Web Dashboard
Launch the Flask web server:

```bash
dedup-clean-web
# Or: python3 web.py
```
Open **[http://localhost:5000](http://localhost:5000)** in your web browser. This interface separates results into individual review tabs (Duplicates, Empty Files, Windows remnants, Renames, Folders) and streams live cleanup logs to a terminal console.

---

## 🗁 Thunar File Manager Integration

You can integrate this utility directly into Thunar's right-click context menu:

1. Open Thunar and navigate to **Edit** ➔ **Configure custom actions...**
2. Add or Edit a custom action:
   - **Name:** `Deduplicate & Clean Files`
   - **Command:** `dedup-clean --notify %F`
   - **Icon:** `edit-clear`
   - **Under Appearance Conditions tab:** Check **Directories** and set File Pattern to `*`.

---

## 🔗 Part of a Larger Collection
This project is part of the **[Thunar-Action-Collection](https://github.com/Vikyek/Thunar-Action-Collection)**—a curated collection of custom Thunar action scripts and utilities designed to enhance the Thunar File Manager on Linux. Visit the collection repository for other useful actions and full setup guides.

---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
