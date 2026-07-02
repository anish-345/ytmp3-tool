# 📱 Flutter & Native Android Integration Guide

This guide explains how to use the precompiled ytmp3 binaries in your Flutter and Android apps.

## 📋 Quick Start

### For Flutter Apps

1. **Add dependency** to `pubspec.yaml`:
```yaml
dependencies:
  ytmp3_flutter:
    path: ./flutter-integration
```

2. **Copy assets**:
```bash
mkdir -p android/app/src/main/assets/
cp ../binaries/android-aarch64/* android/app/src/main/assets/
```

3. **Update AndroidManifest.xml**:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
```

4. **Use in Dart**:
```dart
import 'package:ytmp3_flutter/ytmp3_flutter.dart';

final ytmp3 = Ytmp3Flutter.instance;
String result = await ytmp3.convertToMp3('https://youtu.be/VIDEO_ID');
```

### For Native Android

See [FLUTTER_ANDROID_INTEGRATION.md](../FLUTTER_ANDROID_INTEGRATION.md) for detailed instructions.

---

## 📦 Included Binaries

| Binary | Size | Purpose |
|--------|------|---------|
| `ytmp3` | 796 B | Main launcher script |
| `ffmpeg` | 368 KB | MP3 encoder |
| `deno` | 89 MB | JavaScript runtime |
| `yt-dlp` | 183 B | Python wrapper |

---

## 🎯 Architecture Support

- ✅ **arm64-v8a** - Modern Android phones (recommended)
- ✅ **armeabi-v7a** - Older phones (coming soon)
- ✅ **x86_64** - Android emulators

---

## 📄 License

MIT License - Free for personal and commercial use.