#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Wallpapers"
STATE_FILE="$HOME/.cache/current_wallpaper_index"

mkdir -p "$(dirname "$STATE_FILE")"

mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f | sort)

[ ${#WALLPAPERS[@]} -eq 0 ] && exit 1

if [ -f "$STATE_FILE" ]; then
    INDEX=$(cat "$STATE_FILE")
else
    INDEX=0
fi

case "$1" in
    next)
        INDEX=$((INDEX + 1))
        ;;
    prev)
        INDEX=$((INDEX - 1))
        ;;
    *)
        echo "Usage: $0 {next|prev}"
        exit 1
        ;;
esac

# Wrap around
INDEX=$(( (INDEX + ${#WALLPAPERS[@]}) % ${#WALLPAPERS[@]} ))

echo "$INDEX" > "$STATE_FILE"

pkill swaybg
swaybg -i "${WALLPAPERS[$INDEX]}" --mode fill &
