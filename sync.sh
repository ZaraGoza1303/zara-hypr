#!/usr/bin/env bash
# Pull the latest configs from the system into this repo, then commit.
set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for name in hypr waybar rofi dunst alacritty cava nvim mpv htop xsettingsd fish; do
    if [[ -d "$HOME/.config/$name" ]]; then
        rm -rf "$DOTDIR/config/$name"
        cp -r "$HOME/.config/$name" "$DOTDIR/config/"
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
rm -f "$DOTDIR/config/htop/htop_history"

echo "Done."
