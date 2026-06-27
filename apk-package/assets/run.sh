#!/bin/bash
# Launcher script for Flutter integration

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Set environment
export PATH="$SCRIPT_DIR:$PATH"
export HOME="/data/data/com.termux/files/home"

# Run the command
"$SCRIPT_DIR/ytmp3" "$@"
