#!/usr/bin/env bash

hsetroot -center ~/Wallpapers/current &

# background services
xscreensaver -no-splash &
dropbox start &
wineserver &

# default applications
pidgin &
skype &
thunderbird &

eval "$(gnome-keyring-daemon)"
exec xmonad
