#!/bin/bash

# 1. Force everything behind 'zenity' to dim
hyprctl keyword windowrule "dim_around true, match:class ^(zenity)$"
hyprctl keyword windowrule "stay_focused true, match:class ^(zenity)$"

# 2. Launch Zenity (it will now be bright, while the background is dark)
zenity --warning --text="Battery below 15%!" --width=300

# 3. Clean up the rule after closing so other zenity windows don't dim the screen later
hyprctl keyword windowrule "unset, match:class (zenity)"
