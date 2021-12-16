#!/bin/bash
set -x

#
# NOTE : to run this script automatically when a HDMI device is plugged in, add the
#        following line to /lib/udev/rules.d/99-hdmi_sound.rules
#
#        ACTION=="change", SUBSYSTEM=="drm", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/USERNAME/.Xauthority", RUN+="/path/to/hdmi_auto_switch.sh"
#

export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/$(id -u "$USER")

PRIMARY_DISPLAY="$(xrandr | grep primary | awk '{print $1}')"
SECONDARY_DISPLAY="$(xrandr | grep HDMI | grep -v disconnected | awk '{print $1}')"
ALSA_DEVICE="$(pactl list cards | grep Name | head -1 | cut -d. -f2,3)"

if [ -n "$SECONDARY_DISPLAY" ]; then
    PROFILE="hdmi-stereo-extra1"
    xrandr --output "$SECONDARY_DISPLAY" --auto --scale-from 1920x1080 --output "$PRIMARY_DISPLAY"
else
    PROFILE="analog-stereo"
fi

pactl set-card-profile alsa_card.$ALSA_DEVICE output:$PROFILE
pactl set-default-sink alsa_output.$ALSA_DEVICE.$PROFILE

SINK_INPUTS=($(pactl list sink-inputs | grep "^Sink Input #"|cut -d'#' -f2))
for i in ${SINK_INTPUTS[*]}; do
    pactl move-sink-input $i alsa_output.$ALSA_DEVICE.$PROFILE
done

