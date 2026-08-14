#!/bin/sh

set -eu

version=0.3.0-2
opt_root=$HOME/.local/opt
install_dir=$opt_root/quickshell-$version

[ -x "$install_dir/usr/bin/quickshell" ] && exit 0

mkdir -p "$opt_root"
staging=$(mktemp -d "$opt_root/.quickshell-$version.XXXXXX")
downloads=$(mktemp -d)
trap 'rm -rf -- "$staging" "$downloads"' EXIT HUP INT TERM

fetch_package() {
    url=$1
    sha256=$2
    package=$downloads/${url##*/}

    curl --fail --location --silent --show-error --output "$package" "$url"
    printf '%s  %s\n' "$sha256" "$package" | sha256sum --check --status
    bsdtar -xpf "$package" -C "$staging"
}

base=https://archive.archlinux.org/packages
fetch_package "$base/l/libdwarf/libdwarf-1:2.3.2-1-x86_64.pkg.tar.zst" \
    b7cbeccb17a3e55b8f7d00ffcbed1bfd45b5028f403aa71e7f69c84782a0f05f
fetch_package "$base/c/cpptrace/cpptrace-1.0.4-2-x86_64.pkg.tar.zst" \
    912573814ac0e332f88a9e819979383fc966426dbb9864bf1c6e6761259bbdff
fetch_package "$base/q/qt6-wayland/qt6-wayland-6.11.1-1-x86_64.pkg.tar.zst" \
    05966e0053aa5ff078c806ea6d225039ed75fbe43676cd9ff33140c52bfce281
fetch_package "$base/q/quickshell/quickshell-$version-x86_64.pkg.tar.zst" \
    06ee5eca6f079cc4abd9b5b27e342c5612d430f4ca8c95d8d90b6f0e339e6000

mv "$staging" "$install_dir"
trap - EXIT HUP INT TERM
rm -rf -- "$downloads"
