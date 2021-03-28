#!/usr/bin/env bash

hsetroot

# background services
if which xscreensaver > /dev/null; then
  xscreensaver -no-splash &
fi

if which dropbox > /dev/null; then
  dropbox start &
fi

if which wineserver > /dev/null; then
  wineserver &
fi

if which stalonetray > /dev/null; then
  stalonetray --geometry 100x1+0-0 --icon-size=16 --kludges=force_icons_size --skip-taskbar --sticky --window-strut bottom --transparent --tint-color black --tint-level 180 &
fi

if type xmonad; then
  exec ssh-agent xmonad
else
  exec mate-session
fi
