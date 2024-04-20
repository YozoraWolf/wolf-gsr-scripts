#!/bin/sh

# Single instance lock

lock_file="/tmp/gsr-lock"

# Check if the lock file exists if so, then there's another instance running
if [ -f "$lock_file" ]; then
    echo "Error: Another instance is already running."
    exit 1
fi

# create lock file

create_lock_file() {
    # attempt to create the lock file with maximum retries
    attempt=0
    max_attempts=3

    while [ $attempt -lt $max_attempts ]; do
        touch "$lock_file" && break
        attempt=$((attempt + 1))
        sleep 1
    done

    # check if the lock file was created successfully, if not, exit the program.
    if [ ! -f "$lock_file" ]; then
        echo "Failed to create lock file after $max_attempts attempts."
        exit 1
    fi

    echo "Lock file created successfully."
}

# removes the lock file when the script exits
cleanup() {
    rm -f "$lock_file"
    echo "Lock file removed."
}

trap 'cleanup; exit' INT TERM HUP

# Script related

# Rest of your script
# set saved video path (they will be moved on save)
video_path="$HOME/Videos"

# create dir it if it doesn't exist
mkdir -p "$video_path"

# check if any audio sinks are provided as arguments
if [ -z "$1" ]; then
    # if no audio sinks provided, get the default sink
    default_sink=$(pactl get-default-sink)
    if [ -z "$default_sink" ]; then
        echo "Error: No default audio sink found."
        exit 1
    fi
    audio_sinks="$default_sink.monitor"
else
    # else if no errors found, use provided audio sinks
    audio_sinks="$1"
fi

echo "\e[92mSelected audio sinks:\e[0m $audio_sinks"

# define args for gsr
args="-w screen -fm cfr -f 60 -a $audio_sinks -ac aac -k h264 -c mp4 -r 60 -o $video_path"

# debug, can be commented.
echo "\e[36mStarting recording with the following arguments:\e[0m $args"

# check if gpu-screen-recorder is installed
if command -v gpu-screen-recorder >/dev/null 2>&1; then
    # execute cli version
    create_lock_file
    gpu-screen-recorder $args
elif flatpak info com.dec05eba.gpu_screen_recorder >/dev/null 2>&1; then
    # else, execute flatpak version
    create_lock_file
    flatpak run --command=gpu-screen-recorder com.dec05eba.gpu_screen_recorder $args
else
    # if none are installed, output error and exit.
    echo "Error: gpu-screen-recorder is not available or installed."
    exit 1
fi
