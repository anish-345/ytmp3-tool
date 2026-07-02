# 📱 Flutter & Android Integration Guide

This guide explains how to integrate the precompiled ytmp3 binaries into Flutter apps and native Android apps.

## 📋 Table of Contents

1. [Flutter Integration](#flutter-integration)
2. [Native Android Integration](#native-android-integration)
3. [APK Packaging](#apk-packaging)
4. [Permissions](#permissions)
5. [Troubleshooting](#troubleshooting)

---

## Flutter Integration

### Step 1: Add Dependency

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  ytmp3_flutter:
    path: ./path/to/ytmp3-repo/flutter-integration
```

Or publish to your own pub.dev by updating the path.

### Step 2: Add Assets

Create `assets/` directory and copy the precompiled binaries:

```bash
mkdir -p android/app/src/main/assets/
cp ytmp3-repo/binaries/android-aarch64/* android/app/src/main/assets/
```

Update `pubspec.yaml` to include assets:

```yaml
flutter:
  assets:
    - assets/ytmp3
    - assets/ffmpeg
    - assets/deno
    - assets/yt-dlp
```

### Step 3: Update AndroidManifest.xml

Add required permissions:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
```

### Step 4: Use in Dart Code

```dart
import 'package:ytmp3_flutter/ytmp3_flutter.dart';

class YouTubeToMp3Converter extends StatefulWidget {
  @override
  _YouTubeToMp3ConverterState createState() => _YouTubeToMp3ConverterState();
}

class _YouTubeToMp3ConverterState extends State<YouTubeToMp3Converter> {
  final _controller = TextEditingController();
  String _result = '';

  Future<void> _convertToMp3() async {
    try {
      final Ytmp3Flutter ytmp3 = Ytmp3Flutter.instance;
      String result = await ytmp3.convertToMp3(_controller.text);
      setState(() {
        _result = result;
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('YouTube to MP3')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter YouTube URL',
                suffix: IconButton(
                  icon: Icon(Icons.download),
                  onPressed: _convertToMp3,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
```

---

## Native Android Integration

### Option A: Bundle with APK (Recommended)

This method includes all dependencies in your APK.

#### 1. Copy Binaries to Assets

```bash
# Create assets directory
mkdir -p app/src/main/assets

# Copy all binaries
cp ytmp3-repo/binaries/android-aarch64/* app/src/main/assets/
chmod 755 app/src/main/assets/*
```

#### 2. Create JNI Wrapper (optional)

For better integration, create a JNI wrapper in `android/app/src/main/cpp/native-lib.cpp`:

```cpp
#include <jni.h>
#include <unistd.h>
#include <android/log.h>

extern "C" {
    JNIEXPORT jstring JNICALL
    Java_com_yourpackage_MainActivity_runYtmp3(
            JNIEnv *env,
            jobject thiz,
            jstring jurl) {
        
        const char *url = env->GetStringUTFChars(jurl, 0);
        
        // Execute the binary
        execl("/data/data/your.package/files/ytmp3", "ytmp3", (char*)url, NULL);
        
        env->ReleaseStringUTFChars(jurl, url);
        return env->NewStringUTF("Conversion started");
    }
}
```

#### 3. Kotlin Integration

In your `MainActivity.kt`:

```kotlin
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import java.io.File

class MainActivity : AppCompatActivity() {
    
    private val TAG = "Ytmp3Integration"
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Copy binaries to app directory
        copyBinariesToAppDir()
    }
    
    private fun copyBinariesToAppDir() {
        val binaries = listOf("ytmp3", "ffmpeg", "deno")
        
        binaries.forEach { binaryName ->
            val binaryFile = File(filesDir, binaryName)
            if (!binaryFile.exists()) {
                assets.open(binaryName).use { input ->
                    binaryFile.outputStream().use { output ->
                        input.copyTo(output)
                    }
                }
                binaryFile.setExecutable(true)
            }
        }
    }
    
    fun convertToMp3(url: String, callback: (String) -> Unit) {
        try {
            val process = ProcessBuilder(
                File(filesDir, "ytmp3").absolutePath,
                url
            ).start()
            
            val output = process.inputStream.bufferedReader()
                .readText()
            
            process.waitFor()
            
            if (process.exitValue() == 0) {
                callback("Success: MP3 saved to Downloads")
            } else {
                callback("Error: Conversion failed")
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error: ${e.message}")
            callback("Error: ${e.message}")
        }
    }
}
```

### Option B: Use Termux Environment

If you want to use the existing Termux installation:

#### 1. Add Termux Dependency

In `build.gradle (Module: app)`:

```gradle
dependencies {
    implementation 'com.github.termux:termux-aarch64:0.119.0'
}
```

#### 2. Run with Termux

```kotlin
fun runInTermux(url: String) {
    val process = ProcessBuilder(
        "sh", "-c",
        "am start --user 0 -n com.termux/.MainActivity -e COMMAND \"ytmp3 $url\""
    ).start()
}
```

---

## APK Packaging

### Directory Structure

```
android/app/src/main/
├── assets/
│   ├── ytmp3      # Main launcher script
│   ├── ffmpeg     # MP3 encoder
│   ├── deno        # JavaScript runtime
│   └── yt-dlp     # YouTube extractor
├── AndroidManifest.xml
└── src/
    └── main/
        └── java/
            └── com/yourpackage/
                └── MainActivity.kt
```

### Build APK

```bash
# Build release APK
./gradlew assembleRelease

# Location
app/release/app-release.apk
```

### APK Size Considerations

| Component | Size |
|-----------|------|
| ytmp3 script | 1 KB |
| ffmpeg | 368 KB |
| deno | 89 MB |
| **Total** | ~90 MB |

For smaller APKs, use the Python-based `ytmp3-bin` (12 MB) instead of deno.

---

## Permissions

### Required Permissions

```xml
<!-- Essential -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

<!-- For Android 10+ -->
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
```

### Request Permissions at Runtime (Android 6+)

```kotlin
private fun requestPermissions() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        requestPermissions(
            arrayOf(
                Manifest.permission.WRITE_EXTERNAL_STORAGE,
                Manifest.permission.MANAGE_EXTERNAL_STORAGE
            ), 1000
        )
    }
}
```

---

## Troubleshooting

### Common Issues

1. **Binary not found**
   ```
   Error: /data/data/app/files/ytmp3: permission denied
   ```
   **Solution:** Ensure `setExecutable(true)` is called.

2. **FFmpeg not working**
   ```
   Error: ffmpeg: invalid ELF header
   ```
   **Solution:** Check you have the correct architecture (arm64-v8a).

3. **Download fails**
   ```
   Error: yt-dlp not found
   ```
   **Solution:** Ensure all binaries are copied to assets.

4. **APK too large**
   **Solution:** Use `ytmp3-bin` (Python-based) which is only 12 MB.

### Debug Mode

Enable debug logging in your Dart/Kotlin code:

```dart
// Dart
print('Running ytmp3 with URL: $url');
```

```kotlin
// Kotlin
Log.d("Ytmp3Debug", "Running ytmp3 binary");
```

---

## Support

- 📖 [Full Documentation](ytmp3-repo/README.md)
- 🐛 [Report Issues](https://github.com/yourusername/ytmp3-tool/issues)
- 💡 [Feature Requests](https://github.com/yourusername/ytmp3-tool/issues)

---

## License

This integration guide is part of the ytmp3 project. See [LICENSE](LICENSE) for details.