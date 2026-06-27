package com.example.ytmp3_flutter

import android.util.Log
import java.io.File

class Ytmp3Runner {
    private val TAG = "Ytmp3Runner"
    
    /**
     * Run YouTube to MP3 conversion
     */
    fun convertToMp3(url: String, assetsDir: android.content.Context): String {
        try {
            // Get the binary from assets
            val binaryFile = File(assetsDir.filesDir, "ytmp3")
            
            // Make it executable
            binaryFile.setExecutable(true)
            
            // Build command
            val process = android.os.ProcessBuilder()
                .command(binaryFile.absolutePath, url)
                .redirectErrorStream(true)
                .start()
            
            // Wait for completion
            val exited = process.waitFor(30, java.util.concurrent.TimeUnit.SECONDS)
            
            if (exited) {
                return "Success: MP3 converted and saved to Downloads"
            } else {
                process.destroy()
                return "Error: Conversion timed out"
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error converting MP3: ${e.message}")
            return "Error: ${e.message}"
        }
    }
}