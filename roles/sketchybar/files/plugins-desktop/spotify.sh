#!/usr/bin/env zsh

# Max number of characters so it fits nicely to the right of the notch
# MAY NOT WORK WITH NON-ENGLISH CHARACTERS

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

MAX_LENGTH=35

# Logic starts here, do not modify
HALF_LENGTH=$(((MAX_LENGTH + 1) / 2))

# Spotify JSON / $INFO comes in malformed, line below sanitizes it
SPOTIFY_JSON="$INFO"

update_track() {

    if [[ -z $SPOTIFY_JSON ]]; then

        ICON_PADDING=50
        ICON_COLOR=$BLUE
        BG_COLOR=$GREY
        LABEL_DRAWING=on

    sketchybar --set spotify.separator_left \
                     icon.color=$BG_COLOR \
               --set $NAME \
                     icon.color=$ICON_COLOR \
                     label.color=$ICON_COLOR \
                     background.color=$BG_COLOR \
                     icon.padding_right=$ICON_PADDING \
                     icon.padding_left=$ICON_PADDING \
                     label.drawing=$LABEL_DRAWING \
               --set spotify.separator_right \
                     icon.color=$BG_COLOR

        return
    fi

    PLAYER_STATE=$(echo "$SPOTIFY_JSON" | jq -r '.["Player State"]')

    if [ $PLAYER_STATE = "Playing" ]; then
        TRACK="$(echo "$SPOTIFY_JSON" | jq -r .Name)"
        ARTIST="$(echo "$SPOTIFY_JSON" | jq -r .Artist)"

        # Calculations so it fits nicely
        TRACK_LENGTH=${#TRACK}
        ARTIST_LENGTH=${#ARTIST}

        if [ $((TRACK_LENGTH + ARTIST_LENGTH)) -gt $MAX_LENGTH ]; then
            # If the total length exceeds the max
            if [ $TRACK_LENGTH -gt $HALF_LENGTH ] && [ $ARTIST_LENGTH -gt $HALF_LENGTH ]; then
                # If both the track and artist are too long, cut both at half length - 1

                # If MAX_LENGTH is odd, HALF_LENGTH is calculated with an extra space, so give it an extra char
                TRACK="${TRACK:0:$((MAX_LENGTH % 2 == 0 ? HALF_LENGTH - 2 : HALF_LENGTH - 1))}…"
                ARTIST="${ARTIST:0:$((HALF_LENGTH - 2))}…"

            elif [ $TRACK_LENGTH -gt $HALF_LENGTH ]; then
                # Else if only the track is too long, cut it by the difference of the max length and artist length
                TRACK="${TRACK:0:$((MAX_LENGTH - ARTIST_LENGTH - 1))}…"
            elif [ $ARTIST_LENGTH -gt $HALF_LENGTH ]; then
                ARTIST="${ARTIST:0:$((MAX_LENGTH - TRACK_LENGTH - 1))}…"
            fi
        fi

        ICON_PADDING=20
        ICON_COLOR=$GREY
        BG_COLOR=$BLUE
        LABEL_DRAWING=on

    sketchybar --set spotify.separator_left \
                     icon.color=$BG_COLOR \
               --set $NAME \
                     label="${TRACK}  ${ARTIST}" \
                     icon.color=$ICON_COLOR \
                     label.drawing=$LABEL_DRAWING \
                     label.color=$ICON_COLOR \
                     background.color=$BG_COLOR \
                     icon.padding_right=10 \
                     icon.padding_left=$ICON_PADDING \
                     label.padding_right=$ICON_PADDING \
               --set spotify.separator_right \
                     icon.color=$BG_COLOR

    elif [ $PLAYER_STATE = "Paused" ]; then

        ICON_PADDING=20
        ICON_COLOR=$BLUE
        BG_COLOR=$GREY
        LABEL_DRAWING=on

    sketchybar --set spotify.separator_left \
                     icon.color=$BG_COLOR \
               --set $NAME \
                     icon.color=$ICON_COLOR \
                     label.color=$ICON_COLOR \
                     background.color=$BG_COLOR \
                     icon.padding_right=$ICON_PADDING \
                     icon.padding_left=$ICON_PADDING \
                     label.drawing=$LABEL_DRAWING \
                     label.padding_right=$ICON_PADDING \
               --set spotify.separator_right \
                     icon.color=$BG_COLOR

    elif [ $PLAYER_STATE = "Stopped" ]; then

        ICON_PADDING=50
        ICON_COLOR=$BLUE
        BG_COLOR=$GREY
        LABEL_DRAWING=off

    sketchybar --set spotify.separator_left \
                     icon.color=$BG_COLOR \
               --set $NAME \
                     icon.color=$ICON_COLOR \
                     label.color=$ICON_COLOR \
                     background.color=$BG_COLOR \
                     icon.padding_right=$ICON_PADDING \
                     icon.padding_left=$ICON_PADDING \
                     label.drawing=$LABEL_DRAWING \
                     label.padding_right=$ICON_PADDING \
               --set spotify.separator_right \
                     icon.color=$BG_COLOR

    else

        ICON_PADDING=50
        ICON_COLOR=$BLUE
        BG_COLOR=$GREY
        LABEL_DRAWING=off

    sketchybar --set spotify.separator_left \
                     icon.color=$BG_COLOR \
               --set $NAME \
                     icon.color=$ICON_COLOR \
                     label.color=$ICON_COLOR \
                     background.color=$BG_COLOR \
                     icon.padding_right=$ICON_PADDING \
                     icon.padding_left=$ICON_PADDING \
                     label.drawing=$LABEL_DRAWING \
                     label.padding_right=$ICON_PADDING \
               --set spotify.separator_right \
                     icon.color=$BG_COLOR

    fi


}

case "$SENDER" in
"mouse.clicked")
    osascript -e 'tell application "Spotify" to playpause'
    ;;
*)
    update_track
    ;;
esac
