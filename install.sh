#!/bin/bash
# Installation script for standalone YouTube to MP3

set -e

echo "🎵 Installing YouTube to MP3 - Standalone Edition"
echo "==================================================="
echo

# Detect architecture
ARCH=$(uname -m)
echo "Detected architecture: $ARCH"

# Create bin directory
mkdir -p ~/.local/bin
mkdir -p ~/bin

# Copy to bin
cp ytmp3 ~/.local/bin/ytmp3
chmod +x ~/.local/bin/ytmp3

# Copy binaries
mkdir -p ~/.local/share/ytmp3
cp ffmpeg deno yt-dlp.js ~/.local/share/ytmp3/

# Update PATH
if ! grep -q '.local/bin' ~/.bashrc 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

# Create alias
if ! grep -q 'alias ytmp3=' ~/.bashrc 2>/dev/null; then
    echo 'alias ytmp3="~/.local/bin/ytmp3"' >> ~/.bashrc
fi

source ~/.bashrc

echo
echo "✅ Installation complete!"
echo
echo "Usage:"
echo "  ytmp3 <youtube-url>"
echo "  ytmp3 -u <url> -o my_song"
echo
echo "Files in: ~/.local/share/ytmp3/"
