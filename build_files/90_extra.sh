#!/usr/bin/env bash
set -xeuo pipefail

echo "::group::90"
trap 'echo "::endgroup::"' EXIT

dnf install -y glibc-minimal-langpack
dnf remove -y glibc-all-langpacks
