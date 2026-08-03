#!/usr/bin/env bash

set -euo pipefail

picom_autostart="${HOME}/.config/autostart/picom.desktop"
wheelpad_override="${HOME}/.config/systemd/user/letsnote-wheelpad.service.d/override.conf"
wheelpad_wants="${HOME}/.config/systemd/user/graphical-session.target.wants/letsnote-wheelpad.service"

rm -f -- "$picom_autostart" "$wheelpad_override" "$wheelpad_wants"
rmdir -- "${wheelpad_override%/*}" 2>/dev/null || true
