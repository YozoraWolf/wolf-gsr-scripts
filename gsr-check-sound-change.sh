#!/bin/bash

# trap

lock_file="/tmp/gsr-lock"
# removes the lock file when the script exits
cleanup() {
    rm -f "$lock_file"
    echo "Lock file '$lock_file' removed."
}

trap 'cleanup; exit' INT TERM HUP

# Script related

FREQUENCY=1 # check every 1 second(s)

echo "Started GSR Sound Change Monitor..."

# func to restart the start_replay.sh script with the new default sink
restart_start_replay() {
    # Kill any existing screen sessions with the name "gsr"
    pkill -f "gsr-start-replay|gpu-screen-recorder"
    screen -ls | grep gsr | cut -d. -f1 | awk '{print $1}' | xargs -I {} screen -X -S {} quit
    cleanup

    # start the script in a separate process with the new default sink
    SINKS="$(pactl list short sinks | awk '{print $2 ".monitor"}' | tr '\n' '|' | sed 's/|$//')"
    notify-send "GSR Scripts" "Starting with sinks: $SINKS"
    echo "\e[92mGSR Scripts\e[0m: Starting with sinks: $SINKS"

    # Start a new screen session and execute the script inside it
    screen -L -Logfile $(dirname "$0")/screen_out.txt -dmS gsr bash -c "$HOME/.gsr/gsr-start-replay.sh \"$SINKS\""
}

# get initial number of sinks
OLD_NUM_SINKS=$(pactl list short sinks | wc -l)

# watch for changes in the number of sinks
while true; do
    # get the current number of sinks
    NEW_NUM_SINKS=$(pactl list short sinks | wc -l)

    # check if the number of sinks has changed
    if [ "$NEW_NUM_SINKS" -ne "$OLD_NUM_SINKS" ]; then
        notify-send "GSR Scripts" "Number of audio sinks changed, restarting start-replay.sh..."
        echo "\e[92mGSR Scripts\e[0m: Number of audio sinks changed, restarting start-replay.sh..."
        # Restart the start_replay.sh script
        restart_start_replay
        OLD_NUM_SINKS=$NEW_NUM_SINKS
    fi

    sleep $FREQUENCY
done