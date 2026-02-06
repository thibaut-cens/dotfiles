#!/bin/bash

# Configuration
CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)
FLAG_FILE="/tmp/battery_warned"
PERCENTAGE=15

# 1. RESET LOGIC: If plugged in, remove the flag so it can fire again later
if [ "$STATUS" = "Charging" ] && [ "$CAPACITY" -gt "$PERCENTAGE" ]; then
  if [ -f "$FLAG_FILE" ]; then
    rm "$FLAG_FILE"
    echo "Removed flag file: $FLAG_FILE"
  fi
fi

# 2. TRIGGER LOGIC: If low, discharging, and NOT yet warned
if [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -le "$PERCENTAGE" ]; then
  if [ ! -f "$FLAG_FILE" ]; then
    echo "Execute battery warning scripts."
    # Run your warning script
    bash "$(dirname "$0")/battery_warn.sh"
    # Create the flag so this block doesn't run again
    touch "$FLAG_FILE"
    echo "Created flag file: $FLAG_FILE"
  else
    echo "Flag file $FLAG_FILE found, do nothing."
  fi
fi
