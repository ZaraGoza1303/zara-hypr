#!/usr/bin/env bash
set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
SKIP_PKGS=0
[[ "${1:-}" == "--no-pkgs" ]] && SKIP_PKGS=1

[[ $EUID -eq 0 ]] && echo "Jangan jalankan sebagai root." && exit 1

# 1. Install yay
command -v yay >/dev/null || {
    git clone https://aur.archlinux.org/yay.git /tmp/yay-build
    (cd /tmp/yay-build && makepkg -si --noconfirm)
    rm -rf /tmp/yay-build
}

# 2. Install paket (look-only, lihat packages/)
if [[ $SKIP_PKGS -eq 0 ]]; then
    grep -v '^#' packages/official.txt | sudo pacman -S --needed --noconfirm -
    grep -v '^#' packages/aur.txt | yay -S --needed --noconfirm -
fi

# 3. Backup config lama, salin config baru ke ~/.config
mkdir -p "$BACKUP/.config"
for item in "$DOTDIR"/config/*; do
    name="$(basename "$item")"
    [[ -e "$HOME/.config/$name" ]] && mv "$HOME/.config/$name" "$BACKUP/.config/"
    cp -r "$item" "$HOME/.config/"
done

# 4. Salin dotfiles ke $HOME
for item in "$DOTDIR"/home/.*; do
    name="$(basename "$item")"
    [[ "$name" == "." || "$name" == ".." ]] && continue
    [[ -e "$HOME/$name" ]] && mv "$HOME/$name" "$BACKUP/"
    cp -r "$item" "$HOME/$name"
done
sed -i "s|/home/farhan|$HOME|g" "$HOME/.bashrc" "$HOME/.bash_profile"

# 5. Theme & wallpaper
mkdir -p "$HOME/.themes" "$HOME/Pictures/Wallpaper" "$HOME/Pictures/Screenshots"
rm -rf "$HOME/.themes/Nordic-darker-v40"
cp -r "$DOTDIR/extra/themes/Nordic-darker-v40" "$HOME/.themes/"
[[ -f "$HOME/Pictures/Wallpaper/arch.png" ]] || \
    cp "$DOTDIR/assets/wallpaper/arch.png" "$HOME/Pictures/Wallpaper/"

# 6. Git identity
read -rp "Git name  [ZaraGoza1303]: " git_name
read -rp "Git email [mantapucoco@gmail.com]: " git_email
git config --global user.name  "${git_name:-ZaraGoza1303}"
git config --global user.email "${git_email:-mantapucoco@gmail.com}"

# 7. Selesai
echo "Selesai. Backup config lama: $BACKUP"
echo "Reboot untuk masuk Hyprland (auto start dari TTY)."
