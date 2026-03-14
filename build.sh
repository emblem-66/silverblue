#!/usr/bin/env bash
set -xeuo pipefail

dnf config-manager addrepo --from-repofile=https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
dnf config-manager setopt terra.enabled=0
dnf install -y -enablerepo='terra' terra-release
dnf install -y -enablerepo='terra' terra-release-extras
dnf install -y -enablerepo='terra' terra-release-mesa
dnf install -y -enablerepo='terra' terra-release-nvidia
dnf install -y -enablerepo='terra' terra-release-multimedia
#dnf swap mesa-va-drivers-freeworld mesa-va-drivers
#dnf install -y mangowm noctalia-shell

# Tailscale
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf config-manager setopt tailscale-stable.enabled=0
dnf install -y --enablerepo='tailscale-stable' tailscale
#dnf install -y --repofrompath=tailscale-stable,https://pkgs.tailscale.com/stable/fedora/tailscale.repo tailscale
#curl -fsSL --create-dirs -o /etc/yum.repos.d/tailscale.repo \
#https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/system_files/etc/yum.repos.d/tailscale.repo
#dnf install -y tailscale

# Adwaita & Morewaita
dnf copr enable -y trixieua/morewaita-icon-theme
dnf config-manager setopt copr:copr.fedorainfracloud.org:trixieua:morewaita-icon-theme.enabled=0
dnf install -y --enablerepo='copr:copr.fedorainfracloud.org:trixieua:morewaita-icon-theme' adw-gtk3-theme morewaita-icon-theme
#dnf install -y adw-gtk3-theme morewaita-icon-theme
#curl -fsSL --create-dirs -o /etc/yum.repos.d/morewaita.repo \
#https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/system_files/etc/yum.repos.d/morewaita.repo
#dnf install -y adw-gtk3-theme morewaita-icon-theme

# MergerFS
dnf copr enable -y errornointernet/mergerfs
dnf config-manager setopt copr:copr.fedorainfracloud.org:errornointernet:mergerfs.enabled=0
dnf install -y --enablerepo='copr:copr.fedorainfracloud.org:errornointernet:mergerfs' mergerfs
#dnf install -y mergerfs
#curl -fsSL --create-dirs -o /etc/yum.repos.d/mergerfs.repo \
#https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/system_files/etc/yum.repos.d/mergerfs.repo
#dnf install -y mergerfs

# File system
dnf install -y \
    smartmontools \
    btrfs-assistant \
    btrfsd \
    btrfsmaintenance \

# Screen brightness
dnf install -y ddcutil

# Cockpit
dnf install -y cockpit cockpit-podman

# Podman
dnf install -y podman podman-compose

# Remove Firefox
dnf remove -y firefox firefox-langpacks

# Toolbox Distrobox swap
dnf remove -y toolbox
dnf install -y distrobox

# Remove GNOME stuff
dnf remove -y \
    *backgrounds* \
    fedora-bookmarks \
    fedora-chromium-config* \
    fedora-flathub-remote \
    fedora-third-party \
    fedora-workstation-backgrounds \
    fedora-workstation-repositories \
    gnome-classic-session \
    gnome-shell-extension* \
    gnome-software* \
    gnome-tour \
    malcontent-control \
    qemu-user-static* \
    sssd* \
    virtualbox-guest-additions \
    yelp* \

# Update tweaks
sed -i 's|^ExecStart=.*|ExecStart=/usr/bin/bootc update --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service
sed -i 's|#AutomaticUpdatePolicy.*|AutomaticUpdatePolicy=stage|' /etc/rpm-ostreed.conf
sed -i 's|#LockLayering.*|LockLayering=true|' /etc/rpm-ostreed.conf

systemctl preset-all
systemctl --global preset-all

systemctl list-unit-files --state=enabled
