#!/bin/sh

set -eu

icons_dir=${XDG_DATA_HOME:-"$HOME/.local/share"}/icons
[ -f "$icons_dir/MacTahoe-dark/index.theme" ] && exit 0

commit=db9a4f8b236d3c559326f041d75d5173de118c45
archive=$(mktemp)
source_dir=$(mktemp -d)
trap 'rm -rf -- "$archive" "$source_dir"' EXIT HUP INT TERM

curl --fail --location --silent --show-error \
    --output "$archive" \
    "https://github.com/vinceliuice/MacTahoe-icon-theme/archive/$commit.tar.gz"
printf '%s  %s\n' \
    6b9c6decd7f2c227fe7b562cea604231fbef80490b72a8ccc865fc4fdd8be1e4 \
    "$archive" | sha256sum --check --status
bsdtar -xf "$archive" -C "$source_dir" --strip-components 1

"$source_dir/install.sh" --dest "$icons_dir" --theme default
