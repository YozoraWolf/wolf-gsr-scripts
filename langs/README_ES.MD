<img src='../flags/MX.svg' width='15' height='10'> [Español](README_ES.MD) | <img src='../flags/US.svg' width='15' height='10'> [English](../README.MD) | <img src='../flags/FR.svg' width='15' height='10'> [Français](README_FR.MD) | <img src='../flags/JP.svg' width='15' height='10'> [日本語](README_JP.MD)


# Wolf's GSR Scripts

GSR ([gpu-screen-recorder](https://git.dec05eba.com/gpu-screen-recorder/about/)) es un grabador de pantalla eficaz para Linux que permite una función similar a shadowplay en Windows.

Estoy haciendo este repositorio público para que otros puedan tomar estos scripts y usarlos para sus configuraciones personales, siguiendo la forma en que guardo mis videos. Ten en cuenta que tendrás que editarlos tu mismo para que funcionen en tu entorno.

# Dependencias

Recientemente he añadido soporte para `screen`, así que si no lo tienes instalado, por favor, instálalo:

```
sudo apt install screen
```

# Scripts

## gsr-check-sound-change.sh

Detecta cuando el número de sinks ha cambiado, mata todos los procesos de gpu-screen-recorder y reinicia el screen en la que se está ejecutando actualmente. También cuenta con un sistema de lockfile para que solo se ejecute una instancia a la vez.

Este script también genera un archivo en la misma carpeta que `screen_out.txt` para proporcionar algunos logs en caso de que algo salga mal.

## gsr-start-replay.sh

Inicia la reproducción con un sink proporcionado o una lista de sinks (separados por `|`), si no se proporciona, se utilizará el sink predeterminado.

```
./gsr-start-script nombre_del_sink
```