
#!/usr/bin/env bash

# Config
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper-selector"
SHUFFLE_ICON="$CACHE_DIR/shuffle_thumbnail.png"
THUMBNAIL_SIZE="250x141"
SHUFFLE_ASSET="$HOME/Repos/wallpaper-selector/assets/shuffle.png"
CURRENT_WALLPAPER_CACHE="$HOME/.cache/current_wallpaper"

mkdir -p "$CACHE_DIR"

# Create thumbnail
make_thumbnail() {
    magick "$1" -thumbnail "${THUMBNAIL_SIZE}^" -gravity center -extent "$THUMBNAIL_SIZE" "$2"
}

# Create shuffle icon thumbnail (once)
if [[ ! -f "$SHUFFLE_ICON" ]]; then
    magick -size "$THUMBNAIL_SIZE" xc:#1e1e2e \
        \( "$SHUFFLE_ASSET" -resize 80x80 \) \
        -gravity center -composite "$SHUFFLE_ICON"
fi

# Build wofi menu
build_menu() {
    echo -e "img:$SHUFFLE_ICON\x00info:!Random Wallpaper\x1fRANDOM"

    shopt -s nullglob
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
        base=$(basename "${img%.*}")
        thumb="$CACHE_DIR/$base.png"

        [[ ! -f "$thumb" || "$img" -nt "$thumb" ]] && make_thumbnail "$img" "$thumb"
        echo -e "img:$thumb\x00info:$base\x1f$img"
    done
    shopt -u nullglob
}

# Show menu
selected=$(build_menu | wofi --show dmenu \
    --cache-file /dev/null \
    --define "image-size=$THUMBNAIL_SIZE" \
    --columns 3 \
    --allow-images \
    --insensitive \
    --sort-order=default \
    --prompt "Select Wallpaper" \
    --conf "$HOME/.config/wofi/walpaper.conf"
)

# Exit if nothing selected
[[ -z "$selected" ]] && exit

selected_img="${selected#img:}"

# Determine wallpaper
if [[ "$selected_img" == "$SHUFFLE_ICON" ]]; then
    wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)
else
    name=$(basename "${selected_img%.*}")
    wallpaper=$(find "$WALLPAPER_DIR" -type f -iname "$name.*" | head -n 1)
fi

# Set wallpaper using swww
if [[ -n "$wallpaper" ]]; then
    swww img "$wallpaper" --transition-type grow --transition-duration 1
    echo "$wallpaper" > "$CURRENT_WALLPAPER_CACHE"
    notify-send "Wallpaper Updated" "Wallpaper set to $(basename "$wallpaper")" -i "$wallpaper"
else
    notify-send "Wallpaper Error" "Could not find the wallpaper."
fi
