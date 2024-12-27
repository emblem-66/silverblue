#!/bin/bash

set -ouex pipefail

FLATPAK_PACKAGE_LIST_URL="https://raw.githubusercontent.com/Emblem-66/Silverblue/refs/heads/main/flatpak-apps.list"

### Import the functions

source <(curl -s "https://raw.githubusercontent.com/Emblem-66/functions/refs/heads/main/fedora-ostree.sh")

### Run the functions

