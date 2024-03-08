#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"

SPOTIFY_EVENT="com.spotify.client.PlaybackStateChanged"

sketchybar --add event spotify_change $SPOTIFY_EVENT \
    --add item spotify.separator_left center \
    --set spotify.separator_left \
                background.color=$TRANSPARENT \
                icon=$SEPARATOR_LEFT \
                icon.color=$GREY \
                icon.font="$FONT_FACE:Bold:23.0" \
                icon.padding_left=10 \
                icon.padding_right=-1 \
                icon.y_offset=1 \
                label.drawing=off \
    --add item spotify center \
    --set spotify \
                icon=󰓇 \
                icon.y_offset=1 \
                label.drawing=off \
                label.padding_left=5 \
                icon.color=$BLUE \
                background.padding_left=0 \
                background.padding_right=0 \
                script="$PLUGIN_DIR/spotify.sh" \
    --subscribe spotify spotify_change mouse.clicked \
    --add item spotify.separator_right center \
    --set spotify.separator_right \
                background.color=$TRANSPARENT \
                icon=$SEPARATOR_RIGHT \
                icon.color=$GREY \
                icon.font="$FONT_FACE:Bold:23.0" \
                icon.padding_left=0 \
                icon.padding_right=-1 \
                icon.y_offset=1 \
                label.drawing=off \
