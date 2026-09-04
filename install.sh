#!/usr/bin/env bash
#
# zara-dots installer
# Reproduces Farhan's Arch + Hyprland setup:
#   Hyprland, Waybar, Rofi, Dunst, Alacritty, Cava, LazyVim,
#   GTK theme Nordic-darker-v40 + WhiteSur-dark icons, wallpaper, shell & git config.
#
# Usage:
#   ./install.sh              # everything (packages + configs)
#   ./install.sh --no-pkgs    # skip package installation, configs only
#   ./install.sh --no-aur     # install official packages only, skip AUR
#   ./install.sh --no-backup  # don't back up existing configs (overwrite)
#
set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
NO_PKGS=0
NO_AUR=0
NO_BACKUP=0

for arg in "$@"; do
    case "$arg" in
        --no-pkgs)  NO_PKGS=1 ;;
        --no-aur)   NO_AUR=1 ;;
        --no-backup) NO_BACKUP=1 ;;
        -h|--help)
            sed -n '2,15p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
            exit 0 ;;
        *) echo "Unknown option: $arg"; exit 1 ;;
    esac
done

bold()  { printf '\033[1m%s\033[0m\n' "$*"; }
info()  { printf '\033[1;34m::\033[0m %s\n' "$*"; }
ok()    { printf '\033[1;32m::\033[0m %s\n' "$*"; }
die()   { printf '\033[1;31mERROR:\033[0m %s\n' "$*" >&2; exit 1; }

[[ $EUID -eq 0 ]] && die "Jangan jalanin sebagai root. Jalankan sebagai user biasa (sudo akan diminta otomatis)."
pacman -Q >/dev/null 2>&1 || die "Pacman tidak ditemukan — script ini khusus Arch Linux / turunannya."

bold "=============================="
bold "  ZARA-DOTS — Arch + Hyprland"
bold "=============================="
echo

# ─────────────────────────────────────────────
# 1. yay (AUR helper)
# ─────────────────────────────────────────────
if ! command -v yay >/dev/null 2>&1; then
    info "yay belum ada, build dari AUR..."
    tmpdir="$(mktemp -d)"
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    (cd "$tmpdir/yay" && makepkg -si --noconfirm)
    rm -rf "$tmpdir"
    ok "yay terpasang"
else
    ok "yay sudah ada"
fi

# ─────────────────────────────────────────────
# 2. Packages
# ─────────────────────────────────────────────
if [[ $NO_PKGS -eq 0 ]]; then
    info "Install paket official ($(wc -l < "$DOTDIR/packages/official.txt") paket)..."
    sudo pacman -S --needed --noconfirm - < "$DOTDIR/packages/official.txt"

    if [[ $NO_AUR -eq 0 ]]; then
        info "Install paket AUR ($(wc -l < "$DOTDIR/packages/aur.txt") paket)..."
        yay -S --needed --noconfirm - < "$DOTDIR/packages/aur.txt"
    fi
    ok "Semua paket beres"
else
    info "Skip install paket (--no-pkgs)"
fi

# ─────────────────────────────────────────────
# 3. Backup configs lama
# ─────────────────────────────────────────────
backup_and_copy() {
    local src="$1" dest="$2"
    if [[ -e "$dest" && $NO_BACKUP -eq 0 ]]; then
        mkdir -p "$BACKUP_DIR/$(dirname "${dest/#$HOME/\$HOME}")"
        mv "$dest" "$BACKUP_DIR/${dest/#$HOME/\$HOME}"
    fi
    mkdir -p "$(dirname "$dest")"
    cp -r "$src" "$dest"
}

# ─────────────────────────────────────────────
# 4. ~/.config
# ─────────────────────────────────────────────
info "Salin configs ke ~/.config ..."
for item in "$DOTDIR"/config/*; do
    name="$(basename "$item")"
    if [[ -e "$HOME/.config/$name" && $NO_BACKUP -eq 0 ]]; then
        mkdir -p "$BACKUP_DIR/.config"
        mv "$HOME/.config/$name" "$BACKUP_DIR/.config/$name"
    fi
    cp -r "$item" "$HOME/.config/"
done
ok "~/.config beres"

# ─────────────────────────────────────────────
# 5. Home dotfiles (.bashrc, .gitconfig, dst)
# ─────────────────────────────────────────────
info "Salin dotfiles ke \$HOME ..."
for item in "$DOTDIR"/home/.*; do
    name="$(basename "$item")"
    [[ "$name" == "." || "$name" == ".." ]] && continue
    backup_and_copy "$item" "$HOME/$name"
done

# .bashrc / .bash_profile punya path hardcoded /home/farhan — sesuaikan dengan user ini
sed -i "s|/home/farhan|$HOME|g" "$HOME/.bashrc" "$HOME/.bash_profile"
ok "$HOME beres"

# ─────────────────────────────────────────────
# 6. Theme + wallpaper
# ─────────────────────────────────────────────
info "Pasang theme Nordic-darker-v40 ke ~/.themes ..."
mkdir -p "$HOME/.themes"
rm -rf "$HOME/.themes/Nordic-darker-v40"
cp -r "$DOTDIR/extra/themes/Nordic-darker-v40" "$HOME/.themes/"

info "Pasang wallpaper ..."
mkdir -p "$HOME/Pictures/Wallpaper" "$HOME/Pictures/Screenshots"
[[ -f "$HOME/Pictures/Wallpaper/arch.png" ]] || \
    cp "$DOTDIR/assets/wallpaper/arch.png" "$HOME/Pictures/Wallpaper/arch.png"
ok "Theme + wallpaper beres"

# ─────────────────────────────────────────────
# 7. Git identity
# ─────────────────────────────────────────────
echo
info "Set identitas git (biar commit ga bentrok)."
read -rp "  Git name  [ZaraGoza1303]: " git_name
read -rp "  Git email [mantapucoco@gmail.com]: " git_email
git config --global user.name  "${git_name:-ZaraGoza1303}"
git config --global user.email "${git_email:-mantapucoco@gmail.com}"
ok "Git config beres"

# ─────────────────────────────────────────────
# Done
# ─────────────────────────────────────────────
echo
bold "=============================================="
ok   "SELESAI! Config terpasang."
[[ -d $BACKUP_DIR ]] && info "Config lama di-backup ke: $BACKUP_DIR"
bold "Reboot atau logout, lalu login → Hyprland otomatis start (via .bash_profile)."
bold "Kalau sudah di dalam sesi: hyprctl reload"
bold "=============================================="
