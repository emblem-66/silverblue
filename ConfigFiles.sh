#!/bin/bash

set -ouex pipefail

# DNF auto updates
sed -i 's/#AutomaticUpdatePolicy=none/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf
sed -i 's/enabled=1/enabled=0/' \
/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo \
/etc/yum.repos.d/fedora-cisco-openh264.repo \
/etc/yum.repos.d/google-chrome.repo \
/etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo \
/etc/yum.repos.d/rpmfusion-nonfree-steam.repo


#cat /etc/rpm-ostreed.conf 


#cat /usr/lib/systemd/system/rpm-ostreed-automatic.timer

# cat /usr/lib/systemd/system/bootc-fetch-apply-updates.service
#[Unit]
#Description=Apply bootc updates
#Documentation=man:bootc(8)
#ConditionPathExists=/run/ostree-booted
#[Service]
#Type=oneshot
#ExecStart=/usr/bin/bootc update --apply --quiet

# cat /usr/lib/systemd/system/bootc-fetch-apply-updates.timer
#[Unit]
#Description=Apply bootc updates
#Documentation=man:bootc(8)
#ConditionPathExists=/run/ostree-booted

#[Timer]
# Disable the automatic reboot on the update service for bootc
#OnBootSec=1h
# This time is relatively arbitrary and obviously expected to be overridden/changed
#OnUnitInactiveSec=8h
# When deploying a large number of systems, it may be beneficial to increase this value to help with load on the registry.
#RandomizedDelaySec=2h
#[Install]
#WantedBy=timers.target

# /*
# Configure Updates
# */
#sed -i 's|^ExecStart=.*|ExecStart=/usr/bin/bootc update --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service
#sed -i 's|^OnUnitInactiveSec=.*|OnUnitInactiveSec=7d\nPersistent=true|' /usr/lib/systemd/system/bootc-fetch-apply-updates.timer
#sed -i 's|#AutomaticUpdatePolicy.*|AutomaticUpdatePolicy=stage|' /etc/rpm-ostreed.conf
#sed -i 's|#LockLayering.*|LockLayering=true|' /etc/rpm-ostreed.conf
#cat /usr/lib/systemd/system/bootc-fetch-apply-updates.service

#cat /usr/lib/systemd/system/bootc-fetch-apply-updates.timer


# Disable the automatic reboot on the update service for bootc
#mkdir -p /etc/systemd/system/bootc-fetch-apply-updates.service.d
#cat << EOF > /etc/systemd/system/bootc-fetch-apply-updates.service.d/10-no-apply.conf
#[Service]
#ExecStart=
#ExecStart=/usr/bin/bootc update --quiet
#EOF



# Flatpak setup
#echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive\n[Install]\nWantedBy=default.target\n" | tee /etc/systemd/system/flatpak-update.service
#echo -e "[Unit]\nDescription=Update Flatpaks\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /etc/systemd/system/flatpak-update.timer

#echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/bash -c 'cat /var/home/pc/.flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive\n[Install]\nWantedBy=default.target\n" | tee /etc/systemd/system/flatpak-update.service
#echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/bash -c 'cat /var/home/$(whoami)/.flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive\n[Install]\nWantedBy=default.target\n" | tee /etc/systemd/system/flatpak-update.service
#echo -e "[Unit]\nDescription=Update Flatpaks\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /etc/systemd/system/flatpak-update.timer

echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/packages | xargs -r flatpak install -y --noninteractive' ; /usr/bin/bash -c 'cat ~/.flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive\n[Install]\nWantedBy=default.target\n" | tee /etc/systemd/system/flatpak-update.service
echo -e "[Unit]\nDescription=Update Flatpaks\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /etc/systemd/system/flatpak-update.timer

# Morewaita Icons
git clone https://github.com/somepaulo/MoreWaita.git /usr/share/icons/MoreWaita/



#dnf install -y podman podman-compose

