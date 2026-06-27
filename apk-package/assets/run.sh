#!/bin/bash
# Launcher script for Flutter integration
# Includes all dependencies

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Add to PATH so dependencies can be found
export PATH="$SCRIPT_DIR:$PATH"

# Set environment
export HOME="/data/data/com.termux/files/home"

# Create temp bin with deps
export TMPDIR="$SCRIPT_DIR"

# Run the command
exec "$SCRIPT_DIR/ytmp3" "$@"
