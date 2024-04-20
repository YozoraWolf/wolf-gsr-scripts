<img src='../flags/MX.svg' width='15' height='10'> [Español](README_ES.MD) | <img src='../flags/US.svg' width='15' height='10'> [English](../README.MD) | <img src='../flags/FR.svg' width='15' height='10'> [Français](README_FR.MD) | <img src='../flags/JP.svg' width='15' height='10'> [日本語](README_JP.MD)

# Wolf's GSR Scripts

GSR ([gpu-screen-recorder](https://git.dec05eba.com/gpu-screen-recorder/about/)) est un screen recorder efficace pour Linux qui permet une fonction similaire à shadowplay sur Windows.

Je rends ce repo public afin que d'autres puissent utiliser ces scripts pour leurs configurations personnelles et suivre la manière dont je sauvegarde mes vidéos. Prenez en compte que vous devrez les éditer correctement pour les faire fonctionner de votre côté.

# Dépendances

J'ai récemment ajouté le support de `screen`, donc si vous ne l'avez pas installé, veuillez l'installer :

```
sudo apt install screen
```


# Scripts

## gsr-check-sound-change.sh

Détecte lorsque le nombre de sink a changé, tue tous les processus de gpu-screen-recorder et redémarre le screen sur lequel il s'exécute actuellement. Il dispose également d'un système de lockfile pour n'exécuter qu'une seule instance à la fois.

Ce script génère également un fichier dans le même dossier que `screen_out.txt` pour vous fournir des logs en cas de problème.

## gsr-start-replay.sh

Démarre la lecture avec un sink fourni ou une liste de sinks (séparés par `|`), sinon le sink par défaut sera utilisé.

```
./gsr-start-script nom_du_sink
```