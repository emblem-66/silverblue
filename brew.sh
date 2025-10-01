#!/bin/bash
set -xeuo pipefail


touch /.dockerenv

# Install packages
dnf install -y git xz --setopt=install_weak_deps=False
# Instal Homebrew
case "$(rpm -E %{_arch})" in
        x86_64)
                curl -fLs \
                        https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -s
                /home/linuxbrew/.linuxbrew/bin/brew update
                ;;
        *)
                mkdir /home/linuxbrew
                ;;
esac