#!/usr/bin/env bash
set -xeuo pipefail

echo "::group::90"
trap 'echo "::endgroup::"' EXIT

dnf install -y glibc-minimal-langpack
dnf remove -y glibc-all-langpacks


dnf copr enable -y che/nerd-fonts
dnf install -y nerd-fonts

dnf install -y \
    adwaita-fonts-all \
    ibm-plex-fonts-all \
    mozilla-zilla-slab-fonts \
    cascadia-fonts-all \
    rbanffy-3270-fonts \
    adobe-source-sans-pro-fonts \
    adobe-source-serif-pro-fonts \
    adobe-source-mono-pro-fonts \
    jetbrains-mono-fonts-all \
    fontawesome-fonts-all \
    
