#!/bin/bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

# Run xidlehook
xidlehook \
  --not-when-audio \
  --not-when-fullscreen \
  `# Dim the screen after 3 minutes, undim if user becomes active` \
  --timer 180 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .2' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  `# Undim & lock after 5 more minutes` \
  --timer 300 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1; i3exit lock' \
    '' \
    `# Finally, suspend 60 seconds after it locks (if laptop is on battery)` \
  --timer 60 \
    'grep 0 /sys/class/power_supply/AC0/online > /dev/null && systemctl suspend' \
    ''
