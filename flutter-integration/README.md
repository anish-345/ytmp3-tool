# Flutter Integration Guide

## Overview
This directory contains files for integrating YouTube to MP3 functionality into a Flutter app.

## Files

### 1. Method Channel (Android)
`ytmp3_method_channel.dart` - Dart code for Android platform channel

### 2. Android Integration
`android/ytmp3_runner.kt` - Kotlin code to run the binary

### 3. Assets
`assets/` - Pre-compiled binaries for different architectures

## Usage

### In your Flutter app:

```dart
import 'package:ytmp3_flutter/ytmp3_method_channel.dart';

// Convert YouTube URL to MP3
final result = await Ytmp3MethodChannel().convertYoutubeToMp3(
  'https://youtu.be/xxxxx'
);
print('MP3 saved: $result');
```

### In Android code:

```kotlin
// MainActivity.kt
methodChannel.setMethodCallHandler { call, result ->
  when (call.method) {
    "convertToMp3" -> {
      val url = call.argument<String>("url")
      // Run ytmp3 binary
      val output = runYtmp3(url)
      result.success(output)
    }
  }
}
```

## Architecture Support

- `android-arm64` ✓ (most devices)
- `android-arm` ✓ (older devices)
- `android-x64` ✓ (emulators)

## Permissions Required

- INTERNET
- WRITE_EXTERNAL_STORAGE
- MANAGE_EXTERNAL_STORAGE (for Android 10+)

## Notes

- Requires Termux to be installed, OR
- Bundle all dependencies in your APK
- Test on real devices for best compatibility