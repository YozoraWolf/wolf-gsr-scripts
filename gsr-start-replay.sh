#!/bin/sh

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
    audio_sinks="$default_sink"
else
    # else if no errors found, use provided audio sinks
    audio_sinks="$1"
fi

echo "\e[92mSelected audio sinks:\e[0m $audio_sinks"

# define args for gsr
args="-w screen -fm vfr -f 60 -a $audio_sinks -ac opus -k hevc -c mp4 -r 60 -o $video_path"

# debug, can be commented.
echo "\e[36mStarting recording with the following arguments:\e[0m $args"

# check if gpu-screen-recorder is installed
if command -v gpu-screen-recorder >/dev/null 2>&1; then
    # execute cli version
    gpu-screen-recorder $args
elif flatpak info com.dec05eba.gpu_screen_recorder >/dev/null 2>&1; then
    # else, execute flatpak version
    flatpak run --command=gpu-screen-recorder com.dec05eba.gpu_screen_recorder $args
else
    # if none are installed, output error and exit.
    echo "Error: gpu-screen-recorder is not available or installed."
    exit 1
fi