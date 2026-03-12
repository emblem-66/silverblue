#!/usr/bin/env bash
set -xeuo pipefail

#dnf config-manager addrepo --from-repofile=https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
#dnf config-manager setopt terra.enabled=1
#dnf install -y terra-release
#dnf install -y mangowm noctalia-shell

# Tailscale
#dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
#dnf config-manager setopt tailscale-stable.enabled=0
#dnf install -y --enablerepo='tailscale-stable' tailscale
#dnf install -y --repofrompath=tailscale-stable,https://pkgs.tailscale.com/stable/fedora/tailscale.repo tailscale
rpm-ostree install -y tailscale

# Adwaita & Morewaita
#dnf copr enable -y trixieua/morewaita-icon-theme
#dnf config-manager setopt copr:copr.fedorainfracloud.org:trixieua:morewaita-icon-theme.enabled=0
#dnf install -y --enablerepo='copr:copr.fedorainfracloud.org:trixieua:morewaita-icon-theme' adw-gtk3-theme morewaita-icon-theme
#dnf install -y adw-gtk3-theme morewaita-icon-theme
rpm-ostree install -y adw-gtk3-theme morewaita-icon-theme

# MergerFS
#dnf copr enable -y errornointernet/mergerfs
#dnf config-manager setopt copr:copr.fedorainfracloud.org:errornointernet:mergerfs.enabled=0
#dnf install -y --enablerepo='copr:copr.fedorainfracloud.org:errornointernet:mergerfs' mergerfs
#dnf install -y mergerfs
rpm-ostree install -y mergerfs

# File system
rpm-ostree install -y \
    smartmontools \
    btrfs-assistant \
    btrfsd \
    btrfsmaintenance \

# Screen brightness
rpm-ostree install -y ddcutil

# Cockpit
rpm-ostree install -y cockpit cockpit-podman

# Podman
rpm-ostree install -y podman podman-compose

# Remove Firefox
rpm-ostree uninstall -y firefox

# Remove unwanted Fedora stuff
#rpm-ostree uninstall -y \
#    virtualbox-guest-additions \
#    fedora-chromium-config* \
#    fedora-bookmarks \
#    fedora-flathub-remote \
#    fedora-third-party \
#    qemu-user-static* \
#    sssd* \

# Remove GNOME stuff
#rpm-ostree uninstall -y \
#    gnome-shell-extension* \
#    gnome-tour \
#    yelp* \
#    gnome-software* \
#    virtualbox-guest-additions \
#    malcontent-control \
#    *backgrounds* \

# Update tweaks
sed -i 's|^ExecStart=.*|ExecStart=/usr/bin/bootc update --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service
sed -i 's|#AutomaticUpdatePolicy.*|AutomaticUpdatePolicy=stage|' /etc/rpm-ostreed.conf
sed -i 's|#LockLayering.*|LockLayering=true|' /etc/rpm-ostreed.conf

systemctl preset-all
systemctl --global preset-all

systemctl list-unit-files --state=enabled
