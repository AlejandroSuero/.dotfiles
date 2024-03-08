#!/usr/bin/env zsh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

source "$HOME/.config/sketchybar/colors.sh"

if [ $PERCENTAGE = "" ]; then
    exit 0
fi

case ${PERCENTAGE} in
    [8-9][0-9] | 100) # 100%-80%
        ICON=󰁹
        ICON_COLOR=$BLUE
        ;;
    [6-7][0-9]) # 70%-60%
        ICON=󰂀
        ICON_COLOR=$BLUE
        ;;
    [4-5][0-9]) # 50%-40%
        ICON=󰁾
        ICON_COLOR=$YELLOW
        ;;
    [1-3][0-9]) # 30%-10%
        ICON=󰁻
        ICON_COLOR=$PINK
        ;;
    [0-9])
        ICON=󰂃
        ICON_COLOR=$RED
        ;;
esac

if [[ $CHARGING != "" ]]; then
    ICON=󰂄
    ICON_COLOR=$BLUE
fi

sketchybar --set $NAME \
    icon=$ICON \
    icon.color=$ICON_COLOR \
    icon.padding_right=10 \
    icon.y_offset=1  \
    label="${PERCENTAGE}%" \
    label.color=$BLUE

