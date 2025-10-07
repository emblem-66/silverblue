#!/bin/bash
set -xeuo pipefail

### Config files
# repo - tailscale
curl --create-dirs -o /etc/yum.repos.d/tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
# repo - morewaita icons
curl --create-dirs -o /etc/yum.repos.d/morewaite.repo https://copr.fedorainfracloud.org/coprs/trixieua/morewaita-icon-theme/repo/fedora-rawhide/trixieua-morewaita-icon-theme-fedora-rawhide.repo
# justfile
curl --create-dirs -o /usr/share/just/justfile https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_share_just_justfile
# systemd - bootc
curl --create-dirs -o /usr/lib/systemd/system/bootc-update.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_bootc-update.service
curl --create-dirs -o /usr/lib/systemd/system/bootc-update.timer https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_bootc-update.timer
# systemd - flatpak
curl --create-dirs -o /usr/lib/systemd/system/flatpak-setup.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-setup.service
curl --create-dirs -o /usr/lib/systemd/system/flatpak-update.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-update.service
curl --create-dirs -o /usr/lib/systemd/system/flatpak-update.timer https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-update.timer
curl --create-dirs -o /usr/lib/systemd/system/flatpak-packages.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-packages.service
# systemd - brew
curl --create-dirs -o /usr/lib/systemd/system/brew-setup.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_brew-setup.service
curl --create-dirs -o /usr/lib/systemd/system/brew-update.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_brew-update.service
curl --create-dirs -o /usr/lib/systemd/system/brew-packages.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_brew-packages.service
# wallpaper
curl --create-dirs -o /usr/share/backgrounds/w1.jpg https://w.wallhaven.cc/full/w5/wallhaven-w5emlr.jpg
curl --create-dirs -o /usr/share/backgrounds/w2.jpg https://w.wallhaven.cc/full/3l/wallhaven-3lr2p6.jpg
curl --create-dirs -o /usr/share/backgrounds/w3.jpg https://w.wallhaven.cc/full/3k/wallhaven-3k73r6.png
curl --create-dirs -o /usr/share/backgrounds/w4.jpg https://w.wallhaven.cc/full/vm/wallhaven-vm2z55.png
curl --create-dirs -o /usr/share/backgrounds/w5.jpg https://w.wallhaven.cc/full/2k/wallhaven-2k6z39.png
curl --create-dirs -o /usr/share/backgrounds/w6.jpg https://w.wallhaven.cc/full/zx/wallhaven-zxv86v.jpg
curl --create-dirs -o /usr/share/backgrounds/w7.jpg https://w.wallhaven.cc/full/eo/wallhaven-eov7lw.jpg
curl --create-dirs -o /usr/share/backgrounds/w8.jpg https://w.wallhaven.cc/full/9d/wallhaven-9dkprw.png
curl --create-dirs -o /usr/share/backgrounds/w9.jpg https://w.wallhaven.cc/full/6d/wallhaven-6de6wl.png

### Packages
# Tailscale
dnf install -y tailscale
# Just
dnf install -y just
# theme & icons
dnf install -y adw-gtk3-theme morewaita-icon-theme
# Remove Firefox
dnf remove -y firefox*
# Remove unwanted Fedora stuff
dnf remove -y \
    virtualbox-guest-additions \
    fedora-chromium-config* \
    fedora-bookmarks \
    fedora-flathub-remote \
    fedora-third-party \
# Remove GNOME stuff
dnf remove -y \
    gnome-shell-extension* \
    gnome-tour \
    yelp* \
    gnome-software* \
    virtualbox-guest-additions \
    malcontent-control \
# bulk remove
rpm -qa 'qemu-user-static*' | xargs dnf remove -y
rpm -qa '*backgrounds*' | xargs dnf remove -y

# Cockpit
dnf install -y cockpit cockpit-podman
# piper
dnf install -y piper

### SystemD
# tailscale
systemctl enable tailscaled.service
systemctl enable sshd.service
# bootc
systemctl enable bootc-update.timer
# flatpak
systemctl enable flatpak-setup.service
systemctl enable flatpak-update.service
systemctl enable flatpak-update.timer
systemctl enable flatpak-packages.service
# brew
systemctl enable brew-setup.service
systemctl enable brew-update.service
systemctl enable brew-packages.service
# mask
systemctl mask flatpak-add-fedora-repos.service
systemctl mask fedora-third-party-refresh.service
# failing systemd-remount-fs.service
systemctl mask systemd-remount-fs.service
# cockpit
systemctl enable cockpit.socket
# piper
systemctl enable ratbagd.service
