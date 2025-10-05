#!/bin/bash
set -xeuo pipefail

### Just
#dnf install -y just
#mkdir -p /usr/share/just/
#curl -o /usr/share/just/justfile https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/just/justfile

### Tailscale
#dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
#dnf install -y tailscale
#systemctl enable tailscaled.service

### Config files
# tailscale
curl -o /etc/yum.repos.d/tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
# just
curl -o /usr/share/just/justfile https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/just/justfile
# bootc
curl -o /usr/lib/systemd/system/bootc-fetch-apply-updates.service https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/bootc/bootc-update.service
curl -o /usr/lib/systemd/system/bootc-fetch-apply-updates.timer https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/bootc/bootc-update.timer
# flatpak
curl -o /usr/lib/systemd/system/flatpak-install.service https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-install.service
curl -o /usr/lib/systemd/system/flatpak-update.service https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-update.service
curl -o /usr/lib/systemd/system/flatpak-update.timer https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-update.timer
# morewaita icons
curl -o /etc/yum.repos.d/morewaite.repo https://copr.fedorainfracloud.org/coprs/trixieua/morewaita-icon-theme/repo/fedora-rawhide/trixieua-morewaita-icon-theme-fedora-rawhide.repo

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


### AUTOMATIC UPDATES
# Automatic Updates DNF

# Automatic Updates Flatpak

### REMOTE MANAGEMENT
# SSH
# Tailscale

# Cockpit
#dnf install -y cockpit cockpit-podman
#systemctl enable cockpit.socket

# Piper
#dnf install -y piper
#systemctl enable ratbagd.service
# bootc-gtk
#dnf install -y bootc-gtk

### REMOVE UNWANTED STUFF

# Add adw-gtk3-theme & morewaita-icon-theme
#dnf copr enable -y trixieua/morewaita-icon-theme

# Failing systemd-remount-fs.service
#systemctl mask systemd-remount-fs.service
