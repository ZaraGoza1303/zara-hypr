# zara-dots

Dotfiles untuk setup **Arch Linux + Hyprland** milik Farhan (ZaraGoza1303).
Isinya khusus **tampilan / ricing** — bukan aplikasi.

## Setup

- **WM**: Hyprland + hyprlock, hyprpaper, hypridle, hyprmod
- **Bar**: Waybar (black clean theme)
- **Launcher**: Rofi (dark, JetBrains Mono)
- **Notifikasi**: Dunst
- **Terminal**: Alacritty (bg `#0a0a0a`, JetBrainsMono Nerd Font)
- **Editor**: Neovim (LazyVim, plugin ter-lock via `lazy-lock.json`)
- **Visualizer**: Cava + shaders
- **GTK**: Nordic-darker-v40 + WhiteSur-dark (theme ikut di repo)
- **Wallpaper**: `~/Pictures/Wallpaper/arch.png` (ikut di repo)
- **Shell**: Bash + Hyprland auto-start dari TTY

Warna konsisten: bg `#0a0a0a`, text `#e0e0e0`, accent `#ff5555`
(waybar, rofi, alacritty, dunst).

## Pakai di install Arch baru

```bash
sudo pacman -S --needed git
git clone https://github.com/ZaraGoza1303/zara-dots.git
cd zara-dots
./install.sh
```

Langkah yang dijalankan:

1. Install `yay` kalau belum ada
2. Install paket (44 official + 5 AUR) — daftar di `packages/`, komentar `#` di list di-skip
3. Backup config lama ke `~/.config-backup-<tanggal>/`
4. Salin config ke `~/.config` dan dotfiles ke `~`
5. Pasang theme + wallpaper
6. Set identitas git (ditanya dulu)
7. Path `/home/farhan` di `.bashrc`/`.bash_profile` otomatis diganti `$HOME`

Lalu **reboot** — Hyprland auto start dari TTY.

Skip install paket: `./install.sh --no-pkgs`

## Struktur

```
zara-dots/
├── install.sh              # pasang (repo → sistem)
├── sync.sh                 # update repo (sistem → repo), auto commit
├── packages/
│   ├── official.txt        # 44 paket official (look-only)
│   └── aur.txt             # 5 paket AUR
├── config/                 # → ~/.config/
├── home/                   # → ~/ (.bashrc, .gitconfig, dll)
├── extra/themes/           # Nordic-darker-v40 (bukan dari pacman)
└── assets/wallpaper/       # arch.png
```

## Catatan

- Package list dijaga **look-only**: Hyprland stack, waybar, rofi, dunst,
  alacritty, font, theme, tool screenshot/volume/brightness, cava, nautilus.
  Browser, Ollama, database, VPN, dll **tidak** termasuk — install sendiri kalau perlu.
- `playerctl`, `hyprpolkitagent`, `xsettingsd` sengaja dimasukkan walau di sistem
  lama cuma ada sebagai dep / belum terpasang — config kamu memang mereferensikannya.
- GPU AMD (`vulkan-radeon`). Kalau NVIDIA, tambahkan driver sendiri.
- `.git-credentials` sengaja tidak masuk repo (isinya password).
