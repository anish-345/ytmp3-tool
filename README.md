# 🎵 YouTube to MP3 - Termux Tool

A powerful YouTube to MP3 converter for Termux that **actually encodes** to real MP3 format (not just renaming files).

## ✨ Features

- ✅ **Real MP3 encoding** using ffmpeg (not just file renaming)
- ✅ **Highest quality** (VBR 0)
- ✅ **Android intent sharing** support
- ✅ **Auto-detects shared URLs** from other apps
- ✅ **Simple commands** for all use cases

## 🚀 Quick Install

```bash
# Clone the repo
git clone https://github.com/yourusername/ytmp3-tool.git
cd ytmp3-tool

# Install
./install.sh
```

## 📱 Usage

### Share from Browser (Easiest!)
```
Browser → YouTube Video → Share → Termux
```

### Manual Commands
```bash
ytmp3 <url>        Convert YouTube URL
ytmp3-auto         Convert from clipboard
ytmp3-widget       Show recent MP3s
```

## 🔧 Requirements

- Termux app
- `yt-dlp` (auto-installed)
- `ffmpeg` (auto-installed)
- `deno` (for YouTube JS runtime)

## 📂 Output

All MP3s saved to: `~/storage/downloads/`

## 🎯 Why This Tool?

Unlike tools that just download m4a files and rename them, this tool **actually converts** to MP3 using ffmpeg:

```
Video/Audio → ffmpeg → REAL MP3 FILE
```

This means:
- ✅ Works in all media players
- ✅ Proper MP3 headers
- ✅ Re-encoded audio

## 📸 Preview

```
$ ytmp3 https://youtu.be/xxxxx
🎵 YouTube to MP3 Converter
==========================
📥 Downloading and converting...
Please wait...
[youtube] Extracting URL...
✅ Success! File saved to: /data/data/com.termux/files/home/storage/downloads

📁 Downloaded files:
-rw-rw----. 1 u0_a1 media_rw 1.2M Song Title.mp3
```

## 🤝 Contributing

Pull requests welcome! Add new features, improve documentation, or fix bugs.

## 📄 License

MIT License