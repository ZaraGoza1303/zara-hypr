#!/usr/bin/env bash
#
# sync.sh — tarik ulang config TERBARU dari sistem ke dalam repo ini.
# Jalankan setiap kali kamu ubah config di sistem, biar repo nggak outdated.
#
set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ":: Sync config dari sistem -> repo"

# Config dirs (di-sync utuh)
for name in hypr waybar rofi dunst alacritty cava nvim mpv htop xsettingsd; do
    if [[ -d "$HOME/.config/$name" ]]; then
        rm -rf "$DOTDIR/config/$name"
        cp -r "$HOME/.config/$name" "$DOTDIR/config/"
    fi
done

# File tunggal
for f in mimeapps.list user-dirs.dirs; do
    [[ -f "$HOME/.config/$f" ]] && cp "$HOME/.config/$f" "$DOTDIR/config/"
done
cp "$HOME/.config/gtk-3.0/settings.ini" "$DOTDIR/config/gtk-3.0/" 2>/dev/null || true
cp "$HOME/.config/gtk-4.0/settings.ini" "$DOTDIR/config/gtk-4.0/" 2>/dev/null || true

# Home dotfiles
for f in .bashrc .bash_profile .profile .gitconfig .gtkrc-2.0; do
    [[ -f "$HOME/$f" ]] && cp "$HOME/$f" "$DOTDIR/home/"
done

# Theme (kalau masih ada)
[[ -d /usr/share/themes/Nordic-darker-v40 ]] && \
    rm -rf "$DOTDIR/extra/themes/Nordic-darker-v40" && \
    cp -r /usr/share/themes/Nordic-darker-v40 "$DOTDIR/extra/themes/"

# Package lists (selalu fresh dari pacman)
pacman -Qqe | sort > /tmp/zara-all.txt
pacman -Qqm | sort > /tmp/zara-aur.txt
comm -23 /tmp/zara-all.txt /tmp/zara-aur.txt | grep -vE '^(ZCode|yay-debug)$' > "$DOTDIR/packages/official.txt"
grep -xFf "$DOTDIR/packages/aur.txt" /tmp/zara-aur.txt > /dev/null || true

# Wallpaper
[[ -f "$HOME/Pictures/Wallpaper/arch.png" ]] && \
    cp "$HOME/Pictures/Wallpaper/arch.png" "$DOTDIR/assets/wallpaper/"

# Bersihkan file backup
find "$DOTDIR" -name '*.bak' -delete

echo ":: Selesai. Jangan lupa commit & push:"
echo "   cd $DOTDIR && git add -A && git commit -m 'sync dots' && git push"
