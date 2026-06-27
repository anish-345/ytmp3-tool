#!/bin/bash

# Compile ytmp3 into standalone binary package
# This creates a distributable package for different architectures

set -e

echo "🎵 Compiling YouTube to MP3 Tool..."
echo ""

# Detect architecture
ARCH=$(uname -m)
echo "Detected architecture: $ARCH"

# Create binary directory
BIN_DIR="binaries/android-$ARCH"
mkdir -p "$BIN_DIR"

# Package all required components
echo "📦 Packaging components..."

# Copy main tool
cp ytmp3 "$BIN_DIR/ytmp3"
chmod +x "$BIN_DIR/ytmp3"

# Copy dependencies
echo "📦 Copying dependencies (ffmpeg, yt-dlp, deno)..."
cp dependencies/ffmpeg "$BIN_DIR/"
cp dependencies/yt-dlp "$BIN_DIR/"
cp dependencies/deno "$BIN_DIR/"
chmod +x "$BIN_DIR"/*

# Copy additional tools
cp ~/.termux/bin/ytmp3-auto "$BIN_DIR/" 2>/dev/null || true
cp ~/.termux/bin/ytmp3-widget "$BIN_DIR/" 2>/dev/null || true

# Create launcher script with dependencies
cat > "$BIN_DIR/run.sh" << 'EOF'
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
EOF

chmod +x "$BIN_DIR/run.sh"

# Create Flutter integration file
cat > "flutter-integration/ytmp3_method_channel.dart" << 'DARTEOF'
import 'package:flutter/services.dart';

class Ytmp3MethodChannel {
  static const MethodChannel _channel = MethodChannel('ytmp3');

  Future<String> convertYoutubeToMp3(String url) async {
    final String result = await _channel.invokeMethod('convertToMp3', {'url': url});
    return result;
  }

  Future<List<String>> getRecentMp3Files() async {
    final List<dynamic> result = await _channel.invokeMethod('getRecentFiles');
    return result.cast<String>().toList();
  }
}
DARTEOF

# Create APK assets structure
mkdir -p "apk-package/assets"
cp -r "$BIN_DIR"/* "apk-package/assets/"

# Create APK manifest
cat > "apk-package/manifest.json" << EOF
{
  "name": "YouTube to MP3",
  "version": "1.0.0",
  "description": "Convert YouTube videos to MP3",
  "architecture": "$ARCH",
  "permissions": ["INTERNET", "WRITE_EXTERNAL_STORAGE"],
  "entrypoint": "assets/run.sh"
}
EOF

echo ""
echo "✅ Compilation complete!"
echo "📁 Output: $BIN_DIR/"
echo ""
echo "📦 Package structure:"
ls -la "$BIN_DIR/"