#!/bin/sh
# shellcheck disable=SC2016

# Detect primary display using xrandr and set environment variable
PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"
export PRIMARY_DISPLAY

# Load user's Xresources
xrdb "${HOME}/.Xresources"

# xidlehook is a screensaver that won't lock the computer if some media are being played
killall xidlehook
xidlehook \
  --not-when-audio \
  --not-when-fullscreen \
  `# Dim the screen after 3 minutes, undim if user becomes active` \
  --timer 180 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .2' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  `# Undim & lock after 5 more minutes` \
  --timer 300 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1; blurlock' \
    '' \
    `# Finally, suspend 60 seconds after it locks (if laptop is on battery)` \
  --timer 60 \
    'grep 0 /sys/class/power_supply/AC*/online > /dev/null && systemctl suspend' \
    '' &
