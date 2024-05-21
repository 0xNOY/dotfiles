#!/bin/bash

INTERVAL=0.5

declare -A cache_im2display

get_current_im() {
    dbus-send --session --print-reply \
        --dest=org.fcitx.Fcitx5 \
        /controller \
        org.fcitx.Fcitx.Controller1.CurrentInputMethod \
        | grep -Po '(?<=")[^"]+'
}

_im2display() {
    im=$1
    dbus-send --session --print-reply \
        --dest=org.fcitx.Fcitx5 \
        /controller \
        org.fcitx.Fcitx.Controller1.AvailableInputMethods \
        | awk 'BEGIN{i=0}{
            if ($0 ~ /struct {/) i = 1;
            else if (i == 5) {gsub(/"/, "", $2); print $2; exit}
            else if (i > 1) i++;
            else if (i == 1 && $2 == "\"'$im'\"") i = 2;
        }'
}

im2display() {
    im=$1
    if [[ -z $im ]]; then
        return
    fi

    if [[ -z ${cache_im2display[$im]} ]]; then
        cache_im2display[$im]=$(_im2display $im)
    fi
    echo ${cache_im2display[$im]}
}

watch_im() {
    while true; do
        im=$(get_current_im)
        display=$(im2display $im)
        echo $display
        sleep $INTERVAL
    done
}

watch_im
