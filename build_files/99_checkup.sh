#!/usr/bin/env bash
set -xeuo pipefail

echo "::group::99"
trap 'echo "::endgroup::"' EXIT

rpm -qa | sort


systemctl list-unit-files --state=enabled
