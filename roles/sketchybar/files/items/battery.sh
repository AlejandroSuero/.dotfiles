#!/usr/bin/env sh

sketchybar --add item battery right                      \
           --set battery script="$PLUGIN_SHARED_DIR/battery.sh" \
                         update_freq=10                  \
                         background.color=$GREY \
                         icon.y_offset=1 \
                         background.drawing=on          \
                         label.padding_right=10 \
           --subscribe battery system_woke
