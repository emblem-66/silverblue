#!/bin/bash
set -xeuo pipefail

### Config files
# tailscale
curl --create-dirs -o /etc/yum.repos.d/tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
# just
curl --create-dirs -o /usr/share/just/justfile https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/just/justfile
# bootc
curl --create-dirs -o /usr/lib/systemd/system/bootc-fetch-apply-updates.service https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/bootc/bootc-update.service
curl --create-dirs -o /usr/lib/systemd/system/bootc-fetch-apply-updates.timer https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/bootc/bootc-update.timer
# flatpak
curl --create-dirs -o /usr/lib/systemd/system/flatpak-install.service https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-install.service
curl --create-dirs -o /usr/lib/systemd/system/flatpak-update.service https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-update.service
curl --create-dirs -o /usr/lib/systemd/system/flatpak-update.timer https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-update.timer
# morewaita icons
curl --create-dirs -o /etc/yum.repos.d/morewaite.repo https://copr.fedorainfracloud.org/coprs/trixieua/morewaita-icon-theme/repo/fedora-rawhide/trixieua-morewaita-icon-theme-fedora-rawhide.repo

### Packages
# Tailscale
dnf install -y tailscale
# Just
dnf install -y just

dnf install -y adw-gtk3-theme morewaita-icon-theme

# Remove Firefox
dnf remove -y firefox*

# Remove unwanted Fedora stuff
dnf remove -y \
    virtualbox-guest-additions \
    fedora-chromium-config* \
    fedora-bookmarks \
    fedora-flathub-remote \
    fedora-third-party

# Remove GNOME stuff
dnf remove -y \
    gnome-shell-extension* \
    gnome-tour \
    yelp* \
    gnome-software* \
    virtualbox-guest-additions \
    malcontent-control \

# Remove qemu stuff
rpm -qa 'qemu-user-static*' | xargs dnf remove -y

# Cockpit
dnf install -y cockpit cockpit-podman
# piper
dnf install -y piper

### SystemD
# tailscale
systemctl enable tailscaled.service
systemctl enable sshd.service
# bootc
systemctl enable bootc-fetch-apply-updates.timer
# flatpak
systemctl enable flatpak-install.service
systemctl enable flatpak-update.service
systemctl enable flatpak-update.timer
# mask
systemctl mask flatpak-add-fedora-repos.service
systemctl mask fedora-third-party-refresh.service
# failing systemd-remount-fs.service
systemctl mask systemd-remount-fs.service
# cockpit
systemctl enable cockpit.socket
# piper
systemctl enable ratbagd.service
