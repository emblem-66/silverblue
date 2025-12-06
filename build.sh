#!/bin/bash
set -xeuo pipefail

#exec > /dev/null # 2>&1

# Non-interactive install environment
#export NONINTERACTIVE=1
#export HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
#export HOMEBREW_CACHE=/tmp/homebrew-cache
#export HOMEBREW_NO_AUTO_UPDATE=1
#export PATH="$HOMEBREW_PREFIX/bin:$PATH"

# Create necessary directories
#mkdir -p "$HOMEBREW_PREFIX"
#mkdir -p "$HOMEBREW_CACHE"

# Download and install Homebrew
#curl -sS -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

# Ensure brew is in PATH
#eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

# Test installation
#brew --version


#mkdir -p /var/home/linuxbrew


#mkdir -p /linuxbrew
#mv /linuxbrew /home/

#curl -sS -fLs https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -s

#mkdir -p /usr/share/homebrew/

#curl -sS -L https://github.com/ublue-os/packages/releases/latest/download/homebrew-x86_64.tar.zst | unzstd -c | tar -xvf - -C /usr/share/homebrew/






# check image release
#cat /etc/os-release
#source /usr/lib/os-release && echo "$OSTREE_VERSION"

### Config files
# repo - tailscale
curl -sS --create-dirs -o /etc/yum.repos.d/_tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo
# repo - morewaita icons
curl -sS --create-dirs -o /etc/yum.repos.d/_morewaita.repo https://copr.fedorainfracloud.org/coprs/trixieua/morewaita-icon-theme/repo/fedora-$(rpm -E %fedora)/trixieua-morewaita-icon-theme-fedora-$(rpm -E %fedora).repo
# repo - mergerfs
curl -sS --create-dirs -o /etc/yum.repos.d/_mergerfs.repo https://copr.fedorainfracloud.org/coprs/errornointernet/mergerfs/repo/fedora-$(rpm -E %fedora)/errornointernet-mergerfs-fedora-$(rpm -E %fedora).repo
# repo -ghostty
curl -sS --create-dirs -o /etc/yum.repos.d/_ghostyy.repo https://copr.fedorainfracloud.org/coprs/scottames/ghostty/repo/fedora-$(rpm -E %fedora)/scottames-ghostty-fedora-$(rpm -E %fedora).repo
# repo - hyprland
curl -sS --create-dirs -o /etc/yum.repos.d/_hyprland.repo https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/repo/fedora-$(rpm -E %fedora)/solopasha-hyprland-fedora-$(rpm -E %fedora).repo
# niri
curl -sS --create-dirs -o /etc/yum.repos.d/_niri.repo https://copr.fedorainfracloud.org/coprs/yalter/niri/repo/fedora-$(rpm -E %fedora)/yalter-niri-fedora-$(rpm -E %fedora).repo
curl -sS --create-dirs -o /etc/yum.repos.d/_dms.repo https://copr.fedorainfracloud.org/coprs/avengemedia/dms/repo/fedora-$(rpm -E %fedora)/avengemedia-dms-fedora-$(rpm -E %fedora).repo

