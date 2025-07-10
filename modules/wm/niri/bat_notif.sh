#!/bin/bash

# Automatically detect the battery directory
battery_path=$(find /sys/class/power_supply/ -maxdepth 1 -type d -name 'BAT*' | head -n 1)

# Exit if no battery is found
if [ -z "$battery_path" ]; then
  echo "No battery found."
  exit 1
fi

while true; do
  bat_lvl=$(cat "$battery_path/capacity")
  if [ "$bat_lvl" -le 15 ]; then
    notify-send --urgency=CRITICAL "Battery Low" "Level: ${bat_lvl}%"
    sleep 1200
  else
    sleep 120
  fi
done
