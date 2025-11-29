FROM scratch AS ctx

COPY --chmod=755 build.sh /

#FROM quay.io/fedora/fedora-bootc:latest
FROM quay.io/fedora/fedora-silverblue:latest

ENV HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
ENV HOMEBREW_CACHE=/tmp/homebrew-cache
ENV HOMEBREW_NO_AUTO_UPDATE=1
ENV NONINTERACTIVE=1

RUN mkdir -p $HOMEBREW_PREFIX && curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

RUN grep '^OSTREE_VERSION=' /usr/lib/os-release

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

RUN bootc container lint
