# Nvidia GSR Bugs

I'm also making a small list of bugfixed I want to share while I was installing gpu-screen-recorder that might help some people.

You can also check the FAQ section of the [GSR official repo](https://git.dec05eba.com/gpu-screen-recorder/about) for updated and help with other bugs.

I'm using Nvidia, but feel free to add your own bugfixes if you're using an AMD card!

## Considerations
<a name="cons"></a>

- Make sure you've installed your Nvidia's drivers from [the official website](https://www.nvidia.com/en-us/drivers/) follow instructions and install the .run file, then reboot. Once done, do a quick ```inxi -G``` .and make sure that the driver you're runnning is ```driver: nvidia```.

- You're free to use the [flatpak version of GSR](https://flathub.org/apps/com.dec05eba.gpu_screen_recorder) if you run into complex issues, just make sure ffmpeg is installed from the Package Manager at least.

- If you're going to install it manually, please be sure to [build ffmpeg with NVENC support](https://docs.nvidia.com/video-technologies/video-codec-sdk/11.1/ffmpeg-with-nvidia-gpu/index.html) (I've had issues building with CUDA 12.4, so use a 11.X version instead)

- Remember that even if you install [Nvidia VA-API](https://github.com/elFarto/nvidia-vaapi-driver) it only currently supports NVDEC for now. So you **NEED** ffmpeg with NVENC to make gpu-screen-recorder work with it.

- Some websites do not re-encode videos (like Discord and Github) so any video you record should use the `h264` codec if you want to share straight away. Other than that, most websites don't recognize the `hevc` codec so you'll get no preview for them. 

- gpu-screen-recorder is still under heavy development and being bugfixed so if you find any error, please report it [here](https://github.com/dec05eba/gpu-screen-recorder-issues/issues).

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

### Warning: selected video codec *** is not supported, trying *** instead
---

Make sure your video drivers are installed and up to date (if possible). And that your card supports the codecs (most likely).

If you get this particular error:

```
Warning: selected video codec h264 is not supported, trying hevc instead
Error: your gpu does not support 'h265' video codec. If you are sure that your gpu does support 'h265' video encoding and you are using an AMD/Intel GPU,
  then make sure you have installed the GPU specific vaapi packages.
  It's also possible that your distro has disabled hardware accelerated video encoding for 'h265' video codec.
  This may be the case on corporate distros such as Manjaro, Fedora or OpenSUSE.
  You can test this by running 'vainfo | grep VAEntrypointEncSlice' to see if it matches any H264/HEVC profile.
  On such distros, you need to manually install mesa from source to enable H264/HEVC hardware acceleration, or use a more user friendly distro. Alternatively record with AV1 if supported by your GPU.
  You can alternatively use the flatpak version of GPU Screen Recorder (https://flathub.org/apps/com.dec05eba.gpu_screen_recorder) which bypasses system issues with patented H264/HEVC codecs.
  Make sure you have mesa-extra freedesktop runtime installed when using the flatpak (this should be the default), which can be installed with this command:
  flatpak install --system org.freedesktop.Platform.GL.default//23.08-extra
```

and when entering `vainfo` you get this:

```
libva info: VA-API version 1.20.0
libva error: vaGetDriverNames() failed with unknown libva error
vaInitialize failed with error code -1 (unknown libva error),exit
```

or this

```
wolf@wolf-mint:~/.gsr$ vainfo
Trying display: wayland
Trying display: drm
libva info: VA-API version 1.22.0
libva info: Trying to open /usr/local/lib/dri/nvidia_drv_video.so
libva info: Found init function __vaDriverInit_1_0
libva info: va_openDriver() returns 0
vainfo: VA-API version: 1.22 (libva 2.22.0.pre1)
vainfo: Driver version: VA-API NVDEC driver [egl backend]
vainfo: Supported profile and entrypoints
      VAProfileMPEG2Simple            :	VAEntrypointVLD
      VAProfileMPEG2Main              :	VAEntrypointVLD
      VAProfileVC1Simple              :	VAEntrypointVLD
      VAProfileVC1Main                :	VAEntrypointVLD
      VAProfileVC1Advanced            :	VAEntrypointVLD
      VAProfileH264Main               :	VAEntrypointVLD
      VAProfileH264High               :	VAEntrypointVLD
      VAProfileH264ConstrainedBaseline:	VAEntrypointVLD
      VAProfileHEVCMain               :	VAEntrypointVLD
      VAProfileVP8Version0_3          :	VAEntrypointVLD
      VAProfileAV1Profile0            :	VAEntrypointVLD
      VAProfileHEVCMain10             :	VAEntrypointVLD
      VAProfileHEVCMain12             :	VAEntrypointVLD
```

Either you didn't build ffmpeg with NVENC support correctly and/or you're using Nvidia VA-API (which only supports NVDEC as of now). Rebuild ffmpeg with NVENC support, please check [considerations](#cons).