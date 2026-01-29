#!/usr/bin/env bash
set -xeuo pipefail

echo "::group::50"
trap 'echo "::endgroup::"' EXIT

### MangoWC
dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

#dnf search fontawesome

dnf install -y mangowc

### Niri
dnf copr enable -y yalter/niri
dnf install -y niri

### Utils
#dnf install -y \
#    waybar \
#    pavucontrol \
#    blueman \
#    mako \
#    wlogout \
#    grim \

### DMS
#curl -sS --create-dirs -o /etc/yum.repos.d/_dms.repo https://copr.fedorainfracloud.org/coprs/avengemedia/dms/repo/fedora-$(rpm -E %fedora)/avengemedia-dms-fedora-$(rpm -E %fedora).repo
dnf copr enable -y avengemedia/dms
dnf copr enable -y avengemedia/danklinux
dnf install -y dms dms-greeter 
dnf install -y danksearch dgop material-symbols-fonts

### Hyprland
#curl -sS --create-dirs -o /etc/yum.repos.d/_hyprland.repo https://copr.fedorainfracloud.org/coprs/sdegler/hyprland/repo/fedora-$(rpm -E %fedora)/sdegler-hyprland-fedora-$(rpm -E %fedora).repo
#dnf copr enable -y sdegler/hyprland
#dnf install -y \
#    hyprland \
#    hyprpaper \
#    hyprlock \
#    hypridle \
#    hyprlauncher \
#    hyprshot \

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
