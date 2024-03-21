# Nvidia GSR Bugs

I'm also making a small list of bugfixed I want to share while I was installing gpu-screen-recorder that might help some people.

You can also check the FAQ section of the [GSR official repo](https://git.dec05eba.com/gpu-screen-recorder/about) for updated and help with other bugs.

I'm using Nvidia, but feel free to add your own bugfixes if you're using an AMD card!

## Considerations

- Make sure you've installed your Nvidia's drivers from [the official website](https://www.nvidia.com/en-us/drivers/) follow instructions and install the .run file, then reboot. Once done, do a quick ```inxi -G``` .and make sure that the driver you're runnning is ```driver: nvidia```.

- Although you're free to use the [flatpak version of GSR](https://flathub.org/apps/com.dec05eba.gpu_screen_recorder), I highly recommend to install it manually to avoid the usual issues with flatpaks access and running long commands. 

## 🪲 Bugs

### gsr error: your opengl environment is not properly setup. It's using llvmpipe (software rendering) for opengl instead of your graphics card. Please make sure your graphics driver is properly installed
---

Make sure you've properly installed your graphic drivers. Either you installed them incorrectly, or they are not compatible with your card. Make sure OpenGL is usable.

### _gsr error: gsr_capture_nvfbc_start failed: This hardware does not support NvFBC_
---
It seems that NvFBC comes disabled by default, so I found a repo that helped solve this issue ([nvidia-patch](https://github.com/keylase/nvidia-patch)). 

Just make sure you check if your card is compatible (if you're on new hardware you're usually ok to go.)

Go to the repo, follow instructions, the most important part is to run:

```bash
bash ./patch-fbc.sh
```
It will allow you to use NvFBC on your consumer device.