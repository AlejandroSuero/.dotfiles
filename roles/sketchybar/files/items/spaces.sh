source "$HOME/.config/sketchybar/colors.sh"

sketchybar --add item current_space left \
    --set current_space \
    background.color=$BLUE \
    icon.padding_left=14 \
    label.drawing=on \
    script="$PLUGIN_SHARED_DIR/current_space.sh" \
    --subscribe current_space space_change mouse.clicked

sketchybar --add item front_app.separator left \
    --set front_app.separator \
    background.color=$GREY \
    icon=$SEPARATOR_RIGHT \
    icon.color=$BLUE \
    icon.font="$FONT_FACE:Bold:23.0" \
    icon.padding_left=0 \
    icon.padding_right=0 \
    icon.y_offset=1 \
    label.drawing=on

sketchybar --add item window_title left \
           --set window_title \
                 script="$PLUGIN_SHARED_DIR/space.sh" \
                 icon.drawing=off                     \
                 label.font="$FONT_FACE:Semibold:12.0"         \
                 label.color=$BLUE \
                 label.drawing=on \
                 label.padding_right=10 \
                 background.color=$GREY \
           --subscribe window_title front_app_switched

sketchybar --add item window_title.separator left \
    --set window_title.separator \
    background.color=$TRANSPARENT \
    icon=$SEPARATOR_RIGHT  \
    icon.color=$GREY \
    icon.font="$FONT_FACE:Bold:23.0" \
    icon.padding_left=0 \
    icon.padding_right=0 \
    icon.y_offset=1 \
    label.drawing=on

