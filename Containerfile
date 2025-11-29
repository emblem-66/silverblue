FROM scratch AS ctx

COPY --chmod=755 build.sh /

#FROM quay.io/fedora/fedora-bootc:latest
FROM quay.io/fedora/fedora-silverblue:latest

RUN grep '^OSTREE_VERSION=' /usr/lib/os-release

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

RUN bootc container lint
