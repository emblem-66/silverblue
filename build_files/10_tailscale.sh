#!/usr/bin/env bash
set -xeuo pipefail

echo "::group::Tailscale"
trap 'echo "::endgroup::"' EXIT

curl -sS --create-dirs -o /etc/yum.repos.d/_tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo

dnf install -y tailscale

systemctl enable tailscaled.service

systemctl enable sshd.service

