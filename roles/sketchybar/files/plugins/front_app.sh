#!/usr/bin/env zsh

ICON_PADDING_RIGHT=5

case $INFO in
"Arc")
    ICON_PADDING_RIGHT=5
    ICON=󰞍
    ;;
"Code")
    ICON_PADDING_RIGHT=4
    ICON="vscode"
    ;;
"Calendar")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Discord")
    ICON="discord"
    ;;
"FaceTime")
    ICON_PADDING_RIGHT=5
    ICON="facetime"
    ;;
"Finder")
    ICON="finder"
    ;;
"Google Chrome")
    ICON_PADDING_RIGHT=7
    ICON="chrome"
    ;;
"IINA")
    ICON_PADDING_RIGHT=4
    ICON="vlc"
    ;;
"kitty")
    ICON="kitty"
    ;;
"Messages")
    ICON="msg"
    ;;
"Notion")
    ICON_PADDING_RIGHT=6
    ICON="notion"
    ;;
"Preview")
    ICON_PADDING_RIGHT=3
    ICON="preview"
    ;;
"PS Remote Play")
    ICON_PADDING_RIGHT=3
    ICON="ps-remote"
    ;;
"Spotify")
    ICON="spotify"
    ;;
"TextEdit")
    ICON_PADDING_RIGHT=4
    ICON="text"
    ;;
"Transmission")
    ICON_PADDING_RIGHT=3
    ICON="transmission"
    ;;
*)
    ICON=﯂
    ;;
esac

sketchybar --set $NAME icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT
sketchybar --set $NAME.name label="$INFO"
