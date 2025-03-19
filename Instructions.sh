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

# DNF Remove packages
curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/dnf-remove.list | xargs -r dnf remove -y

# DNF Install packages
curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/dnf-install.list | xargs -r dnf install -y

# S.M.A.R.T.
#dnf install -y smartmontools
#systemctl enable smartd

# Tailscale
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf install -y tailscale
systemctl enable tailscaled
# Connect your machine to your Tailscale network and authenticate in your browser:
# tailscale up
# You can find your Tailscale IPv4 address by running:
# tailscale ip -4


