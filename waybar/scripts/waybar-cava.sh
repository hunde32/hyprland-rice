#!/bin/bash

# Define the bar characters
bar="▂▃▄▅▆▇█"
dict=(" " "▂" "▃" "▄" "▅" "▆" "▇" "█")

# Run cava and read its output line by line
cava -p ~/.config/cava/config_waybar | while read -r line; do
    # Split the line into an array of values
    IFS=';' read -ra val <<< "$line"
    display=""
    for i in "${val[@]}"; do
        # Use the value as an index for the dict array
        display+="${dict[$i]}"
    done
    echo '{"text": "'"$display"'", "class": "custom-cava"}'
done
