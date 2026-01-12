#!/usr/bin/env bash
set -xeuo pipefail

echo "::group::50"
trap 'echo "::endgroup::"' EXIT

dnf install -y waybar

### MangoWC
dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

dnf search fontawesome

dnf install -y mangowc

### Niri
dnf copr enable -y yalter/niri
dnf install -y niri

### DMS
#curl -sS --create-dirs -o /etc/yum.repos.d/_dms.repo https://copr.fedorainfracloud.org/coprs/avengemedia/dms/repo/fedora-$(rpm -E %fedora)/avengemedia-dms-fedora-$(rpm -E %fedora).repo
dnf copr enable -y avengemedia/dms
dnf install -y dms dms-greeter 

### Hyprland
#curl -sS --create-dirs -o /etc/yum.repos.d/_hyprland.repo https://copr.fedorainfracloud.org/coprs/sdegler/hyprland/repo/fedora-$(rpm -E %fedora)/sdegler-hyprland-fedora-$(rpm -E %fedora).repo
dnf copr enable -y sdegler/hyprland
dnf install -y hyprland
dnf install -y \
    hyprutils \
    hyprpaper \
    hyprlock \
    hypridle \
    hyprlauncher \
    hyprshot \
    hyprnome \
    hyprsysteminfo \
    hyprwire \
    hyprland-plugins \
    hyprshot \
    hyprland-qt-support \
    hyprcursor \
    hyprland-guiutils \
    hyprland-autoname-workspaces \
    
### Sway
dnf install -y swaybg swaylock swayidle

### Utils
dnf install -y \
    kitty \
    wofi \
    waybar \
    waypaper \
    pavucontrol \
    blueman \
    mako \
    wlogout \
    waybar \
    swww \
    grim \