#dnf install -y --setopt=install_weak_deps=False --nogpgcheck --skip-unavailable NetworkManager
#dnf install --setopt=install_weak_deps=False --nogpgcheck --skip-unavailable -y cockpit* #* #cockpit-machines cockpit-podman cockpit-files cockpit-navigator cockpit-selinux
#systemctl enable cockpit.socket || true

#dnf install -y --setopt=install_weak_deps=False --nogpgcheck --skip-unavailable podman podman-compose

#systemctl enable libvirtd || true
#systemctl enable httpd.service || true

# rpm-fusion
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#dnf install -y --allowerasing libavcodec-freeworld mesa*freeworld ffmpeg gstreamer*

#dnf --setopt=install_weak_deps=False --nogpgcheck --skip-unavailable -y jellyfin*
#systemctl enable jellyfin

curl -fsSL https://pkgs.netbird.io/install.sh | sh



#transmission

#https://linuxcapable.com/how-to-install-transmission-on-fedora-linux/


# -------------------------------- #

# https://idroot.us/install-ftp-server-fedora-42/



# DELUGE https://idroot.us/install-deluge-fedora-42/
#dnf install --setopt=install_weak_deps=False --nogpgcheck --skip-unavailable -y deluge
#systemctl enable deluge

#dnf install --setopt=install_weak_deps=False --nogpgcheck --skip-unavailable -y transmission
#systemctl enable transmission



# Jellyfin https://idroot.us/install-jellyfin-fedora-42/
#dnf remove -y ffmpeg-free
#dnf install --setopt=install_weak_deps=False --nogpgcheck --skip-unavailable --allowerasing -y jellyfin
#systemctl enable jellyfin
#firewall-cmd --permanent --add-service=jellyfin
#firewall-cmd --permanent --add-port=8096/tcp
#firewall-cmd --permanent --add-port=8920/tcp
#firewall-cmd --permanent --add-port=1900/udp
#dnf --setopt=install_weak_deps=False --nogpgcheck --skip-unavailable -y libva libva-intel-driver
#dnf --setopt=install_weak_deps=False --nogpgcheck --skip-unavailable -y zram-generator
#systemctl enable systemd-zram-setup@zram0.service

# NEXTCLOUD https://idroot.us/install-nextcloud-fedora-42/
# NEXTCLOUD https://fedoraproject.org/wiki/Nextcloud

# SAMBA https://idroot.us/install-samba-fedora-42/
#dnf install --setopt=install_weak_deps=False --nogpgcheck --skip-unavailable -y samba samba-common samba-client
#systemctl enable smb nmb

# immich
#dnf copr enable -y mbooth/immich 
#dnf install --setopt=install_weak_deps=False --nogpgcheck --skip-unavailable -y immich

# Caddy https://idroot.us/install-caddy-fedora-42/
# Nginx https://idroot.us/install-nginx-fedora-42/







#---------------------

# podman containers

#/etc/containers/
#├── podman-compose.yml
#/etc/systemd/system/
#├── podman-compose.service
#├── podman-compose.timer


#

#[Unit]
#Description=Jellyfin via Podman Compose
#Requires=network-online.target
#After=network-online.target

#[Service]
#Type=oneshot
#RemainAfterExit=true
#WorkingDirectory=/etc/containers/jellyfin-compose
#ExecStartPre=/usr/bin/podman-compose pull
#ExecStart=/usr/bin/podman-compose up -d
#ExecStop=/usr/bin/podman-compose down
#TimeoutStartSec=300
#TimeoutStopSec=60

#[Install]
#WantedBy=multi-user.target

#

#[Unit]
#Description=Weekly update for Jellyfin Podman Compose stack

#[Timer]
#OnCalendar=weekly
#Persistent=true
#Unit=jellyfin-compose.service

#[Install]
#WantedBy=timers.target

#

# Enable the compose stack on boot
#systemctl enable podman-compose.service

# Enable the weekly update timer
#systemctl enable podman-compose.timer

# Start immediately (optional)
#systemctl start podman-compose.service
#systemctl start podman-compose.timer
#
#systemctl list-timers podman-compose.timer
#systemctl start podman-compose.timer
#
#systemctl restart podman-compose.service
#journalctl -u podman-compose.service