# repo - docker
#curl -sS --create-dirs -o /etc/yum.repos.d/_docker.repo https://download.docker.com/linux/fedora/docker-ce.repo
# justfile
curl -sS --create-dirs -o /usr/share/just/justfile https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_share_just_justfile
# systemd - bootc
curl -sS --create-dirs -o /usr/lib/systemd/system/bootc-update.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_bootc-update.service
curl -sS --create-dirs -o /usr/lib/systemd/system/bootc-update.timer https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_bootc-update.timer
# systemd - flatpak
curl -sS --create-dirs -o /usr/lib/systemd/system/flatpak-setup.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-setup.service
curl -sS --create-dirs -o /usr/lib/systemd/system/flatpak-update.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-update.service
curl -sS --create-dirs -o /usr/lib/systemd/system/flatpak-update.timer https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-update.timer
curl -sS --create-dirs -o /usr/lib/systemd/system/flatpak-packages.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-packages.service
# systemd - brew
curl -sS --create-dirs -o /usr/lib/systemd/system/brew-setup.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_brew-setup.service
curl -sS --create-dirs -o /usr/lib/systemd/system/brew-update.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_brew-update.service
curl -sS --create-dirs -o /usr/lib/systemd/system/brew-packages.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_brew-packages.service
# containers
curl -sS --create-dirs -o /usr/share/containers/systemd/jellyfin.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/jellyfin.container
curl -sS --create-dirs -o /usr/share/containers/systemd/navidrome.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/navidrome.container
curl -sS --create-dirs -o /usr/share/containers/systemd/audiobookshelf.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/audiobookshelf.container
curl -sS --create-dirs -o /usr/share/containers/systemd/syncthing.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/syncthing.container
curl -sS --create-dirs -o /usr/share/containers/systemd/stash.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/stash.container
curl -sS --create-dirs -o /usr/share/containers/systemd/stirlingpdf.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/stirlingpdf.container
curl -sS --create-dirs -o /usr/share/containers/systemd/qbittorent.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/qbittorent.container
#pod test
#curl -sS --create-dirs -o /usr/share/containers/systemd/jellyfin.pod https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/pod/jellyfin.pod
#curl -sS --create-dirs -o /usr/share/containers/systemd/jellyfin.network https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/pod/jellyfin.network
#curl -sS --create-dirs -o /usr/share/containers/systemd/jellyfin.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/pod/jellyfin.container
#curl -sS --create-dirs -o /usr/share/containers/systemd/jellyfin-ts.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/pod/jellyfin-ts.container

# Hyprland
dnf install -y \
    hyprlock \
    hypridle \
    hyprpaper \
    hyprshot \
    hyprpicker \
    xdg-desktop-portal-hyprland \
    hyprland \
    waybar \
    hyprland \
    hyprpaper \
    hyprpicker \
    hypridle \
    hyprlock \
    hyprsunset \
    hyprpolkitagent \
    hyprpanel \

# niri
dnf install -y \
    niri \
    dms \

### Packages
# Tailscale
dnf install -y tailscale #&& rm -rf /etc/yum.repos.d/tailscale.repo
# Just
dnf install -y just
# Ghostty
dnf install -y ghostty
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
    ptyxis \

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


dnf install -y mergerfs

dnf install -y btrfs-assistant
dnf install -y btrfsd
dnf install -y btrfsmaintenance


dnf install -y nfs-utils samba # tmux


#dnf install -y adwaita-fonts-all



# docker
#dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Cosmic
#curl -sS --create-dirs -o /etc/yum.repos.d/cosmic.repo https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-$(rpm -E %fedora)/ryanabx/cosmic-epoch-fedora-$(rpm -E %fedora).repo
#dnf install -y cosmic-desktop #&& rm -rf /etc/yum.repos.d/cosmic.repo

### SystemD
# tailscale
systemctl --quiet enable tailscaled.service
systemctl --quiet enable sshd.service
# bootc
systemctl --quiet enable bootc-update.timer
# flatpak
systemctl --quiet enable flatpak-setup.service
systemctl --quiet enable flatpak-update.service
systemctl --quiet enable flatpak-update.timer
systemctl --quiet enable flatpak-packages.service
# brew
#systemctl --quiet enable brew-setup.service
systemctl --quiet enable brew-update.service
systemctl --quiet enable brew-packages.service
# mask
systemctl --quiet mask flatpak-add-fedora-repos.service
systemctl --quiet mask fedora-third-party-refresh.service
# failing systemd-remount-fs.service
systemctl --quiet mask systemd-remount-fs.service
# cockpit
systemctl --quiet enable cockpit.socket
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
rm -rf /etc/yum.repos.d/_*.repo


