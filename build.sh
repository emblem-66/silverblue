#!/bin/bash
set -xeuo pipefail

exec > /dev/null 2>&1


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
#curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

# Ensure brew is in PATH
#eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

# Test installation
#brew --version


#mkdir -p /var/home/linuxbrew


#mkdir -p /linuxbrew
#mv /linuxbrew /home/

#curl -fLs https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -s

#mkdir -p /usr/share/homebrew/

#curl -L https://github.com/ublue-os/packages/releases/latest/download/homebrew-x86_64.tar.zst | unzstd -c | tar -xvf - -C /usr/share/homebrew/



# check image release
#cat /etc/os-release
#source /usr/lib/os-release && echo "$OSTREE_VERSION"

### Config files
# repo - tailscale
curl --create-dirs -o /etc/yum.repos.d/_tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo > /dev/null 2>&1
# repo - morewaita icons
curl --create-dirs -o /etc/yum.repos.d/_morewaita.repo https://copr.fedorainfracloud.org/coprs/trixieua/morewaita-icon-theme/repo/fedora-$(rpm -E %fedora)/trixieua-morewaita-icon-theme-fedora-$(rpm -E %fedora).repo > /dev/null 2>&1
# repo - mergerfs
curl --create-dirs -o /etc/yum.repos.d/_mergerfs.repo https://copr.fedorainfracloud.org/coprs/errornointernet/mergerfs/repo/fedora-$(rpm -E %fedora)/errornointernet-mergerfs-fedora-$(rpm -E %fedora).repo > /dev/null 2>&1
# repo - docker
curl --create-dirs -o /etc/yum.repos.d/_docker.repo https://download.docker.com/linux/fedora/docker-ce.repo > /dev/null 2>&1
# justfile
curl --create-dirs -o /usr/share/just/justfile https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_share_just_justfile > /dev/null 2>&1
# systemd - bootc
curl --create-dirs -o /usr/lib/systemd/system/bootc-update.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_bootc-update.service > /dev/null 2>&1
curl --create-dirs -o /usr/lib/systemd/system/bootc-update.timer https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_bootc-update.timer > /dev/null 2>&1
# systemd - flatpak
curl --create-dirs -o /usr/lib/systemd/system/flatpak-setup.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-setup.service > /dev/null 2>&1
curl --create-dirs -o /usr/lib/systemd/system/flatpak-update.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-update.service > /dev/null 2>&1
curl --create-dirs -o /usr/lib/systemd/system/flatpak-update.timer https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-update.timer > /dev/null 2>&1
curl --create-dirs -o /usr/lib/systemd/system/flatpak-packages.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_flatpak-packages.service > /dev/null 2>&1
# systemd - brew
curl --create-dirs -o /usr/lib/systemd/system/brew-setup.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_brew-setup.service > /dev/null 2>&1
curl --create-dirs -o /usr/lib/systemd/system/brew-update.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_brew-update.service > /dev/null 2>&1
curl --create-dirs -o /usr/lib/systemd/system/brew-packages.service https://raw.githubusercontent.com/emblem-66/bootc-config/refs/heads/main/_usr_lib_systemd_system_brew-packages.service > /dev/null 2>&1
# containers
curl --create-dirs -o /usr/share/containers/systemd/jellyfin.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/jellyfin.container > /dev/null 2>&1
curl --create-dirs -o /usr/share/containers/systemd/navidrome.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/navidrome.container > /dev/null 2>&1
curl --create-dirs -o /usr/share/containers/systemd/audiobookshelf.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/audiobookshelf.container > /dev/null 2>&1
curl --create-dirs -o /usr/share/containers/systemd/syncthing.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/syncthing.container > /dev/null 2>&1
curl --create-dirs -o /usr/share/containers/systemd/stash.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/stash.container > /dev/null 2>&1
curl --create-dirs -o /usr/share/containers/systemd/stirlingpdf.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/stirlingpdf.container > /dev/null 2>&1
curl --create-dirs -o /usr/share/containers/systemd/qbittorent.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/qbittorent.container > /dev/null 2>&1

