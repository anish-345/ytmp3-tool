# 🎵 YouTube to MP3 Converter - Standalone Edition

## 📦 What's Included
| Component | Size | Type |
|-----------|------|------|
| `ytmp3` | 796 B | Bash launcher script |
| `ytmp3-bin` | 12 MB | Python + yt-dlp bundle (ARM64) |
| `ffmpeg` | 368 KB | MP3 encoder (ARM64 Android) |

**Total: ~13 MB** (vs 90 MB for deno version)

## ✨ Features
- 🚀 **Single executable** - Just run and download!
- 🎵 Real MP3 encoding with ffmpeg
- 📱 Works on Android without Termux
- 🔧 No external dependencies
- ⚡ Much smaller than deno version (12 MB vs 89 MB)

## 🚀 Quick Start
```bash
# Download and use
git clone https://github.com/anish-345/ytmp3-tool.git
cd ytmp3-tool
./ytmp3 https://youtube.com/watch?v=VIDEO_ID
```

## 📁 Output
MP3 files saved to: `~/storage/downloads/`

## 📊 Size Comparison
| Version | Size | Description |
|---------|------|-------------|
| **Python Bundle** | 12 MB | ✅ Recommended - Python + yt-dlp bundled |
| Deno Version | 89 MB | JavaScript runtime (larger) |
| Lightweight | 1 MB | Requires Python + yt-dlp install |

## 💡 Technical Details
The `ytmp3-bin` executable is built with PyInstaller and includes:
- Python 3 runtime
- yt-dlp module for YouTube extraction
- All dependencies bundled

This provides the best balance of:
- ✅ Small size (12 MB)
- ✅ No external dependencies
- ✅ No Python installation needed
- ✅ Fast execution

## 📱 Android Usage
```bash
# In Termux or Android shell
./ytmp3 <youtube-url>

# With clipboard URL
./ytmp3 --clipboard
```

## 📄 License
MIT License

## ⚠️ Disclaimer
For educational purposes only. Respect copyright laws.
