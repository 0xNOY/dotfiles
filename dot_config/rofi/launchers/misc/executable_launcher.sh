#!/usr/bin/env bash

set -euo pipefail

theme_dir="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/misc"
exec rofi \
    -no-lazy-grab \
    -show drun \
    -modi drun \
    -theme "$theme_dir/launchpad.rasi" \
    "$@"
