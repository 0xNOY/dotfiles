#!/bin/sh
# Polybar script to show OpenVPN status

if [ "$(pgrep -a openvpn$)" ]; then
    echo "VPN"
else
    echo ""
fi
