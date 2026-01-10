#!/usr/bin/env bash
set -xeuo pipefail

echo "::group::50"
trap 'echo "::endgroup::"' EXIT

### MangoWC
dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf install -y \
    mangowc \

### Hyprland
#curl -sS --create-dirs -o /etc/yum.repos.d/_hyprland.repo https://copr.fedorainfracloud.org/coprs/sdegler/hyprland/repo/fedora-$(rpm -E %fedora)/sdegler-hyprland-fedora-$(rpm -E %fedora).repo
dnf copr enable -y sdegler/hyprland
dnf install -y \
    hyprutils \
    hyprland-guiutils \
    hyprland-autoname-workspaces \
    hyprpaper \
    hyprlock \
    hypridle \
    hyprlauncher \
    hyprnome \
    hyprshot \
    hyprsysteminfo \
    hyprwire \
    hyprland-plugins \
    hyprshot \
    hyprland-qt-support \
    hyprcursor \

### Sway
dnf install -y \
    swaybg \
    swaylock \
    swayidle \

### Niri
dnf copr enable -y avengemedia/dms
dnf install -y \
    niri \

### DMS
#curl -sS --create-dirs -o /etc/yum.repos.d/_dms.repo https://copr.fedorainfracloud.org/coprs/avengemedia/dms/repo/fedora-$(rpm -E %fedora)/avengemedia-dms-fedora-$(rpm -E %fedora).repo
dnf copr enable -y avengemedia/dms
dnf install -y \
    dms \
    dms-greeter \

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
