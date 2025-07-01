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


cat /etc/rpm-ostreed.conf 


cat /etc/systemd/system/timers.target.wants/rpm-ostreed-automatic.timer


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
cat /usr/lib/systemd/system/bootc-fetch-apply-updates.service
cat /usr/lib/systemd/system/bootc-fetch-apply-updates.timer


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

echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/bash -c 'cat /var/home/$(whoami)/.flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive\n[Install]\nWantedBy=default.target\n" | tee /etc/systemd/system/flatpak-update.service
echo -e "[Unit]\nDescription=Update Flatpaks\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /etc/systemd/system/flatpak-update.timer

# Morewaita Icons
git clone https://github.com/somepaulo/MoreWaita.git /usr/share/icons/MoreWaita/

# Repo cleanup
rm -rf /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo
rm -rf /etc/yum.repos.d/fedora-cisco-openh264.repo
rm -rf /etc/yum.repos.d/google-chrome.repo
rm -rf /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo
rm -rf /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