### Packages
# Tailscale
dnf install -y tailscale > /dev/null 2>&1 #&& rm -rf /etc/yum.repos.d/tailscale.repo
# Just
dnf install -y just steam > /dev/null 2>&1
# morewaita icons
dnf install -y morewaita-icon-theme > /dev/null 2>&1 #&& rm -rf /etc/yum.repos.d/morewaite.repo
# adwaita theme
dnf install -y adw-gtk3-theme > /dev/null 2>&1
# Remove Firefox
dnf remove -y firefox* > /dev/null 2>&1
# Remove unwanted Fedora stuff
dnf remove -y \
    virtualbox-guest-additions \
    fedora-chromium-config* \
    fedora-bookmarks \
    fedora-flathub-remote \
    fedora-third-party \
    > /dev/null 2>&1
# Remove GNOME stuff
dnf remove -y \
    gnome-shell-extension* \
    gnome-tour \
    yelp* \
    gnome-software* \
    virtualbox-guest-additions \
    malcontent-control \
    > /dev/null 2>&1
# bulk remove
rpm -qa 'qemu-user-static*' | xargs dnf remove -y > /dev/null 2>&1
rpm -qa '*backgrounds*' | xargs dnf remove -y > /dev/null 2>&1

# Cockpit
dnf install -y cockpit cockpit-podman > /dev/null 2>&1
# piper
#dnf install -y piper
dnf install -y podman podman-compose > /dev/null 2>&1
#dnf install -y input-remapper
# FTP
#dnf install -y vsftpd
#systemctl enable vsftpd
#chown 0777 /etc/vsftpd/vsftpd.conf

# podlet
#dnf install -y podlet

dnf install -y smartmontools > /dev/null 2>&1

dnf install -y unison unison-gtk > /dev/null 2>&1

dnf install -y duperemove > /dev/null 2>&1

dnf install -y fd-find > /dev/null 2>&1

dnf install -y fzf > /dev/null 2>&1

# docker
#dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Cosmic
#curl --create-dirs -o /etc/yum.repos.d/cosmic.repo https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-$(rpm -E %fedora)/ryanabx/cosmic-epoch-fedora-$(rpm -E %fedora).repo
#dnf install -y cosmic-desktop #&& rm -rf /etc/yum.repos.d/cosmic.repo

### SystemD
# tailscale
systemctl enable tailscaled.service > /dev/null 2>&1
systemctl enable sshd.service > /dev/null 2>&1
# bootc
systemctl enable bootc-update.timer > /dev/null 2>&1
# flatpak
systemctl enable flatpak-setup.service > /dev/null 2>&1
systemctl enable flatpak-update.service > /dev/null 2>&1
systemctl enable flatpak-update.timer > /dev/null 2>&1
systemctl enable flatpak-packages.service > /dev/null 2>&1
# brew
#systemctl enable brew-setup.service
#systemctl enable brew-update.service
#systemctl enable brew-packages.service
# mask
systemctl mask flatpak-add-fedora-repos.service > /dev/null 2>&1
systemctl mask fedora-third-party-refresh.service > /dev/null 2>&1
# failing systemd-remount-fs.service
systemctl mask systemd-remount-fs.service > /dev/null 2>&1
# cockpit
systemctl enable cockpit.socket > /dev/null 2>&1
# piper
#systemctl enable ratbagd.service
# input remmaper
#systemctl enable input-remapper
# docker
#systemctl enable docker
systemctl enable smartd > /dev/null 2>&1
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

dnf install -y mergerfs > /dev/null 2>&1

dnf install -y btrfs-assistant > /dev/null 2>&1
dnf install -y btrfsd > /dev/null 2>&1
dnf install -y btrfsmaintenance > /dev/null 2>&1

systemctl enable btrfs-scrub.timer > /dev/null 2>&1

# repo cleanup
rm -rf /etc/yum.repos.d/_*.repo > /dev/null 2>&1
#rm -rf /etc/yum.repos.d/rpmfusion*.repo

# tuned profiles
# https://www.redhat.com/en/blog/linux-tuned-tuning-profiles

#dnf install -y nfs-utils samba tmux


systemctl enable podman-auto-update.timer > /dev/null 2>&1
#dnf install -y adwaita-fonts-all




