#!/usr/bin/env bash
set -xeuo pipefail






#dnf -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release{,-extras,-mesa} 
#dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
#dnf -y config-manager setopt "*terra*".priority=3 #"*terra*".exclude="nerd-fonts topgrade scx-tools scx-scheds steam python3-protobuf zlib-devel"
#dnf -y config-manager setopt "terra-mesa".enabled=false
#dnf -y config-manager setopt "*rpmfusion*".priority=5 "*rpmfusion*".exclude="mesa-* steam*"
#dnf -y config-manager setopt "*fedora*".exclude="mesa-*" # kernel-core-* kernel-modules-* kernel-uki-virt-*"

# --setopt=install_weak_deps=False

#dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
#dnf config-manager setopt fedora-cisco-openh264.enabled=1

#dnf config-manager setopt fedora-cisco-openh264.enabled=0

#dnf config-manager addrepo --from-repofile=https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
#sed -i '0,/enabled=0/s/enabled=0/enabled=1/' /etc/yum.repos.d/terra-mesa.repo
#dnf config-manager setopt terra.enabled=1
#dnf install -y --enablerepo='terra' terra-release
#dnf install -y --enablerepo='terra' terra-release-extras
#dnf install -y --enablerepo='terra' terra-release-mesa
#dnf install -y --enablerepo='terra' terra-release-nvidia
#dnf install -y --enablerepo='terra' terra-release-multimedia

#dnf install -y terra-release*
#dnf install -y terra-release
#dnf install -y terra-release-extras
#dnf install -y terra-release-mesa
#dnf install -y terra-release-nvidia
#dnf install -y terra-release-multimedia

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

# Debug
dnf install -y evtest

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

dnf autoremove -y



# Update tweaks
sed -i 's|^ExecStart=.*|ExecStart=/usr/bin/bootc update --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service
sed -i 's|#AutomaticUpdatePolicy.*|AutomaticUpdatePolicy=stage|' /etc/rpm-ostreed.conf
sed -i 's|#LockLayering.*|LockLayering=true|' /etc/rpm-ostreed.conf

# Enable services
systemctl preset-all
systemctl --global preset-all













dnf install -y \
    steam \
    steam-devices \
    mesa-dri-drivers \
    mesa-vulkan-drivers \
    mesa-va-drivers \



#dnf -y --enable-repo=terra-mesa --setopt=install_weak_deps=False install \
#    steam \
#    steam-devices


dnf autoremove -y
