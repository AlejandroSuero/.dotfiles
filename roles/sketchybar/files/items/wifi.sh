source "$PLUGIN_SHARED_DIR/wifi.sh"

sketchybar --add item           wifi.control right                      \
                                                                        \
           --set wifi.control   icon=$WIFI_ICON                                \
                                icon.color=$BLUE \
                                label.drawing=off                       \
                                background.color=$GREY              \
                                click_script="$POPUP_CLICK_SCRIPT"      \
                                popup.background.color=$GREY       \
                                popup.blur_radius=50                    \
                                popup.background.corner_radius=5 \
                                                                                             \
           --add item           wifi.ssid popup.wifi.control            \
           --set wifi.ssid      icon=$NETWORK_ICN                                \
                                label="${SSID}" \
                                label.color=$BLUE \
                                update_freq=1 \
            --subscribe  wifi.control system_woke

sketchybar --add item wifi.separator right \
    --set wifi.separator \
    background.color=$TRANSPARENT \
    icon=$SEPARATOR_LEFT \
    icon.color=$GREY \
    icon.font="$FONT_FACE:Bold:23.0" \
    icon.padding_left=10 \
    icon.padding_right=-1 \
    icon.y_offset=1 \
    label.drawing=off

