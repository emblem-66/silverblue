#!/usr/bin/env bash
set -xeuo pipefail

echo "::group::00"
trap 'echo "::endgroup::"' EXIT

### Config files
# Terra
#curl -sS --create-dirs -o /etc/yum.repos.d/terra.repo https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
# repo - tailscale
#curl -sS --create-dirs -o /etc/yum.repos.d/_tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
# repo - morewaita icons
#curl -sS --create-dirs -o /etc/yum.repos.d/_morewaita.repo https://copr.fedorainfracloud.org/coprs/trixieua/morewaita-icon-theme/repo/fedora-$(rpm -E %fedora)/trixieua-morewaita-icon-theme-fedora-$(rpm -E %fedora).repo

#dnf install -y \
#    ibm-plex* \
#    adwaita*fonts \
#    redhat*fonts \

#curl -sS --create-dirs -o /etc/yum.repos.d/_quickshell.repo https://copr.fedorainfracloud.org/coprs/errornointernet/quickshell/repo/fedora-$(rpm -E %fedora)/errornointernet-quickshell-fedora-$(rpm -E %fedora).repo

#dnf copr enable errornointernet/quickshell

#dnf install -y quickshell
# or
#sudo dnf install quickshell-git

### Packages
# Tailscale
#dnf install -y tailscale #&& rm -rf /etc/yum.repos.d/tailscale.repo
# Just
dnf install -y just
# Ghostty
#dnf install -y ghostty
# morewaita icons
dnf copr enable -y trixieua/morewaita-icon-theme
dnf install -y morewaita-icon-theme #&& rm -rf /etc/yum.repos.d/morewaite.repo
# adwaita theme
dnf install -y adw-gtk3-theme
# Remove Firefox
dnf remove -y firefox*
# Utils
#dnf install -y \
#    bat \

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
rpm -qa 'qemu-user-static*' | xargs dnf remove -q -y
rpm -qa '*backgrounds*' | xargs dnf remove -q -y

# Cockpit
dnf install -y cockpit cockpit-podman
# piper
#dnf install -y piper
dnf install -y podman podman-compose
#dnf install -y input-remapper
# FTP
#dnf install -y vsftpd
#systemctl --quiet enable vsftpd
#chown 0777 /etc/vsftpd/vsftpd.conf

# podlet
#dnf install -y podlet

#dnf install -y fzf

dnf install -y smartmontools

dnf install -y unison unison-gtk

#dnf install -y duperemove

#dnf install -y fd-find


#dnf install -y mergerfs

dnf install -y btrfs-assistant
dnf install -y btrfsd
dnf install -y btrfsmaintenance


dnf install -y nfs-utils samba # tmux


#dnf install -y adwaita-fonts-all



# docker
#dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Cosmic
# Official
#dnf install -y @cosmic-desktop-environment
# COPR
#curl -sS --create-dirs -o /etc/yum.repos.d/cosmic.repo https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-$(rpm -E %fedora)/ryanabx/cosmic-epoch-fedora-$(rpm -E %fedora).repo
#dnf install -y cosmic-desktop #&& rm -rf /etc/yum.repos.d/cosmic.repo


# mask
systemctl mask flatpak-add-fedora-repos.service
systemctl mask fedora-third-party-refresh.service
# failing systemd-remount-fs.service
#systemctl --quiet mask systemd-remount-fs.service
# cockpit
#systemctl --quiet enable cockpit.socket
# piper
#systemctl --quiet enable ratbagd.service
# input remmaper
#systemctl --quiet enable input-remapper
# docker
#systemctl --quiet enable docker
systemctl enable smartd

systemctl enable btrfs-scrub.timer

#systemctl --quiet enable podman-auto-update.timer

# repo cleanup
#rm -rf /etc/yum.repos.d/_*.repo
