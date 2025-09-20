# Currently based on Silverblue image. In future, I am considering using fedora-bootc image.
FROM quay.io/fedora/fedora-silverblue:latest

# Automatic Updates DNF
RUN echo "" \
 && sed -i 's|ExecStart=/usr/bin/bootc upgrade --apply --quiet|ExecStart=/usr/bin/bootc upgrade --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service \
 && sed -i 's|OnBootSec=1h|OnBootSec=5m|' /usr/lib/systemd/system/bootc-fetch-apply-updates.timer \
 && sed -i 's|RandomizedDelaySec=2h|#RandomizedDelaySec=2h|' /usr/lib/systemd/system/bootc-fetch-apply-updates.timer \
 && systemctl enable bootc-fetch-apply-updates.timer \
 && echo ""

# Automatic Updates Flatpak
RUN echo "" \
 && curl -o /etc/systemd/system/flatpak-update.service https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-update.service \
 && curl -o /etc/systemd/system/flatpak-update.timer https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-update.timer \
 && systemctl enable flatpak-update.timer \
 && systemctl disable flatpak-add-fedora-repos.service \
 && systemctl disable fedora-third-party-refresh.service \
 && echo ""

### REMOTE MANAGEMENT
RUN echo "" \
# SSH
 && systemctl enable sshd.service \
# Tailscale
 && dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo \
 && dnf install -y tailscale \
 && systemctl enable tailscaled.service \
# Cockpit
 && dnf install -y \
    cockpit \
    cockpit-podman \
 && systemctl enable cockpit.socket \
# Caddy
 && dnf copr enable -y @caddy/caddy \
 && dnf install -y caddy \
# Cleanup
 && dnf autoremove -y \
 && dnf clean all \
 && rm -rf /var/* /tmp/* \
 && echo ""

# Remove Firefox
RUN echo "" \
 && dnf remove -y firefox* \
 && dnf autoremove -y \
 && dnf clean all \
 && rm -rf /var/* /tmp/* \
 && echo ""

# Remove unwanted Fedora stuff
RUN echo "" \
 && dnf remove -y \
    virtualbox-guest-additions \
    fedora-chromium-config* \
    fedora-bookmarks \
    fedora-flathub-remote \
    fedora-third-party \
 && dnf autoremove -y \
 && dnf clean all \
 && rm -rf /var/* /tmp/* \
 && echo ""

# GNOME
RUN echo "" \
 && dnf remove -y \
    gnome-shell-extension* \
    gnome-tour \
    yelp* \
    gnome-software* \
    virtualbox-guest-additions \
    malcontent-control \
 && dnf copr enable -y trixieua/morewaita-icon-theme \
 && dnf install -y adw-gtk3-theme morewaita-icon-theme \
 && dnf autoremove -y \
 && dnf clean all \
 && rm -rf /var/* /tmp/* \
 && echo ""

# COSMIC-EPOCH
#RUN echo "" \
# && dnf copr enable -y ryanabx/cosmic-epoch \
# && dnf install -y cosmic-desktop \
# && dnf autoremove -y \
# && dnf clean all \
# && rm -rf /var/* /tmp/* \
# && echo ""

# Homebrew
#RUN echo "" \
# && mkdir -p /home/linuxbrew/.linuxbrew \
# && mkdir -p /usr/share/homebrew \
# && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
# && /home/linuxbrew/.linuxbrew/bin/brew update \
# && mv /home/linuxbrew /usr/share/homebrew \
# && echo ""
#RUN echo "" \
# && mkdir -p /usr/share/homebrew \
# && NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
# && mv /home/linuxbrew /usr/share/homebrew \
# && ln -s /usr/share/homebrew/.linuxbrew/bin/brew /usr/local/bin/brew \
# && /usr/share/homebrew/.linuxbrew/bin/brew update \
# && echo ""

# Podman Quadlets
RUN echo "" \
 && curl -o /etc/systemd/system/httpd.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/httpd.container \
 && curl -o /etc/systemd/system/nginx.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/nginx.container \
 && curl -o /etc/systemd/system/caddy.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/caddy.container \
 && curl -o /etc/systemd/system/caddy1.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/caddy1.container \
 && curl -o /etc/systemd/system/jellyfin.container https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/containers/jellyfin.container \
 && echo ""

# Tweaks
RUN echo "" \
 && systemctl enable podman-auto-update.timer \
 && systemctl mask systemd-remount-fs.service \
 && systemctl mask systemd-remount-fs.service \
 && echo ""

# Finish
RUN echo "" \
 && dnf clean all \
 && rm -rf /var/* /tmp/* \
 && ostree container commit \
 && bootc container lint
