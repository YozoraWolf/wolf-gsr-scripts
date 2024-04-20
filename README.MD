<img src='flags/MX.svg' width='15' height='10'> [Español](langs/README_ES.MD) | <img src='flags/US.svg' width='15' height='10'> [English](README.MD) | <img src='flags/FR.svg' width='15' height='10'> [Français](langs/README_FR.MD) | <img src='flags/JP.svg' width='15' height='10'> [日本語](langs/README_JP.MD)

# Wolf's GSR Scripts

GSR ([gpu-screen-recorder](https://git.dec05eba.com/gpu-screen-recorder/about/)) is an effective screen recorder for Linux that allows a similar function to shadowplay on windows.

I'm making this repo public so that others could take these scripts to use for their personal setups and follow the way I save my videos. Do take in account that you'll have to edit them properly to make them work on your end.

# Dependencies

I've recently added support for `screen` so if you don't have it installed, please, install it:

```
sudo apt install screen
```

# Scripts

## gsr-check-sound-change.sh

Detects whenever the sink number has changed, kills all gpu-screen-recorder processes and restarts the screen its currently running on. It also has a lockfile system so you will be running only one instance at a time.

This script also outputs a file to the same folder as `screen_out.txt` to give you some logs in case something goes wrong.

## gsr-start-replay.sh

Starts replay with a provided sink or list of sinks (separated by `|`), if not it will use the default sink.

```
./gsr-start-script sink_name
```