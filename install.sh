#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${HOME}/.local/bin"

echo "=== Installing Dedup & Clean ==="

# Check python
if ! command -v python3 >/dev/null 2>&1; then
    echo "Error: python3 is required." >&2
    exit 1
fi

# Install requirements
if [ -f "${SCRIPT_DIR}/requirements.txt" ]; then
    python3 -m pip install -r "${SCRIPT_DIR}/requirements.txt" 2>/dev/null || pip install -r "${SCRIPT_DIR}/requirements.txt" || echo "Note: Check Flask installation."
fi

mkdir -p "${BIN_DIR}"

cat <<'LAUNCHER' > "${BIN_DIR}/dedup-clean"
#!/usr/bin/env bash
REAL_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
DIR_PATH="$(dirname "$REAL_DIR")/dedup-clean"
if [ ! -f "${DIR_PATH}/cli.py" ]; then
    DIR_PATH="${HOME}/Projects/Thunar-Action/dedup-clean"
fi
if [ -f "${DIR_PATH}/cli.py" ]; then
    python3 "${DIR_PATH}/cli.py" "$@"
else
    python3 "$(dirname "${BASH_SOURCE[0]}")/cli.py" "$@"
fi
LAUNCHER
chmod +x "${BIN_DIR}/dedup-clean"

cat <<'LAUNCHER' > "${BIN_DIR}/dedup-clean-gui"
#!/usr/bin/env bash
REAL_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
DIR_PATH="$(dirname "$REAL_DIR")/dedup-clean"
if [ ! -f "${DIR_PATH}/gui.py" ]; then
    DIR_PATH="${HOME}/Projects/Thunar-Action/dedup-clean"
fi
if [ -f "${DIR_PATH}/gui.py" ]; then
    python3 "${DIR_PATH}/gui.py" "$@"
else
    python3 "$(dirname "${BASH_SOURCE[0]}")/gui.py" "$@"
fi
LAUNCHER
chmod +x "${BIN_DIR}/dedup-clean-gui"

cat <<'LAUNCHER' > "${BIN_DIR}/dedup-clean-web"
#!/usr/bin/env bash
REAL_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
DIR_PATH="$(dirname "$REAL_DIR")/dedup-clean"
if [ ! -f "${DIR_PATH}/web.py" ]; then
    DIR_PATH="${HOME}/Projects/Thunar-Action/dedup-clean"
fi
if [ -f "${DIR_PATH}/web.py" ]; then
    python3 "${DIR_PATH}/web.py" "$@"
else
    python3 "$(dirname "${BASH_SOURCE[0]}")/web.py" "$@"
fi
LAUNCHER
chmod +x "${BIN_DIR}/dedup-clean-web"

echo "Dedup & Clean installed successfully to ${BIN_DIR}!"
echo "Commands: dedup-clean, dedup-clean-gui, dedup-clean-web"
