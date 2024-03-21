#!/bin/bash

$FREQUENCY = 1 # Check every 1 second(s)

echo "Started GSR Sound Change Monitor..."

# Function to restart the start_replay.sh script
restart_start_replay() {
    # Kill the existing process if it's running
    killall -SIGINT gpu-screen-recorder
    # Start the script in a separate process
    ("$HOME/.gsr/gsr-start-replay.sh" &)
}

# Get the number of audio sources
get_audio_sources_count() {
    pacmd list-sources | grep -c 'index:'
}

# Get initial number of sinks (or monitors)
OLD_AUDIO_SOURCES_COUNT=$(get_audio_sources_count)

# Infinite loop to continuously monitor for changes
while true; do
    # Get the current number of sinks
    NEW_AUDIO_SOURCES_COUNT=$(get_audio_sources_count)

    # Check if the number of sinks has changed
    if [[ "$NEW_AUDIO_SOURCES_COUNT" -ne "$OLD_AUDIO_SOURCES_COUNT" ]]; then
        notify-send "gpu-screen-recorder" "Audio sources changed, restarting start-replay.sh..."
        echo "\e[92mgpu-screen-recorder\e[0m: Audio sources changed, restarting start-replay.sh..."
        # Restart the start_replay.sh script to adapt to the added/removed sinks
        restart_start_replay &
        OLD_AUDIO_SOURCES_COUNT="$NEW_AUDIO_SOURCES_COUNT"  # Update the old sinks
    fi
    sleep $FREQUENCY # Adjusted on init
done

# TODO: Replays break when restarting the script. Need to find a way to make it start replay all over.