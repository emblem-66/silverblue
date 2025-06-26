#!/bin/bash

set -ouex pipefail


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

# Config files
curl -s https://raw.githubusercontent.com/Emblem-66/Silverblue/refs/heads/main/ConfigFiles.sh | bash

# Check packages
#curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/.list | xargs -r rpm -qa | sort | grep

rpm -qa | sort | grep kernel
rpm -qa | sort | grep mesa
rpm -qa | sort | grep mutter
