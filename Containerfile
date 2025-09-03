FROM quay.io/fedora/fedora-silverblue:latest
RUN echo "" \
# && sed -i 's/#AutomaticUpdatePolicy=none/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf \
 && echo -e "[Unit]\nDescription=Bootc Update\nConditionPathExists=/run/ostree-booted\n[Service]\nType=oneshot\nExecStart=/usr/bin/bootc update" | tee /usr/lib/systemd/system/bootc-update.service \
 && echo -e "[Unit]\nDescription=Update Bootc\nConditionPathExists=/run/ostree-booted\nAfter=multi-user.timer\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /usr/lib/systemd/system/bootc-update.timer \
 && echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/packages | xargs -r flatpak install -y --noninteractive' ; /usr/bin/bash -c 'cat ~/.flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive\n[Install]\nWantedBy=default.target\n" | tee /usr/lib/systemd/system/flatpak-update.service \
 && echo -e "[Unit]\nDescription=Update Flatpaks\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /usr/lib/systemd/system/flatpak-update.timer \
 && curl -o /etc/yum.repos.d/tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo \
# && dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
 && sed -i 's/enabled=1/enabled=0/' \
    /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo \
    /etc/yum.repos.d/fedora-cisco-openh264.repo \
    /etc/yum.repos.d/google-chrome.repo \
    /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo \
    /etc/yum.repos.d/rpmfusion-nonfree-steam.repo \
 && dnf upgrade -y \
 && dnf remove -y \
    firefox* \
    gnome-shell-extension* \
    gnome-tour \
    yelp* \
    gnome-software* \ #-rpm-ostree \
    virtualbox-guest-additions \
    malcontent-control \
    fedora-chromium-config* \
 && dnf install -y \
    adw-gtk3-theme \
    piper \
    libratbag-ratbagd \
    tailscale \
    unrar \
 && echo -e "# Rapture FOXTROT \nKERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", ATTRS{idVendor}=="fffe", ATTRS{idProduct}=="0072", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"" | tee /etc/udev/rules.d/99-via-usb.rules \
 && systemctl enable \
    #rpm-ostreed-automatic.timer \
    bootc-update.timer \
    flatpak-update.timer \
    sshd.service \
    tailscaled.service \
    ratbagd.service \
 && systemctl mask remount-fs.service \
 && git clone https://github.com/somepaulo/MoreWaita.git /usr/share/icons/MoreWaita/ \
# && dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo \
 && rm /etc/yum.repos.d/tailscale.repo \
# && dnf config-manager setopt tailscale.enabled=0 \
 && dnf autoremove -y \
 && dnf clean all \
 && rpm-ostree cleanup -m \
 && rm -rf /var/* /tmp/* \
 && ostree container commit \
 && bootc container lint
