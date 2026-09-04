#!/usr/bin/env bash
set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
SKIP_PKGS=0
[[ "${1:-}" == "--no-pkgs" ]] && SKIP_PKGS=1

[[ $EUID -eq 0 ]] && { echo "Do not run as root."; exit 1; }

# 1. Install yay
command -v yay >/dev/null || {
    curl -L -o /tmp/yay.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
    mkdir -p /tmp/yay-build && tar -xf /tmp/yay.tar.gz -C /tmp/yay-build --strip-components=1
    (cd /tmp/yay-build && makepkg -si --noconfirm)
    rm -rf /tmp/yay.tar.gz /tmp/yay-build
}

# 2. Install packages (look-only, see packages/)
if [[ $SKIP_PKGS -eq 0 ]]; then
    grep -v '^#' packages/official.txt | sudo pacman -S --needed --noconfirm -
    grep -v '^#' packages/aur.txt | yay -S --needed --noconfirm -
fi

# 3. Back up old configs, copy new ones into ~/.config
mkdir -p "$BACKUP/.config"
for item in "$DOTDIR"/config/*; do
    name="$(basename "$item")"
    [[ -e "$HOME/.config/$name" ]] && mv "$HOME/.config/$name" "$BACKUP/.config/"
    cp -r "$item" "$HOME/.config/"
done

# 4. Copy home dotfiles
for item in "$DOTDIR"/home/.*; do
    name="$(basename "$item")"
    [[ "$name" == "." || "$name" == ".." ]] && continue
    [[ -e "$HOME/$name" ]] && mv "$HOME/$name" "$BACKUP/"
    cp -r "$item" "$HOME/$name"
done

# 5. GTK theme & wallpaper
mkdir -p "$HOME/.themes" "$HOME/Pictures/Wallpaper" "$HOME/Pictures/Screenshots"
rm -rf "$HOME/.themes/Nordic-darker-v40"
cp -r "$DOTDIR/extra/themes/Nordic-darker-v40" "$HOME/.themes/"
[[ -f "$HOME/Pictures/Wallpaper/arch.png" ]] || \
    cp "$DOTDIR/assets/wallpaper/arch.png" "$HOME/Pictures/Wallpaper/"

# 6. Make fish the login shell
if [[ "$SHELL" != *fish* ]] && command -v fish >/dev/null; then
    chsh -s "$(command -v fish)" || echo "Could not change shell — run manually: chsh -s /usr/bin/fish"
fi

# Done
echo "Done. Old configs backed up to: $BACKUP"
echo "Reboot to start Hyprland (auto-starts from TTY1 via fish)."
