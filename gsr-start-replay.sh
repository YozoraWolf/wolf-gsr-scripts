#!/bin/sh

# Set saved video Path
video_path="$HOME/Videos"

# Create it if it doesn't exist
mkdir -p "$video_path"

# Get a list of all audio sources
get_audio_sources() {
    pactl list short sources | awk '{print $2}' | grep -v '^alsa_input\|^combined.monitor'
}

# Combine all audio sources into one string, according to docs
merged_audio_sources=$(get_audio_sources | tr '\n' '|')
merged_audio_sources=${merged_audio_sources%|}

echo "\e[92mMerged audio sources:\e[0m $merged_audio_sources"

# Define arguments for gpu-screen-recorder
args="-w screen -fm cfr -f 60 -a $merged_audio_sources -k hevc -c mp4 -r 60 -o $video_path"

# Not really necessary to output, but helps with debug.
echo "\e[36mStarting recording with the following arguments:\e[0m $args"

# Start recording with combined audio sources
gpu-screen-recorder $args

