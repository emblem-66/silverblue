# Currently based on Silverblue image. In future, I am considering using fedora-bootc image.
FROM quay.io/fedora/fedora-silverblue:latest

# Automatic Updates DNF
RUN echo "starting" \
 && sed -i 's|ExecStart=/usr/bin/bootc upgrade --apply --quiet|ExecStart=/usr/bin/bootc upgrade --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service \
 && systemctl enable bootc-fetch-apply-updates.timer \
 && echo "done" 

# Automatic Updates Flatpak
RUN echo "starting" \
# && echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/packages | xargs -r flatpak install -y --noninteractive' ; /usr/bin/bash -c 'cat ~/.flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive\n[Install]\nWantedBy=default.target\n" | tee /usr/lib/systemd/system/flatpak-update.service \
# && echo -e "[Unit]\nDescription=Update Flatpaks\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /usr/lib/systemd/system/flatpak-update.timer \
# Service
 && echo "[Unit]" >> /usr/lib/systemd/system/flatpak-update.service \
 && echo "Description=Update Flatpaks" >> /usr/lib/systemd/system/flatpak-update.service \
 && echo "After=network-online.target" >> /usr/lib/systemd/system/flatpak-update.service \
 && echo "Wants=network-online.target" >> /usr/lib/systemd/system/flatpak-update.service \
 && echo "[Service]" >> /usr/lib/systemd/system/flatpak-update.service \
 && echo "Type=oneshot" >> /usr/lib/systemd/system/flatpak-update.service \
 && echo "ExecStart=/usr/bin/flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo" >> /usr/lib/systemd/system/flatpak-update.service \
# && echo "ExecStart=/usr/bin/flatpak remote-modify --disable fedora" >> /usr/lib/systemd/system/flatpak-update.service \
# && echo "ExecStart=/usr/bin/flatpak remote-modify --enable flathub" >> /usr/lib/systemd/system/flatpak-update.service \
 && echo "ExecStart=/usr/bin/flatpak uninstall --unused -y --noninteractive" >> /usr/lib/systemd/system/flatpak-update.service \
# Install list of flatpak apps from my repo
 && echo "ExecStart=/usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/packages | xargs -r flatpak install --user -y --noninteractive'" >> /usr/lib/systemd/system/flatpak-update.service \
# Install list of flatpak apps from ~/.flatpak-apps.list
 && echo "ExecStart=/usr/bin/bash -c 'cat ~/.flatpak-apps.list | xargs -r flatpak install --user -y --noninteractive'" >> /usr/lib/systemd/system/flatpak-update.service \
 && echo "ExecStart=/usr/bin/flatpak update -y --noninteractive" >> /usr/lib/systemd/system/flatpak-update.service \
 && echo "[Install]" >> /usr/lib/systemd/system/flatpak-update.service \
 && echo "WantedBy=default.target" >> /usr/lib/systemd/system/flatpak-update.service \
# Timer
 && echo "[Unit]" >> /usr/lib/systemd/system/flatpak-update.timer \
 && echo "Description=Update Flatpaks" >> /usr/lib/systemd/system/flatpak-update.timer \
 && echo "[Timer]" >> /usr/lib/systemd/system/flatpak-update.timer \
 && echo "OnCalendar=*:0/4" >> /usr/lib/systemd/system/flatpak-update.timer \
 && echo "Persistent=true" >> /usr/lib/systemd/system/flatpak-update.timer \
 && echo "[Install]" >> /usr/lib/systemd/system/flatpak-update.timer \
 && echo "WantedBy=timers.target" >> /usr/lib/systemd/system/flatpak-update.timer \
# Enable
 && systemctl enable flatpak-update.timer \
 && systemctl disable flatpak-add-fedora-repos.service \
 && systemctl disable fedora-third-party-refresh.service \
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
 && dnf install -y libratbag-ratbagd \
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
    fedora-third-party \
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
#RUN echo "starting" \
# && dnf copr enable -y ryanabx/cosmic-epoch \
# && dnf install -y cosmic-desktop \
# && dnf autoremove -y \
# && dnf clean all \
# && rm -rf /var/cache/* /var/log/* /tmp/* \
# && echo "done"

