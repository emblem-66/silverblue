#!/usr/bin/env bash
set -xeuo pipefail

# glibc
dnf install -y glibc-minimal-langpack
dnf remove -y glibc-all-langpacks

dnf config-manager addrepo --from-repofile=https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
#dnf config-manager setopt tailscale-stable.enabled=0
#dnf install -y --enablerepo='tailscale-stable' tailscale
dnf install -y terra-release
# Tailscale
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf config-manager setopt tailscale-stable.enabled=0
dnf install -y --enablerepo='tailscale-stable' tailscale
systemctl enable tailscaled
systemctl enable sshd.service
# Just
dnf install -y just
# Adwaita & Morewaita
dnf copr enable -y trixieua/morewaita-icon-theme
#dnf config-manager setopt tailscale-stable.enabled=0
#dnf install -y --enablerepo='tailscale-stable'
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
    qemu-user-static* \
    sssd* \

# Remove GNOME stuff
dnf remove -y \
    gnome-shell-extension* \
    gnome-tour \
    yelp* \
    gnome-software* \
    virtualbox-guest-additions \
    malcontent-control \
    *backgrounds* \

dnf autoremove -y

# bulk remove
#rpm -qa 'qemu-user-static*' | xargs dnf remove -q -y
#rpm -qa '*backgrounds*' | xargs dnf remove -q -y

# Cockpit
dnf install -y cockpit cockpit-podman
# piper
#dnf install -y piper
dnf install -y podman podman-compose
systemctl enable cockpit.socket
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


### SystemD
# tailscale
#systemctl --quiet enable tailscaled.service
#systemctl --quiet enable sshd.service
# bootc
#systemctl --quiet enable bootc-update.timer
# flatpak
#systemctl --quiet enable flatpak-setup.service
#systemctl --quiet enable flatpak-update.service
#systemctl --quiet enable flatpak-update.timer
#systemctl --quiet enable flatpak-packages.service
# brew
#systemctl --quiet enable brew-setup.service
#systemctl --quiet enable brew-update.service
#systemctl --quiet enable brew-packages.service
# mask
#systemctl --quiet mask flatpak-add-fedora-repos.service
#systemctl --quiet mask fedora-third-party-refresh.service
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
systemctl --quiet enable smartd

systemctl --quiet enable btrfs-scrub.timer

#systemctl --quiet enable podman-auto-update.timer

# repo cleanup
#rm -rf /etc/yum.repos.d/_*.repo

systemctl list-unit-files --state=enabled
