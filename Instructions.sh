#!/bin/bash

set -ouex pipefail

# Config files
curl -s https://raw.githubusercontent.com/Emblem-66/Silverblue/refs/heads/main/ConfigFiles.sh | bash



# COPR repo add
curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/dnf-repo.list | xargs -r dnf config-manager addrepo







# Tailscale repo add
#dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

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
rm /etc/yum.repos.d/tailscale.repo

