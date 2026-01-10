#!/usr/bin/env bash
set -xeuo pipefail

echo "::group::80"
trap 'echo "::endgroup::"' EXIT

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

dnf install -y terra-release-mesa --allowerasing

dnf install -y steam
