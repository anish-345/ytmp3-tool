# 🎵 YouTube to MP3 Converter - Standalone Edition

## 📦 What's Included
| Component | Size | Type | Purpose |
|-----------|------|------|---------|
| `ytmp3` | 796 B | Bash script | Main launcher |
| `ytmp3-bin` | 12 MB | Python bundle | Standalone app |
| `ffmpeg` | 368 KB | Binary | MP3 encoder |
| `deno` | 89 MB | Binary | JS runtime |

**Total: ~90MB (or 12MB with Python version)**

## ✨ Features
- 🚀 **Single executable** - Just run and download!
- 🎵 Real MP3 encoding with ffmpeg
- 📱 Works on Android without Termux
- 🔧 No external dependencies (standalone version)
- ⚡ Small size with Python version (12 MB)

## 🚀 Quick Start

### Standalone (No Dependencies)
```bash
cd ~/ytmp3-repo/binaries/android-aarch64/
./ytmp3 https://youtube.com/watch?v=VIDEO_ID
```

### With Flutter
```dart
import 'package:ytmp3_flutter/ytmp3_flutter.dart';

final ytmp3 = Ytmp3Flutter.instance;
String result = await ytmp3.convertToMp3('https://youtu.be/VIDEO_ID');
```

### Native Android
See [FLUTTER_ANDROID_INTEGRATION.md](FLUTTER_ANDROID_INTEGRATION.md) for Kotlin/Java integration.

---

## 📁 Output
MP3 files saved to: `~/storage/downloads/` (Android)

---

## 💡 Why This Is Best
Unlike other tools that just rename `.m4a` files to `.mp3`, this tool:
1. Downloads the audio/video
2. **Re-encodes with ffmpeg**
3. **Creates proper MP3 with correct headers**
4. **Works in all media players**

---

## 📱 Integration Guides

| Platform | Guide |
|----------|-------|
| **Flutter** | [FLUTTER_ANDROID_INTEGRATION.md](FLUTTER_ANDROID_INTEGRATION.md) |
| **Native Android** | [FLUTTER_ANDROID_INTEGRATION.md#native-android-integration)` |
| **APK Packaging** | [FLUTTER_ANDROID_INTEGRATION.md#apk-packaging](FLUTTER_ANDROID_INTEGRATION.md#apk-packaging) |

---

## 📄 License
MIT License

## ⚠️ Disclaimer
For educational purposes only. Respect copyright laws.