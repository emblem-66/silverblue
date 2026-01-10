#!/usr/bin/env bash
set -xeuo pipefail

echo "::group::Checkup"
trap 'echo "::endgroup::"' EXIT

rpm -qa | sort


systemctl list-unit-files --state=enabled
