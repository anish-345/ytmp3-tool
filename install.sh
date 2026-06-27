#!/bin/bash

# YouTube to MP3 - Installation Script
# Run this after cloning the repository

set -e

echo "🎵 Installing YouTube to MP3 Tool..."
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "📦 Installing dependencies..."

# Update packages
pkg update -y

# Install required packages
pkg install -y ffmpeg yt-dlp deno

echo "🔧 Installing ytmp3 tool..."

# Create bin directory
mkdir -p ~/.termux/bin
mkdir -p ~/bin

# Copy main tool
cp ytmp3 ~/.termux/bin/ytmp3
chmod +x ~/.termux/bin/ytmp3

# Copy all tools
cp ytmp3-auto ~/.termux/bin/ 2>/dev/null || true
cp ytmp3-widget ~/.termux/bin/ 2>/dev/null || true
cp ytmp3-guide ~/.termux/bin/ 2>/dev/null || true

# Setup intent handler
cat > ~/bin/termux-url-opener << 'EOF'
#!/bin/bash
URL="$1"
if [[ "$URL" =~ ^https?://(www\.)?(youtube|youtu|youtube-nocookie)\.(com|be)/ ]]; then
    echo "🎵 Processing YouTube URL..."
    ~/.termux/bin/ytmp3-auto "$URL"
fi
EOF
chmod +x ~/bin/termux-url-opener

# Update PATH
if ! grep -q 'export PATH=' ~/.bashrc | grep -q 'bin'; then
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
fi
if ! grep -q 'export PATH=' ~/.bashrc | grep -q '.termux/bin'; then
    echo 'export PATH="$HOME/.termux/bin:$PATH"' >> ~/.bashrc
fi

# Reload bashrc
source ~/.bashrc

# Create downloads directory
mkdir -p ~/storage/downloads

echo ""
echo -e "${GREEN}✅ Installation Complete!${NC}"
echo ""
echo -e "${YELLOW}Quick Start:${NC}"
echo "1. Share a YouTube URL from your browser to Termux"
echo "2. Or run: ytmp3 <youtube-url>"
echo ""
echo "Output: ~/storage/downloads/"
echo ""
echo "📋 Available commands:"
echo "   ytmp3 <url>        Manual conversion"
echo "   ytmp3-auto         Auto mode"
echo "   ytmp3-widget       Show recent MP3s"
echo ""