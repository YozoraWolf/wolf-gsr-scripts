#!/bin/bash

# Send SIGUSR1 signal to gpu-screen-recorder to stop and save the replay.
killall -SIGUSR1 gpu-screen-recorder

# Get the window ID of the currently focused window
focused_window=$(xdotool getactivewindow)

# Get the window name of the focused window
window_name=$(xdotool getwindowname "$focused_window" | tr -d '[:space:]')

# Truncate window name to 50 characters
window_name_truncated=$(echo "$window_name" | cut -c1-50)

# Replace slashes and backslashes with underscores in the window name
window_name_sanitized=$(echo "$window_name_truncated" | tr '/\\' '_')

# Escape special characters in the sanitized window name
window_name_escaped=$(printf '%q' "$window_name_sanitized")

# Move the latest replay file to a folder named after the focused window (created within the last 3 secs)
# TODO: Find a way to replace the -newermt, while it works it doesn't feel as reliable.
latest_replay=$(find "$HOME/Videos" -type f -name "*.mp4" -newermt '3 seconds ago' -print -quit 2>/dev/null)

# Debug
echo "Home: $HOME"
echo "Latest replay: $latest_replay"

# Check if the replay was get and move it to its own folder
if [ -n "$latest_replay" ]; then
    mkdir -p "$HOME/Videos/$window_name_escaped"
    mv "$latest_replay" "$HOME/Videos/$window_name_escaped/"
    notify-send -t 5000 -u low -- "GPU Screen Recorder" "Replay saved to $HOME/Videos/$window_name_escaped/"
else
    notify-send -t 5000 -u low -- "GPU Screen Recorder" "No replay found"
fi