#!/bin/bash
set -xeuo pipefail

# check image release
#cat /etc/os-release
#source /usr/lib/os-release && echo "$OSTREE_VERSION"

### Config files
# repo - tailscale
curl --create-dirs -o /etc/yum.repos.d/_tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
# repo - morewaita icons
curl --create-dirs -o /etc/yum.repos.d/_morewaita.repo https://copr.fedorainfracloud.org/coprs/trixieua/morewaita-icon-theme/repo/fedora-$(rpm -E %fedora)/trixieua-morewaita-icon-theme-fedora-$(rpm -E %fedora).repo
# repo - mergerfs
curl --create-dirs -o /etc/yum.repos.d/_mergerfs.repo https://copr.fedorainfracloud.org/coprs/errornointernet/mergerfs/repo/fedora-$(rpm -E %fedora)/errornointernet-mergerfs-fedora-$(rpm -E %fedora).repo
# repo - docker
curl --create-dirs -o /etc/yum.repos.d/_docker.repo https://download.docker.com/linux/fedora/docker-ce.repo
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
# containers
curl --create-dirs -o /usr/share/containers/systemd/jellyfin.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/jellyfin.container
curl --create-dirs -o /usr/share/containers/systemd/navidrome.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/navidrome.container
curl --create-dirs -o /usr/share/containers/systemd/audiobookshelf.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/audiobookshelf.container
#curl --create-dirs -o /usr/share/containers/systemd/syncthing.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/syncthing.container
curl --create-dirs -o /usr/share/containers/systemd/stash.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/stash.container
curl --create-dirs -o /usr/share/containers/systemd/stirlingpdf.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/stirlingpdf.container
curl --create-dirs -o /usr/share/containers/systemd/qbittorent.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/qbittorent.container

### Packages
# Tailscale
dnf install -y tailscale #&& rm -rf /etc/yum.repos.d/tailscale.repo
# Just
dnf install -y just
# morewaita icons
dnf install -y morewaita-icon-theme #&& rm -rf /etc/yum.repos.d/morewaite.repo
# adwaita theme
dnf install -y adw-gtk3-theme 
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
#dnf install -y piper

#dnf install -y input-remapper
# FTP
#dnf install -y vsftpd
#systemctl enable vsftpd
#chown 0777 /etc/vsftpd/vsftpd.conf

# podlet
#dnf install -y podlet

dnf install -y smartmontools

dnf install -y unison

dnf install -y duperemove

# docker
#dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Cosmic
#curl --create-dirs -o /etc/yum.repos.d/cosmic.repo https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-$(rpm -E %fedora)/ryanabx/cosmic-epoch-fedora-$(rpm -E %fedora).repo
#dnf install -y cosmic-desktop #&& rm -rf /etc/yum.repos.d/cosmic.repo

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
#systemctl enable brew-setup.service
#systemctl enable brew-update.service
#systemctl enable brew-packages.service
# mask
systemctl mask flatpak-add-fedora-repos.service
systemctl mask fedora-third-party-refresh.service
# failing systemd-remount-fs.service
systemctl mask systemd-remount-fs.service
# cockpit
systemctl enable cockpit.socket
# piper
#systemctl enable ratbagd.service
# input remmaper
#systemctl enable input-remapper
# docker
#systemctl enable docker
systemctl enable smartd
# rpm fusion
#dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
#dnf install -y rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted

# all codecs
#dnf install -y libavcodec-freeworld 
#dnf install -y --allowerasing ffmpeg

# jellyfin/kodi
#dnf install -y jellyfin

#echo "enable audiobookshelf.service" >> /usr/lib/systemd/system-preset/100-containers.preset
#echo "enable jellyfin.service" >> /usr/lib/systemd/system-preset/100-containers.preset
#echo "enable stash.service" >> /usr/lib/systemd/system-preset/100-containers.preset
#echo "enable syncthing.service" >> /usr/lib/systemd/system-preset/100-containers.preset
#echo "enable stirlingpdf.service" >> /usr/lib/systemd/system-preset/100-containers.preset

#curl --create-dirs -o /etc/yum.repos.d/_caddy.repo https://copr.fedorainfracloud.org/coprs/g/caddy/caddy/repo/fedora-$(rpm -E %fedora)/group_caddy-caddy-fedora-$(rpm -E %fedora).repo
#dnf install -y caddy

dnf install -y mergerfs

dnf install -y btrfs-assistant
dnf install -y btrfsd
dnf install -y btrfsmaintenance

# repo cleanup
rm -rf /etc/yum.repos.d/_*.repo
#rm -rf /etc/yum.repos.d/rpmfusion*.repo

# tuned profiles
# https://www.redhat.com/en/blog/linux-tuned-tuning-profiles

#dnf install -y nfs-utils samba tmux