# Homebrew
#RUN echo "starting" \
# && mkdir -p /home/linuxbrew/.linuxbrew \
# && mkdir -p /usr/share/homebrew \
# && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
# && /home/linuxbrew/.linuxbrew/bin/brew update \
# && mv /home/linuxbrew /usr/share/homebrew \
# && echo "done"
#RUN echo "starting" \
# && mkdir -p /usr/share/homebrew \
# && NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
# && mv /home/linuxbrew /usr/share/homebrew \
# && ln -s /usr/share/homebrew/.linuxbrew/bin/brew /usr/local/bin/brew \
# && /usr/share/homebrew/.linuxbrew/bin/brew update \
# && echo "done"

# Quadlet test
#RUN echo "starting" \
# && echo "
#" >> /etc/containers/systemd/ngnix.container \
# && echo "done"
RUN echo "starting" \
 && echo "[Container]" >> /etc/containers/systemd/ngnix.container \
 && echo "ContainerName=nginx" >> /etc/containers/systemd/ngnix.container \
 && echo "Image=docker.io/nginxinc/nginx-unprivileged" >> /etc/containers/systemd/ngnix.container \
 && echo "AutoUpdate=registry" >> /etc/containers/systemd/ngnix.container \
 && echo "PublishPort=8080:8080" >> /etc/containers/systemd/ngnix.container \
# && systemctl enable nginx.container \
 && echo "done"

#RUN echo "starting" \
# && echo "[Unit]" > /etc/containers/systemd/nginx.container \
# && echo "Description=Unprivileged NGINX container" >> /etc/containers/systemd/nginx.container \
# && echo "" >> /etc/containers/systemd/nginx.container \
# && echo "[Container]" >> /etc/containers/systemd/nginx.container \
# && echo "ContainerName=nginx" >> /etc/containers/systemd/nginx.container \
# && echo "Image=docker.io/nginxinc/nginx-unprivileged" >> /etc/containers/systemd/nginx.container \
# && echo "AutoUpdate=registry" >> /etc/containers/systemd/nginx.container \
# && echo "PublishPort=8080:8080" >> /etc/containers/systemd/nginx.container \
# && echo "" >> /etc/containers/systemd/nginx.container \
# && echo "[Install]" >> /etc/containers/systemd/nginx.container \
# && echo "WantedBy=multi-user.target" >> /etc/containers/systemd/nginx.container \
# && systemctl enable nginx.container \
# && echo "done"

RUN echo "starting" \
 && echo "[Unit]" > /etc/containers/systemd/httpd.container \
 && echo "Description=Unprivileged HTTPD container" >> /etc/containers/systemd/httpd.container \
 && echo "" >> /etc/containers/systemd/httpd.container \
 && echo "[Container]" >> /etc/containers/systemd/httpd.container \
 && echo "ContainerName=httpd" >> /etc/containers/systemd/httpd.container \
 && echo "Image=docker.io/httpd" >> /etc/containers/systemd/httpd.container \
 && echo "AutoUpdate=registry" >> /etc/containers/systemd/httpd.container \
 && echo "PublishPort=9090:80" >> /etc/containers/systemd/httpd.container \
 && echo "" >> /etc/containers/systemd/httpd.container \
 && echo "[Install]" >> /etc/containers/systemd/httpd.container \
 && echo "WantedBy=multi-user.target" >> /etc/containers/systemd/httpd.container \
# && systemctl enable httpd.container \
 && echo "done"

# Tweaks
RUN echo "starting" \
 && echo systemd-remount-fs.service \
 && echo "done"

# Finish
RUN echo "starting" \
 && dnf clean all \
 && rm -rf /var/cache/* /var/log/* /tmp/* \
 && ostree container commit \
 && bootc container lint
