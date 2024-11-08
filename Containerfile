FROM quay.io/fedora/fedora-silverblue:latest
RUN curl -s https://raw.githubusercontent.com/Emblem-66/CIBI/refs/heads/main/BuildSilverblue.sh | bash && ostree container commit
