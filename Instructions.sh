#!/bin/bash

set -ouex pipefail

# DNF auto updates
sed -i 's/#AutomaticUpdatePolicy=none/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf
systemctl enable rpm-ostreed-automatic.timer

# Flatpak setup
echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive\n[Install]\nWantedBy=default.target\n" | tee /etc/systemd/system/flatpak-update.service
systemctl enable flatpak-update.service
echo -e "[Unit]\nDescription=Update Flatpaks\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /etc/systemd/system/flatpak-update.timer
systemctl enable flatpak-update.timer

# DNF remove packages
curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/dnf-remove.list | xargs -r dnf remove -y

# COPR repo install
curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/dnf-copr.list | xargs -r dnf copr enable -y

# DNF install packages
curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/dnf-install.list | xargs -r dnf install -y

# S.M.A.R.T.
dnf install -y smartmontools
systemctl enable smartd

# Tailscale
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf install -y tailscale
systemctl enable tailscaled
# Connect your machine to your Tailscale network and authenticate in your browser:
# tailscale up
# You can find your Tailscale IPv4 address by running:
# tailscale ip -4

# PLEX media server

#sudo tee /etc/yum.repos.d/plex.repo<<EOF
#[Plexrepo]
#name=plexrepo
#baseurl=https://downloads.plex.tv/repo/rpm/\$basearch/
#enabled=1
#gpgkey=https://downloads.plex.tv/plex-keys/PlexSign.key
#gpgcheck=1
#EOF


# Local RPM - Heroic
wget -O heroic-latest.rpm $(curl -s https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest | jq -r '.assets[] | select(.name | contains ("rpm")) | .browser_download_url')
#curl -L -o /tmp/heroic-latest.rpm $(curl -s https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest | jq -r '.assets[] | select(.name | contains ("rpm")) | .browser_download_url')
#dnf install -y /tmp/heroic-latest.rpm
#rpm-ostree install heroic-latest.rpm

# Emby server
wget -O emby-server.rpm $(curl -s https://api.github.com/repos/MediaBrowser/Emby.Releases/releases/latest | jq -r '.assets[] | select(.name | test("emby-server-rpm.*\\x86_64.rpm")) | .browser_download_url')
dnf install -y emby-server.rpm

# GitHub repository URL (Emby Releases in this case)
#REPO_URL="https://api.github.com/repos/MediaBrowser/Emby.Releases/releases/latest"

# Get the latest release URL using GitHub API and jq
#LATEST_RPM_URL=$(curl -s $REPO_URL | jq -r '.assets[] | select(.name | test("emby-server-rpm.*\\.rpm")) | .browser_download_url')

# Download the latest RPM package
#if [ -n "$LATEST_RPM_URL" ]; then
#    echo "Downloading $LATEST_RPM_URL..."
#    wget -q --show-progress "$LATEST_RPM_URL"
#else
#    echo "No RPM file found."
#fi

