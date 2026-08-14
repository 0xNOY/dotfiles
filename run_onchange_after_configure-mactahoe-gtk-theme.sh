#!/bin/sh

set -eu

gsettings set org.gnome.desktop.interface gtk-theme \
    'MacTahoe-Dark'
gsettings set org.gnome.desktop.interface icon-theme \
    'MacTahoe-dark'
gsettings set org.gnome.desktop.interface color-scheme \
    'prefer-dark'
