FROM quay.io/fedora/fedora-silverblue:latest
RUN dnf group list --hidden --installed
RUN curl -s https://raw.githubusercontent.com/Emblem-66/Silverblue/refs/heads/main/Instructions.sh | bash && rm -rf /tmp/* /var/* && rpm-ostree cleanup -m && ostree container commit
RUN bootc container lint
