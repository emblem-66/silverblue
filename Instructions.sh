#!/bin/bash

set -ouex pipefail

### Fedora auto updates
sed -i 's/#AutomaticUpdatePolicy=none/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf
systemctl enable rpm-ostreed-automatic.timer

### Flatpak auto updates
#echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/flatpak update -y --noninteractive ; /usr/bin/flatpak repair\n[Install]\nWantedBy=default.target\n" | tee /etc/systemd/system/flatpak-update.service
echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive ; /usr/bin/flatpak repair\n[Install]\nWantedBy=default.target\n" | tee /etc/systemd/system/flatpak-update.service
systemctl enable flatpak-update.service
echo -e "[Unit]\nDescription=Update Flatpaks\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /etc/systemd/system/flatpak-update.timer
systemctl enable flatpak-update.timer

### Firefox
dnf remove -y firefox*

### GNOME
dnf remove -y gnome-shell-extension*
dnf remove -y gnome-tour
dnf remove -y yelp*
dnf remove -y gnome-software*
dnf remove -y virtualbox-guest-additions
dnf install -y adw-gtk3-theme ffmpegthumbnailer #gnome-shell-extension-caffeine
#git clone https://github.com/mukul29/legacy-theme-auto-switcher-gnome-extension.git /usr/share/gnome-shell/extensions/legacyschemeautoswitcher@joshimukul29.gmail.com

# S.M.A.R.T.
dnf install -y smartmontools
systemctl enable smartd
