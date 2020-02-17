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
  `# Undim & lock after 60 more seconds` \
  --timer 60 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1; i3lock' \
    '' \
  `# Finally, suspend 60 seconds after it locks` \
  --timer 60 \
    'systemctl suspend' \
    ''
