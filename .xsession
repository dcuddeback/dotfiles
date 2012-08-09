#!/usr/bin/env bash

hsetroot -center ~/Wallpapers/1920x1200/02266_itswood_1920x1200.jpg &

# background services
xscreensaver -no-splash &
dropbox start &

# default applications
pidgin &
skype &
thunderbird &

eval "$(gnome-keyring-daemon)"
exec xmonad
