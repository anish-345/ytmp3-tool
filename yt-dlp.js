// YouTube to MP3 converter using Deno
// No Python required!

const YOUTUBE_API = "https://www.youtube.com/youtubei/v1/player";

function extractVideoId(url) {
    const patterns = [
        /(?:youtube\.com\/watch\?v=|youtu\.be\/)([^\"&?\/]+)/,
        /youtube\.com\/embed\/([^\"&?\/]+)/,
    ];
    for (const pattern of patterns) {
        const match = url.match(pattern);
        if (match) return match[1];
    }
    return null;
}

async function getVideoInfo(videoId) {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), 30000);
    
    try {
        const response = await fetch(YOUTUBE_API, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                context: { client: { clientName: "WEB", clientVersion: "1.0" } },
                videoId: videoId
            }),
            signal: controller.signal
        });
        clearTimeout(timeoutId);
        return await response.json();
    } catch (e) {
        clearTimeout(timeoutId);
        throw e;
    }
}

function parseArgs() {
    const args = Deno.args;
    return {
        url: args[0],
        outputDir: args[1] || "." ,
        outputName: args[2] || null
    };
}

async function main() {
    const { url, outputDir, outputName } = parseArgs();
    
    if (!url) {
        console.error("Usage: ytmp3.js <youtube-url> <output-dir> [output-name]");
        Deno.exit(1);
    }
    
    const videoId = extractVideoId(url);
    if (!videoId) {
        console.error("Invalid YouTube URL");
        Deno.exit(1);
    }
    
    console.log("🎵 Processing:", videoId);
    
    try {
        const info = await getVideoInfo(videoId);
        console.log("📄 Video info retrieved");
        // In a full implementation, this would use ffmpeg.wasm to convert
        console.log("✅ Would convert to MP3 (full implementation needed)");
        console.log("Output would be:", `${outputDir}/${outputName || videoId}.mp3`);
    } catch (e) {
        console.error("Error:", e.message);
        Deno.exit(1);
    }
}

if (import.meta.main) {
    await main();
}
