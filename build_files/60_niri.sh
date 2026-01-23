#!/usr/bin/env bash
set -xeuo pipefail

echo "::group::50"
trap 'echo "::endgroup::"' EXIT

#dnf install -y waybar

dnf search fontawesome

#dnf install -y mangowc

### Niri
dnf copr enable -y yalter/niri
dnf install -y \
    niri \
    niri-settings \

### DMS
#curl -sS --create-dirs -o /etc/yum.repos.d/_dms.repo https://copr.fedorainfracloud.org/coprs/avengemedia/dms/repo/fedora-$(rpm -E %fedora)/avengemedia-dms-fedora-$(rpm -E %fedora).repo
dnf copr enable -y avengemedia/dms
dnf install -y dms dms-greeter 

### Sway
#dnf install -y swaybg swaylock swayidle

### Utils
#dnf install -y \
#    kitty \
#    wofi \
#    waybar \
#    waypaper \
#    pavucontrol \
#    blueman \
#    mako \
#    wlogout \
#    waybar \
#    swww \
#    grim \
