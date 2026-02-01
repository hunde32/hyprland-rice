#!/bin/bash

# Directory where themes are stored
THEME_DIR="$HOME/.config/waybar/themes"
CONFIG_DIR="$HOME/.config/waybar"

# 1. List folders in the theme directory
# We assume every folder in ~/.config/waybar/themes/ is a valid theme
OPTIONS=$(ls -1 "$THEME_DIR")

# 2. Show Rofi Menu
SELECTED=$(echo "$OPTIONS" | rofi -dmenu -p "Select Waybar Theme" \
    -theme "$HOME/.config/rofi/launchers/type-3/style-6.rasi")

# 3. Apply the Theme
if [ -n "$SELECTED" ]; then
    # Link the selected theme's config and style to the main waybar folder
    ln -sf "$THEME_DIR/$SELECTED/config.jsonc" "$CONFIG_DIR/config.jsonc"
    ln -sf "$THEME_DIR/$SELECTED/style.css" "$CONFIG_DIR/style.css"

    # Restart Waybar
    killall waybar
    waybar &
    
    notify-send "Waybar Theme" "Switched to $SELECTED"
fi
