FROM quay.io/fedora/fedora:latest AS builder

WORKDIR /tmp
RUN <<-EOT sh
	set -eu

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

	# Add user for nix
	useradd nix
	mkdir -m 0755 /nix && chown nix /nix
EOT

USER nix
RUN <<-EOT sh
	set -eu

	# Install Nix
	curl -fLs https://nixos.org/nix/install | sh -s -- --no-daemon --yes
	cp -pr \
		~/.local/state/nix/profiles/profile-1-link \
		/nix/var/nix/profiles/default
EOT

FROM scratch AS ctx
COPY --chmod=755 build.sh /

#FROM quay.io/fedora/fedora-bootc:latest
FROM quay.io/fedora/fedora-silverblue:latest

COPY --from=builder --chown=1000:1000 /home/linuxbrew /usr/share/homebrew
COPY --from=builder --chown=1000:1000 /nix /usr/share/nix

RUN grep '^OSTREE_VERSION=' /usr/lib/os-release

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

RUN bootc container lint
