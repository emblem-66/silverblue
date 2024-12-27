#!/bin/bash

set -ouex pipefail

FLATPAK_PACKAGE_LIST_URL="https://raw.githubusercontent.com/Emblem-66/Silverblue/refs/heads/main/flatpak-apps.list"

### Import the functions

source <(curl -s "https://raw.githubusercontent.com/Emblem-66/functions/refs/heads/main/fedora-ostree.sh")

### Run the functions

### Terra repos
f_terra
### RPM-fusion
f_rpmfusion
### Fedora auto updates
f_updates
### Flatpak auto updates
f_flatpak
### First boot setup
f_firstboot
### Multimedia
f_multimedia
### Firefox
f_firefox
### Fonts
f_fonts
### CachyOS Kernel
f_cachy
### Mesa-git Mesa Freeworld
#f_mesa-freeworld
### Mesa-git Mesa Freeworld
f_mesa-git
### Gaming
f_gaming
### Utils
f_utils
### GNOME
f_gnome
### Tailscale
f_tailscale
### Distrobox
#f_distrobox
### Sublime Text
#f_sublime
