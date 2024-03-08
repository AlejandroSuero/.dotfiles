#!/usr/bin/env sh

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
STATE="$(echo "$CURRENT_WIFI" | grep -o "state: .*" | sed 's/^state: //')"
CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

case "$STATE" in
    "init") echo "running but not connected"
    ;;
    "running") echo "running and connected"
    ;;
    *) echo "not running"
    ;;
esac

POPUP_OFF="sketchybar --set wifi.control popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"
