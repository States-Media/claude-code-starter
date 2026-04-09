---
name: youtube-transcribe
description: >
  Transcribe YouTube videos locally using yt-dlp + whisper.cpp.
  Zero API keys, zero credits, fully offline after download.
  Downloads audio, transcribes to text, saves output.
user-invocable: true
argument-hint: "<youtube-url>"
---

# YouTube Transcribe

Local video transcription using yt-dlp + whisper.cpp. No API keys needed.

## Quick Start

```
/youtube-transcribe https://www.youtube.com/watch?v=VIDEO_ID
```

## Activation

When the user invokes this skill with a YouTube URL:

1. Parse URL from `$ARGUMENTS`
2. If no URL provided, ask for it
3. Execute the transcription pipeline below

## Pipeline

### Step 1 — Download audio

```bash
cd ~/youtube-transcriber
yt-dlp -x --audio-format wav --audio-quality 0 -o "%(title)s.%(ext)s" "<URL>"
```

If `yt-dlp` fails, try with cookies:
```bash
yt-dlp -x --audio-format wav --audio-quality 0 --cookies-from-browser chrome -o "%(title)s.%(ext)s" "<URL>"
```

### Step 2 — Transcribe with whisper

```bash
# Find the downloaded wav file
WAV_FILE=$(ls -t *.wav | head -1)

# Transcribe (use medium model for good balance of speed/quality)
whisper-cpp -m /opt/homebrew/share/whisper-cpp/models/ggml-medium.bin -f "$WAV_FILE" -otxt -of "output/transcricao_${WAV_FILE%.wav}"
```

If the medium model is not available, try:
```bash
# List available models
ls /opt/homebrew/share/whisper-cpp/models/

# Use whatever is available (prefer medium > small > base)
whisper-cpp -m /opt/homebrew/share/whisper-cpp/models/ggml-base.bin -f "$WAV_FILE" -otxt -of "output/transcricao_${WAV_FILE%.wav}"
```

If `whisper-cpp` is not found, try the python whisper:
```bash
pip3 install openai-whisper 2>/dev/null
whisper "$WAV_FILE" --model medium --output_format txt --output_dir output/
```

### Step 3 — File naming

Output format: `transcricao_[VIDEO_TITLE].[ext]`

Rules:
- Remove special characters (keep alphanumeric, spaces, hyphens, underscores)
- Replace spaces with underscores
- Limit filename to 150 characters
- Use UPPERCASE for readability

Example: `transcricao_O_QUE_CAUSOU_O_DESASTRE_DE_MAX_NO_MEXICO.txt`

### Step 4 — Cleanup

**ALWAYS ASK the user before deleting any video/audio files.**

1. Verify transcription files exist in `output/`
2. Show the user the transcription file path
3. ASK if they want to delete the source audio file
4. Only delete with explicit confirmation

### Step 5 — Report

Tell the user:
- Transcription file path
- Approximate word count
- Language detected
- Offer: "Want me to ingest this into the wiki? (/wiki-ingest)"

## Output Location

`~/youtube-transcriber/output/`

## Dependencies

- `yt-dlp` (installed by setup.sh)
- `ffmpeg` (installed by setup.sh)
- `whisper-cpp` or `openai-whisper` (installed by setup.sh)

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "yt-dlp not found" | `brew install yt-dlp` |
| "whisper-cpp not found" | `brew install whisper-cpp` |
| No model file | `whisper-cpp --download-model medium` |
| Download fails | Try adding `--cookies-from-browser chrome` |
| Audio too long (>1h) | Split first: `ffmpeg -i file.wav -f segment -segment_time 1800 chunk_%03d.wav` |
