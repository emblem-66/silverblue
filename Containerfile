# Currently based on Silverblue image. In future, I am considering using fedora-bootc image.
FROM quay.io/fedora/fedora-silverblue:latest

RUN echo "" \
# Just & Justfile
 && dnf install -y just htop btop fastfetch micro gnome-commander mc podlet \
 && mkdir -p /usr/share/just/ \
 && curl -o /usr/share/just/justfile https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/just/justfile \
#ENV JUST_JUSTFILE=/etc/justfile
# just --justfile /etc/justfile
### AUTOMATIC UPDATES
# Automatic Updates DNF
 && sed -i 's|ExecStart=/usr/bin/bootc upgrade --apply --quiet|ExecStart=/usr/bin/bootc upgrade --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service \
 && sed -i 's|OnBootSec=1h|OnBootSec=5m|' /usr/lib/systemd/system/bootc-fetch-apply-updates.timer \
 && sed -i 's|RandomizedDelaySec=2h|#RandomizedDelaySec=2h|' /usr/lib/systemd/system/bootc-fetch-apply-updates.timer \
# && systemctl enable bootc-fetch-apply-updates.timer \
# Automatic Updates Flatpak
 && curl -o /usr/lib/systemd/system/flatpak-install.service https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-install.service \
 && curl -o /usr/lib/systemd/system/flatpak-update.service https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-update.service \
 && curl -o /usr/lib/systemd/system/flatpak-update.timer https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-update.timer \
 && systemctl enable flatpak-install.service \
 && systemctl enable flatpak-update.service \
 && systemctl enable flatpak-update.timer \
 && systemctl mask flatpak-add-fedora-repos.service \
 && systemctl mask fedora-third-party-refresh.service \
### REMOTE MANAGEMENT
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
# FTP
# && dnf install -y vsftpd \
# && sed -i 's|#write_enable=YES|write_enable=YES|' /etc/vsftpd/vsftpd.conf \
# && sed -i 's|#local_enable=YES|local_enable=YES|' /etc/vsftpd/vsftpd.conf \
# && systemctl enable systemctl enable vsftpd \
# Caddy
# bootc-gtk
 && dnf install -y bootc-gtk \
# && dnf copr enable -y @caddy/caddy \
# && dnf install -y caddy \
### REMOVE UNWANTED STUFF
# Remove Firefox
 && dnf remove -y firefox* \
# Remove unwanted Fedora stuff
 && dnf remove -y \
    virtualbox-guest-additions \
    fedora-chromium-config* \
    fedora-bookmarks \
    fedora-flathub-remote \
    fedora-third-party \
# Remove GNOME stuff
 && dnf remove -y \
    gnome-shell-extension* \
    gnome-tour \
    yelp* \
    gnome-software* \
    virtualbox-guest-additions \
    malcontent-control \
# Add adw-gtk3-theme & morewaita-icon-theme
 && dnf copr enable -y trixieua/morewaita-icon-theme \
 && dnf install -y adw-gtk3-theme morewaita-icon-theme \
# Failing systemd-remount-fs.service
 && systemctl mask systemd-remount-fs.service \
# Finish
 && dnf autoremove -y \
 && dnf clean all \
 && rm -rf /var/* /tmp/* \
 && ostree container commit \
 && bootc container lint
