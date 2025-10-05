FROM scratch AS ctx
COPY --chmod=755 script.sh /

# Base Image
#FROM quay.io/fedora/fedora-bootc:latest
FROM quay.io/fedora/fedora-silverblue:latest
COPY 3rd_party.repo /etc/yum.repos.d/

### HOMEBREW
#COPY --from=builder --chown=1000:1000 /home/#linuxbrew /usr/share/homebrew

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/script.sh

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint


# Currently based on Silverblue image. In future, I am considering using fedora-bootc image.
#FROM quay.io/fedora/fedora-silverblue:latest

#COPY var-home-linuxbrew.mount /usr/lib/systemd/system/
#COPY --from=builder --chown=1000:1000 /home/linuxbrew /usr/share/homebrew

#RUN echo "" \
# Just & Justfile
# && dnf install -y just \
# && mkdir -p /usr/share/just/ \
# && curl -o /usr/share/just/justfile https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/just/justfile \
#ENV JUST_JUSTFILE=/etc/justfile
# just --justfile /etc/justfile
### AUTOMATIC UPDATES
# Automatic Updates DNF
# && sed -i 's|ExecStart=/usr/bin/bootc upgrade --apply --quiet|ExecStart=/usr/bin/bootc upgrade --quiet|' /usr/lib/systemd/system/bootc-fetch-apply-updates.service \
# && sed -i 's|OnBootSec=1h|OnBootSec=5m|' /usr/lib/systemd/system/bootc-fetch-apply-updates.timer \
# && sed -i 's|RandomizedDelaySec=2h|#RandomizedDelaySec=2h|' /usr/lib/systemd/system/bootc-fetch-apply-updates.timer \
# && systemctl enable bootc-fetch-apply-updates.timer \
# Automatic Updates Flatpak
# && curl -o /usr/lib/systemd/system/flatpak-install.service https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-install.service \
# && curl -o /usr/lib/systemd/system/flatpak-update.service https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-update.service \
# && curl -o /usr/lib/systemd/system/flatpak-update.timer https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/flatpak-update.timer \
# && systemctl enable flatpak-install.service \
# && systemctl enable flatpak-update.service \
# && systemctl enable flatpak-update.timer \
# && systemctl mask flatpak-add-fedora-repos.service \
# && systemctl mask fedora-third-party-refresh.service \
### REMOTE MANAGEMENT
# SSH
# && systemctl enable sshd.service \
# Tailscale
# && dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo \
# && dnf install -y tailscale \
# && systemctl enable tailscaled.service \
# Cockpit
# && dnf install -y \
#    cockpit \
#    cockpit-podman \
# && systemctl enable cockpit.socket \
# FTP
# && dnf install -y vsftpd \
# && sed -i 's|#write_enable=YES|write_enable=YES|' /etc/vsftpd/vsftpd.conf \
# && sed -i 's|#local_enable=YES|local_enable=YES|' /etc/vsftpd/vsftpd.conf \
# && systemctl enable systemctl enable vsftpd \
# Caddy
# Piper
# && dnf install -y piper \
# && systemctl enable ratbagd.service \
# bootc-gtk
# && dnf install -y bootc-gtk \
# && dnf copr enable -y @caddy/caddy \
# && dnf install -y caddy \
### REMOVE UNWANTED STUFF
# Remove Firefox
# && dnf remove -y firefox* \
# Remove unwanted Fedora stuff
# && dnf remove -y \
#    virtualbox-guest-additions \
#    fedora-chromium-config* \
#    fedora-bookmarks \
#    fedora-flathub-remote \
#    fedora-third-party \
# Remove GNOME stuff
# && dnf remove -y \
#    gnome-shell-extension* \
#    gnome-tour \
#    yelp* \
#    gnome-software* \
#    virtualbox-guest-additions \
#    malcontent-control \
# Remove qemu stuff
# && rpm -qa 'qemu-user-static*' | xargs dnf remove -y \
# Add adw-gtk3-theme & morewaita-icon-theme
# && dnf copr enable -y trixieua/morewaita-icon-theme \
# && dnf install -y adw-gtk3-theme morewaita-icon-theme \
# Failing systemd-remount-fs.service
# && systemctl mask systemd-remount-fs.service \
# Finish
# && dnf autoremove -y \
# && dnf clean all \
# && rm -rf /var/* /tmp/* \
# && ostree container commit \
# && bootc container lint
