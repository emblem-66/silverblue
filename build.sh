#!/usr/bin/env bash
set -xeuo pipefail

#dnf config-manager addrepo --from-repofile=https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
#dnf install -y terra-release

# Tailscale
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf config-manager setopt tailscale-stable.enabled=0
dnf install -y --enablerepo='tailscale-stable' tailscale
#systemctl enable tailscaled
#systemctl enable sshd.service

# Just
#dnf install -y just

# Adwaita & Morewaita
dnf copr enable -y trixieua/morewaita-icon-theme
dnf install -y adw-gtk3-theme morewaita-icon-theme

# Remove Firefox
dnf remove -y firefox*

# File system
dnf install -y \
    smartmontools \
    btrfs-assistant \
    btrfsd \
    btrfsmaintenance \

# MergerFS
dnf copr enable -y errornointernet/mergerfs
dnf install -y mergerfs

# Screen brightness
dnf install -y ddcutil

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

# Cockpit
dnf install -y cockpit cockpit-podman
dnf install -y podman podman-compose

# Autoremove
dnf autoremove -y

#system_services=(
#  bootc-fetch-apply-updates.service
#  tailscaled.service
#  cockpit.socket
#  btrfs-scrub.timer
#  podman-auto-update.timer
#  smartd
#  btrfs-scrub.timer
#)

#user_services=(
#  podman.socket
#  flathub-update.timer
#)

#mask_services=(
#  systemd-remount-fs.service
#  flatpak-add-fedora-repos.service
#)

#systemctl enable "${system_services[@]}"
#systemctl mask "${mask_services[@]}"
#systemctl --global enable "${user_services[@]}"

#for service in "${system_services[@]}"; do
#    echo "enable $service" >> "$preset_file"
#done

#mkdir -p "/etc/systemd/user-preset/"
#preset_file="/etc/systemd/user-preset/01-user.preset"
#touch "$preset_file"

#install -Dm 644 /dev/null /etc/systemd/user-preset/01-user.preset

#for service in "${user_services[@]}"; do
#    echo "enable $service" >> "$preset_file"
#done

# Passwordless sudo
#install -Dm440 /dev/stdin /etc/sudoers.d/99-wheel-nopasswd <<< '%wheel ALL=(ALL) NOPASSWD:ALL'

#system_services=(
#    bootc-fetch-apply-updates.service
#    tailscaled.service
#    cockpit.socket
#    btrfs-scrub.timer
#    podman-auto-update.timer
#    smartd.service
#)

mask_services=(
    systemd-remount-fs.service
    flatpak-add-fedora-repos.service
)
# Add masked services
for m in "${mask_services[@]}"; do
    systemctl mask "$m"
done

#systemctl mask systemd-remount-fs.service
#systemctl mask flatpak-add-fedora-repos.service

#user_services=(
#    podman.socket
#    flathub-update.timer
#)

# Create preset files
#system_preset_file="/etc/systemd/system-preset/01-system.preset"
#user_preset_file="/etc/systemd/user-preset/01-user.preset"

#install -Dm 644 /dev/null "$system_preset_file"
#install -Dm 644 /dev/null "$user_preset_file"

# Add system services
#for s in "${system_services[@]}"; do
#    echo "enable $s" >> "$system_preset_file"
#done



# Add user services
#for u in "${user_services[@]}"; do
#    echo "enable $u" >> "$user_preset_file"
#done

# Update tweaks
sed -i 's|^ExecStart=.*|ExecStart=/usr/bin/bootc update --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service
sed -i 's|#AutomaticUpdatePolicy.*|AutomaticUpdatePolicy=stage|' /etc/rpm-ostreed.conf
sed -i 's|#LockLayering.*|LockLayering=true|' /etc/rpm-ostreed.conf

# Flathub setup
#curl -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo
#echo "Default=true" | tee -a /etc/flatpak/remotes.d/flathub.flatpakrepo > /dev/null
#flatpak remote-add --if-not-exists --system flathub /etc/flatpak/remotes.d/flathub.flatpakrepo
#flatpak remote-modify --system --enable flathub || true
#flatpak remote-modify --system --disable fedora || true
