FROM quay.io/fedora/fedora-silverblue:latest
RUN bash <(curl -s https://raw.githubusercontent.com/Emblem-66/CIBI/refs/heads/main/BuildSilverblue.sh) && ostree container commit
