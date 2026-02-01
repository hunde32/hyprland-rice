#!/bin/bash

# 1. Variables
# Change this to your actual wallpaper directory
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
# Transition config (you can change 'wave' to 'grow', 'outer', etc.)
TRANSITION="wave"

# 2. Check if swww-daemon is running, if not, start it
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi

# 3. Generate the list for Rofi
# We loop through files and format them as: "Filename\0icon\x1f/path/to/image"
# This tells Rofi to display the image itself as the icon.
list_wallpapers() {
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp,gif}; do
        if [ -f "$img" ]; then
            filename=$(basename "$img")
            echo -en "$filename\0icon\x1f$img\n"
        fi
    done
}

# 4. Show Rofi and capture selection
# -dmenu: runs rofi in dmenu mode
# -show-icons: essential for showing the preview
# -p: the prompt text
ROFI_THEME="$HOME/.config/rofi/launchers/type-3/style-6.rasi"
# Optimized command for big pictures
SELECTED=$(list_wallpapers | rofi -dmenu -i -show-icons -p "Wallpaper" \
    -theme "$ROFI_THEME" \
    -theme-str 'window { width: 80%; }' \
    -theme-str 'listview { columns: 6; lines: 3; }' \
    -theme-str 'element { orientation: vertical; padding: 10px; spacing: 5px; }' \
    -theme-str 'element-icon { size: 10em; horizontal-align: 0.5; }' \
    -theme-str 'element-text { vertical-align: 0.5; horizontal-align: 0.5; }' \
)
# 5. Apply the wallpaper
if [ -n "$SELECTED" ]; then
    # Rofi returns only the name, so we reconstruct the full path~/.config/hypr/scripts/wallpaper-selector.sh
    FULL_PATH="$WALLPAPER_DIR/$SELECTED"
    ln -sf "$FULL_PATH" "$HOME/.cache/current_wallpaper"    
    # Send notification (optional)
    notify-send "Wallpaper Changed" "$SELECTED"
    matugen image "$FULL_PATH" -t scheme-tonal-spot
    # Run swww with animations
    gsettings set org.gnome.desktop.interface gtk-theme 'HighContrast'
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
    
    # 3. Optional: Force Dark/Light preference to ensure consistency
    # (If you want it to always be dark)
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    swww img "$FULL_PATH" \
        --transition-type "$TRANSITION" \
        --transition-fps 60 \
        --transition-duration 2 \
        --transition-pos 0.5,0.5 \
        --transition-bezier 0.65,0,0.35,1
    kill -SIGUSR1 $(pgrep kitty)
    swaync-client -rs
    killall -SIGUSR1 cava
    killall waybar && waybar &
    hyprctl reload
fi
