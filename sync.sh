#!/usr/bin/env bash
# Pull the latest configs from the system into this repo, then commit.
set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for name in hypr waybar rofi dunst alacritty cava nvim mpv htop xsettingsd fish; do
    if [[ -d "$HOME/.config/$name" ]]; then
        if [[ "$name" == "hypr" && -f "$HOME/.config/hypr/hyprland.lua" ]]; then
            hyprland --verify-config -c "$HOME/.config/hypr/hyprland.lua" >/dev/null 2>&1 || { echo "hyprland.lua invalid, aborting sync"; exit 1; }
        fi
        rm -rf "$DOTDIR/config/$name"
        cp -r "$HOME/.config/$name" "$DOTDIR/config/"
        find "$DOTDIR/config/$name" -name '*.bak' -delete 2>/dev/null || true
        rm -f "$DOTDIR/config/$name/hyprland.conf" "$DOTDIR/config/$name/hyprland-gui.conf" "$DOTDIR/config/$name/hyprland.conf.bak" "$DOTDIR/config/$name/.hyprland.conf.swp" 2>/dev/null || true
    fi
done

grep -v 'zcode' "$HOME/.config/mimeapps.list" > "$DOTDIR/config/mimeapps.list" 2>/dev/null || true
cp "$HOME/.config/user-dirs.dirs" "$DOTDIR/config/" 2>/dev/null || true
cp "$HOME/.config/gtk-3.0/settings.ini" "$DOTDIR/config/gtk-3.0/" 2>/dev/null || true
cp "$HOME/.config/gtk-4.0/settings.ini" "$DOTDIR/config/gtk-4.0/" 2>/dev/null || true

for f in .gitconfig .gtkrc-2.0; do
    [[ -f "$HOME/$f" ]] && cp "$HOME/$f" "$DOTDIR/home/"
done

[[ -d /usr/share/themes/Nordic-darker-v40 ]] && \
    rm -rf "$DOTDIR/extra/themes/Nordic-darker-v40" && \
    cp -r /usr/share/themes/Nordic-darker-v40 "$DOTDIR/extra/themes/"

[[ -f "$HOME/Pictures/Wallpaper/arch.png" ]] && \
    cp "$HOME/Pictures/Wallpaper/arch.png" "$DOTDIR/assets/wallpaper/"

find "$DOTDIR" -name '*.bak' -delete
find "$DOTDIR" -name '*.hl.bak' -delete
rm -f "$DOTDIR/config/htop/htop_history"

echo "Done."
