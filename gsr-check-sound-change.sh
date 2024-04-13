#!/bin/bash

FREQUENCY=1 # check every 1 second(s)

echo "Started GSR Sound Change Monitor..."

# func to restart the start_replay.sh script with the new default sink
restart_start_replay() {
    # kill the existing process if it's running
    killall -SIGINT gpu-screen-recorder
    # start the script in a separate process with the new default sink
    "$HOME/.gsr/gsr-start-replay.sh" $(pactl get-default-sink).monitor &
}

# get initial default sink
OLD_DEFAULT_SINK=$(pactl get-default-sink)

# loop to monitor for changes
while true; do
    # Get the current default sink
    NEW_DEFAULT_SINK=$(pactl get-default-sink)

    # check if the default sink has changed
    if [[ $NEW_DEFAULT_SINK != $OLD_DEFAULT_SINK ]]; then
        notify-send "gpu-screen-recorder" "Default audio sink changed, restarting start-replay.sh..."
        echo -e "\e[92mgpu-screen-recorder\e[0m: Default audio sink changed, restarting start-replay.sh..."
        # restart the start_replay.sh script with the new default sink
        restart_start_replay
        OLD_DEFAULT_SINK=$NEW_DEFAULT_SINK
    fi
    sleep $FREQUENCY
done