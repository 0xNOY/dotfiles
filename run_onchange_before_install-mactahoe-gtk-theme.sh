#!/bin/sh

set -eu

for dependency in sassc glib-compile-resources xmllint; do
    if ! command -v "$dependency" >/dev/null 2>&1; then
        printf 'MacTahoe GTK theme: install dependency %s first\n' \
            "$dependency" >&2
        exit 1
    fi
done

themes_dir=${XDG_DATA_HOME:-"$HOME/.local/share"}/themes
commit=26a6397583c8bc6302ac2de26cb356eb11190285
archive=$(mktemp)
source_dir=$(mktemp -d)
trap 'rm -rf -- "$archive" "$source_dir"' EXIT HUP INT TERM

curl --fail --location --silent --show-error \
    --output "$archive" \
    "https://github.com/vinceliuice/MacTahoe-gtk-theme/archive/$commit.tar.gz"
printf '%s  %s\n' \
    2729a17b0ab8cca8c7d64a4fa61fe3e589de287ae2a37b858ccfcfffed9dddb0 \
    "$archive" | sha256sum --check --status
install -d -m 0755 "$themes_dir"
bsdtar -xf "$archive" -C "$source_dir" --strip-components 1

"$source_dir/install.sh" \
    --dest "$themes_dir" \
    --color dark \
    --opacity normal \
    --theme default \
    --blur \
    --libadwaita
