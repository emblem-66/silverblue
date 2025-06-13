#!/bin/bash

set -ouex pipefail

# Config files
curl -s https://raw.githubusercontent.com/Emblem-66/Silverblue/refs/heads/main/ConfigFiles.sh | bash

# COPR repo add
curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/dnf-repo.list | xargs -r dnf config-manager addrepo

# COPR repo add
curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/dnf-copr.list | xargs -r dnf copr enable -y

# DNF remove packages
curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/dnf-remove.list | xargs -r dnf remove -y

# DNF install packages
curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/dnf-install.list | xargs -r dnf install -y

# DNF install packages
curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/systemd.list | xargs -r systemctl enable

# COPR repo remove
curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/dnf-copr.list | xargs -r dnf copr remove -y

# Tailscale repo remove
#rm /etc/yum.repos.d/tailscale.repo

rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
d f install -y sublime-text

dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install -y brave-browser

wget -O /etc/yum.repos.d/jellyfin.repo https://repo.jellyfin.org/releases/server/fedora/jellyfin-10.repo
dnf install -y jellyfin
systemctl enable jellyfin.service

wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors.x86_64.rpm
dnf install -y ./onlyoffice-desktopeditors.x86_64.rpm

dnf install -y tigervnc-server
# https://idroot.us/install-vnc-server-fedora-42/

# Check packages
#curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/.list | xargs -r rpm -qa | sort | grep

rpm -qa | sort | grep kernel
rpm -qa | sort | grep mesa
rpm -qa | sort | grep mutter
