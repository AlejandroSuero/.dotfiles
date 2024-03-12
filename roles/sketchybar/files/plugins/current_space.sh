#!/usr/bin/env zsh

source "$HOME/.config/sketchybar/icons.sh"
FONT_FACE="JetBrainsMonoNL Nerd Font"

update_space() {
    SPACE_ID=$(echo "$INFO" | jq -r '."display-1"')

    case $SPACE_ID in
    1)
        ICON=$TERMINAL_ICON
        ICON_FONT="$FONT_FACE:Bold:20.0"
        ICON_PADDING_LEFT=10
        ICON_PADDING_RIGHT=10
        LABEL="terminal"
        LABEL_FONT="$FONT_FACE:Medium:15.0"
        ;;
    2)
        ICON=$CHROME_ICON
        ICON_FONT="$FONT_FACE:Bold:20.0"
        ICON_PADDING_LEFT=10
        ICON_PADDING_RIGHT=10
        LABEL="browser"
        LABEL_FONT="$FONT_FACE:Medium:15.0"
        ;;
    3)
        ICON=$MOBILE_ICON
        ICON_FONT="$FONT_FACE:Bold:25.0"
        ICON_PADDING_LEFT=10
        ICON_PADDING_RIGHT=10
        LABEL="simulators"
        LABEL_FONT="$FONT_FACE:Medium:15.0"
        ;;
    4)
        ICON=$KRITA_ICON
        ICON_FONT="$FONT_FACE:Bold:20.0"
        ICON_PADDING_LEFT=10
        ICON_PADDING_RIGHT=10
        LABEL="art"
        LABEL_FONT="$FONT_FACE:Medium:15.0"
        ;;
    5)
        ICON=$SPOTIFY_ICON
        ICON_FONT="$FONT_FACE:Bold:20.0"
        ICON_PADDING_LEFT=10
        ICON_PADDING_RIGHT=10
        LABEL="music"
        LABEL_FONT="$FONT_FACE:Medium:15.0"
        ;;
    6)
        ICON=$DISCORD_ICON
        ICON_FONT="$FONT_FACE:Bold:20.0"
        ICON_PADDING_LEFT=10
        ICON_PADDING_RIGHT=10
        LABEL="communication"
        LABEL_FONT="$FONT_FACE:Medium:15.0"
        ;;
    *)
        ICON=$SPACE_ID
        ICON_FONT="$FONT_FACE:Bold:20.0"
        ICON_PADDING_LEFT=10
        ICON_PADDING_RIGHT=10
        LABEL="general"
        LABEL_FONT="$FONT_FACE:Medium:15.0"
        ;;
    esac

    sketchybar --set $NAME \
        icon=$ICON \
        icon.font=$ICON_FONT \
        icon.padding_left=$ICON_PADDING_LEFT \
        icon.padding_right=$ICON_PADDING_RIGHT

    sketchybar --set $NAME \
        label.padding_left=5 \
        label.padding_right=5 \
        label=$LABEL \
        label.font=$LABEL_FONT
}

case "$SENDER" in
"mouse.clicked")
    # Reload sketchybar
    sketchybar --remove '/.*/'
    source $HOME/.config/sketchybar/sketchybarrc
    ;;
*)
    update_space
    ;;
esac
