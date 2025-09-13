# Currently based on Silverblue image. In future, I am considering using fedora-bootc image.
FROM quay.io/fedora/fedora-silverblue:latest

# Automatic Updates DNF
RUN echo "starting" \
# && sed -i 's|#AutomaticUpdatePolicy=none|AutomaticUpdatePolicy=stage|' /etc/rpm-ostreed.conf \
 && sed -i 's|ExecStart=/usr/bin/bootc upgrade --apply --quiet|ExecStart=/usr/bin/bootc upgrade --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service \
# && echo -e "[Unit]\nDescription=Bootc Update\nConditionPathExists=/run/ostree-booted\n[Service]\nType=oneshot\nExecStart=/usr/bin/bootc update" | tee /usr/lib/systemd/system/bootc-update.service \
# && echo -e "[Unit]\nDescription=Update Bootc\nConditionPathExists=/run/ostree-booted\nAfter=multi-user.timer\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /usr/lib/systemd/system/bootc-update.timer \
 && systemctl enable bootc-fetch-apply-updates.timer \
 && echo "done" 

# Automatic Updates Flatpak
RUN echo "starting" \
 && echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/packages | xargs -r flatpak install -y --noninteractive' ; /usr/bin/bash -c 'cat ~/.flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive\n[Install]\nWantedBy=default.target\n" | tee /usr/lib/systemd/system/flatpak-update.service \
 && echo -e "[Unit]\nDescription=Update Flatpaks\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /usr/lib/systemd/system/flatpak-update.timer \
 && systemctl enable flatpak-update.timer \
 && echo "done" 

# Tailscale
RUN echo "starting" \
 && dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo \
 && dnf install -y tailscale \
 && systemctl enable tailscaled.service sshd.service \
 && dnf autoremove -y \
 && dnf clean all \
 && rm -rf /var/cache/* /var/log/* /tmp/* \
 && echo "done" 

# Piper
RUN echo "starting" \
 && dnf install -y piper libratbag-ratbagd \
# && echo -e "# Rapture FOXTROT \nKERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", ATTRS{idVendor}=="fffe", ATTRS{idProduct}=="0072", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"" | tee /etc/udev/rules.d/99-via-usb.rules \
 && systemctl enable ratbagd.service \
 && dnf autoremove -y \
 && dnf clean all \
 && rm -rf /var/cache/* /var/log/* /tmp/* \
 && echo "done"

# Remove Firefox
RUN echo "starting" \
 && dnf remove -y firefox* \
 && dnf autoremove -y \
 && dnf clean all \
 && rm -rf /var/cache/* /var/log/* /tmp/* \
 && echo "done"

# Remove unwanted Fedora stuff
RUN echo "starting" \
 && dnf remove -y \
    virtualbox-guest-additions \
    fedora-chromium-config* \
    fedora-bookmarks \
    fedora-flathub-remote \
 && dnf autoremove -y \
 && dnf clean all \
 && rm -rf /var/cache/* /var/log/* /tmp/* \
 && echo "done"

# Remove unwanted GNOME stuff
RUN echo "starting" \
 && dnf remove -y \
    gnome-shell-extension* \
    gnome-tour \
    yelp* \
    gnome-software* \
    virtualbox-guest-additions \
    malcontent-control \
 && dnf autoremove -y \
 && dnf clean all \
 && rm -rf /var/cache/* /var/log/* /tmp/* \
 && echo "done"

# Install adw-gtk3-theme & morewaita
RUN echo "starting" \
 && dnf copr enable -y trixieua/morewaita-icon-theme \
 && dnf install -y adw-gtk3-theme morewaita-icon-theme \
 && dnf autoremove -y \
 && dnf clean all \
 && rm -rf /var/cache/* /var/log/* /tmp/* \
 && echo "done"

# COSMIC-EPOCH
RUN echo "starting" \
 && dnf copr enable -y ryanabx/cosmic-epoch \
 && dnf install -y cosmic-desktop \
 && dnf autoremove -y \
 && dnf clean all \
 && rm -rf /var/cache/* /var/log/* /tmp/* \
 && echo "done"

# Finish
RUN echo "starting" \
 && rm -rf /var/cache/* /var/log/* /tmp/* \
 && ostree container commit \
 && bootc container lint
