#!/usr/bin/env bash

# Try to detect waybar-wrapped process
if pgrep -x ".waybar-wrapped" > /dev/null; then
  pkill -x ".waybar-wrapped"
else
  # Run it in background detached
  waybar
fi
