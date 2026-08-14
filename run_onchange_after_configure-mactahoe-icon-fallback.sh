#!/bin/sh

set -eu

icons_dir=${XDG_DATA_HOME:-"$HOME/.local/share"}/icons

configure_fallback() {
    theme=$1
    inherits=$2
    index=$icons_dir/$theme/index.theme

    [ -f "$index" ] || return 0
    sed -i "s/^Inherits=.*/Inherits=$inherits/" "$index"
    gtk-update-icon-cache -f "$icons_dir/$theme" >/dev/null
}

configure_fallback MacTahoe-dark 'Papirus-Dark,Papirus,hicolor,breeze'
configure_fallback MacTahoe-light 'Papirus-Light,Papirus,hicolor,breeze'
configure_fallback MacTahoe 'Papirus,Papirus-Dark,hicolor,breeze'

# MacTahoe maps input-keyboard-symbolic to Command. Fcitx republishes that
# icon name whenever its input state changes, so normalize every lookup size.
theme_dir=$icons_dir/MacTahoe-dark
[ -d "$theme_dir" ] || exit 0
for target in \
    apps/22/input-keyboard-symbolic.svg \
    devices/16/input-keyboard-symbolic.svg \
    devices/22/input-keyboard-symbolic.svg \
    devices/24/input-keyboard-symbolic.svg \
    devices/symbolic/input-keyboard-symbolic.svg; do
    rm -f "$theme_dir/$target"
done
ln -s ../../status/22/keyboard-layout.svg \
    "$theme_dir/apps/22/input-keyboard-symbolic.svg"
ln -s ../../status/22/keyboard-layout.svg \
    "$theme_dir/devices/16/input-keyboard-symbolic.svg"
ln -s ../../status/22/keyboard-layout.svg \
    "$theme_dir/devices/22/input-keyboard-symbolic.svg"
ln -s ../../status/24/keyboard-layout.svg \
    "$theme_dir/devices/24/input-keyboard-symbolic.svg"
ln -s ../../status/22/keyboard-layout.svg \
    "$theme_dir/devices/symbolic/input-keyboard-symbolic.svg"
gtk-update-icon-cache -f "$theme_dir" >/dev/null
