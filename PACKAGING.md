# 📦 Packaging Guide

## Repository Structure

```
ytmp3-repo/
├── ytmp3                    # Main tool (binary)
├── install.sh               # Termux installer
├── README.md               # Documentation
├── LICENSE                 # MIT License
├── CHANGELOG.md            # Version history
│
├── binaries/
│   └── android-aarch64/    # Pre-compiled binaries
│       ├── ytmp3           # Main binary
│       └── run.sh         # Launcher script
│
├── flutter-integration/    # Flutter plugin
│   ├── lib/
│   │   ├── ytmp3_flutter.dart
│   │   └── ytmp3_method_channel.dart
│   ├── android/
│   │   └── ytmp3_runner.kt
│   └── pubspec.yaml
│
└── apk-package/           # Ready for APK bundling
    ├── assets/
    │   ├── ytmp3
    │   └── run.sh
    └── manifest.json
```

## For Flutter Apps

### 1. Copy Assets
```bash
cp -r binaries/android-aarch64/* your_flutter_app/assets/
```

### 2. Add to pubspec.yaml
```yaml
assets:
  - assets/ytmp3
  - assets/run.sh
```

### 3. Use in Dart Code
```dart
import 'package:ytmp3_flutter/ytmp3_flutter.dart';

final ytmp3 = Ytmp3Flutter.instance;
String result = await ytmp3.convertToMp3('https://youtu.be/xxxxx');
```

## For APK Distribution

### 1. Build APK
```bash
cd apk-package
# Include assets in your APK build
```

### 2. Required Permissions
Add to `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
```

## Architecture Support

| Arch | File | Devices |
|------|------|---------|
| arm64-v8a | binaries/android-aarch64/ytmp3 | Most modern phones |
| armeabi-v7a | *(not compiled yet)* | Older phones |
| x86_64 | *(not compiled yet)* | Emulators |

## Next Steps

1. ✅ Clone this repo
2. ✅ Compile for your target architectures
3. ✅ Integrate with Flutter
4. ✅ Build and test APK
5. ✅ Publish to Google Play Store!