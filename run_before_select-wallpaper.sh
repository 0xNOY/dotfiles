#!/usr/bin/env bash

set -euo pipefail

preferred="${HOME}/Pictures/wallpapers/wallpaper2_1920x1200.png"
fallback="${HOME}/.local/share/backgrounds/hyprland-theme.png"
selected="${HOME}/.local/share/backgrounds/hyprland-selected.png"

install -d -m 0700 -- "${HOME}/.local" "${HOME}/.local/share"
install -d -m 0755 -- "${selected%/*}"

if [[ -f "$preferred" ]]; then
    target="$preferred"
else
    target="$fallback"
fi

if [[ -e "$selected" && ! -L "$selected" ]]; then
    printf 'wallpaper selector: refusing to replace %s\n' "$selected" >&2
    exit 1
fi

if [[ -L "$selected" && "$(readlink -- "$selected")" == "$target" ]]; then
    exit 0
fi

ln -sfn -- "$target" "$selected"
