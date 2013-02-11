#!/usr/bin/env bash

hsetroot -center ~/Wallpapers/current &

# background services
xscreensaver -no-splash &
dropbox start &
wineserver &
stalonetray --geometry 100x1+0-0 --skip-taskbar --sticky --window-strut bottom --transparent --tint-color black --tint-level 180 &

# default applications
pidgin &
skype &
thunderbird &

eval "$(gnome-keyring-daemon)"
exec xmonad
