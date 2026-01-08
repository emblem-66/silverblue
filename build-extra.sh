#!/usr/bin/env bash
set -xeuo pipefail


dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

curl -sS --create-dirs -o /etc/yum.repos.d/_hyprland.repo https://copr.fedorainfracloud.org/coprs/sdegler/hyprland/repo/fedora-$(rpm -E %fedora)/sdegler-hyprland-fedora-$(rpm -E %fedora).repo
curl -sS --create-dirs -o /etc/yum.repos.d/_dms.repo https://copr.fedorainfracloud.org/coprs/avengemedia/dms/repo/fedora-$(rpm -E %fedora)/avengemedia-dms-fedora-$(rpm -E %fedora).repo

#dnf copr enable avengemedia/dms

dnf install -y dms


dnf install -y waybar

dnf install -y niri
dnf install -y mangowc

#dnf install -y hyprland



#dnf install -y hyprland-devel

dnf install -y \
    kitty \
    wofi \

dnf install -y steam

dnf install -y terra-release-mesa

dnf install -y helium-browser-bin 

# Hyprland

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

dnf install -y \
    waybar \
    waypaper \
    pavucontrol \
    blueman \
    mako \
    wlogout \

#dnf install -y \
#    dms \
#    dms-greeter \
#    breakpad \
#    cliphist \
#    danksearch \
#    dgop \
#    ghostty \
#    material-symbols-fonts \

#dnf install -y \
#    mpvpaper \
#    swww \
#    material-icons-fonts \
#    matugen \
#    mpvpaper \
#    pyprland \


#curl -sS --create-dirs -o /etc/yum.repos.d/_quickshell.repo https://copr.fedorainfracloud.org/coprs/errornointernet/quickshell/repo/fedora-$(rpm -E %fedora)/errornointernet-quickshell-fedora-$(rpm -E %fedora).repo

#dnf copr enable errornointernet/quickshell

#dnf install -y quickshell
# or
#sudo dnf install quickshell-git


