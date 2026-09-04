# zara-dots

Dotfiles buat setup **Arch Linux + Hyprland** milik Farhan (ZaraGoza1303).
Satu script, langsung reproduce setup yang sekarang dipakai.

## Isi setup

| Komponen | Config |
|---|---|
| WM | Hyprland (+ hyprlock, hyprpaper, hypridle, hyprmod) |
| Bar | Waybar — black clean theme, pill transparan |
| Launcher | Rofi — dark theme, JetBrains Mono |
| Notifikasi | Dunst |
| Terminal | Alacritty — bg `#0a0a0a`, JetBrainsMono Nerd Font |
| Editor | Neovim — LazyVim (`lazy-lock.json` ikut ter-lock) |
| Visualizer | Cava (dengan shaders) |
| GTK | Nordic-darker-v40 + icon WhiteSur-dark (theme ikut di-repo) |
| Wallpaper | `~/Pictures/Wallpaper/arch.png` (ikut di-repo) |
| Shell | Bash + PS1 clean, alias, start Hyprland dari TTY |
| Media | mpv, htop |

## Cara pakai (di install Arch baru)

```bash
# 1. Pastikan ada internet + git
sudo pacman -S --needed git

# 2. Clone & jalanin
git clone https://github.com/ZaraGoza1303/zara-dots.git
cd zara-dots
chmod +x install.sh
./install.sh
```

Script akan otomatis:

1. Install **yay** kalau belum ada
2. Install **121 paket official + 14 paket AUR** (list di `packages/`)
3. Backup config lama ke `~/.config-backup-<tanggal>/` dulu (nggak overwrite langsung)
4. Salin semua config ke `~/.config` dan `~`
5. Pasang theme Nordic-darker-v40 ke `~/.themes` + wallpaper
6. Tanya identitas git (name/email)
7. Path hardcoded di `.bashrc` (misal `/home/farhan`) otomatis disesuaikan dengan `$HOME` user baru

Setelah selesai → **reboot**, dan Hyprland auto-start dari TTY1 (lewat `.bash_profile`).

## Opsi installer

```bash
./install.sh --no-pkgs     # configs doang, skip install paket
./install.sh --no-aur      # official packages doang
./install.sh --no-backup   # overwrite tanpa backup
```

## Struktur repo

```
zara-dots/
├── install.sh              # script utama
├── packages/
│   ├── official.txt        # hasil pacman -Qqe (121)
│   └── aur.txt             # paket AUR (14)
├── config/                 # → ~/.config/
│   ├── hypr/               # hyprland.conf, hyprlock, hyprpaper, dst
│   ├── waybar/ rofi/ dunst/ alacritty/ cava/ nvim/ mpv/ htop/
│   ├── gtk-3.0/ gtk-4.0/ xsettingsd/
│   └── mimeapps.list, user-dirs.dirs
├── home/                   # → ~/ (dotfiles)
│   ├── .bashrc .bash_profile .profile
│   └── .gitconfig .gtkrc-2.0
├── extra/themes/           # Nordic-darker-v40 (install manual, bukan dari pacman)
└── assets/wallpaper/       # arch.png (dipakai hyprpaper + hyprlock)
```

## Catatan

- **Paket AUR** di list ini: `brave-bin, hyprmod, whitesur-icon-theme, bibata-cursor-theme,
  wlogout, stacer, ngrok, ollama-bin, pgadmin4-desktop-bin, win2xcur, captive-browser-git,
  f3, dnslookup, yay`.
- Kalau pakai **NVIDIA**, tambahkan sendiri driver (`nvidia-dkms` dst) — setup ini
  pakai GPU AMD (`vulkan-radeon`).
- `.git-credentials` **sengaja tidak** masuk repo (isinya password/token).
- Cursor theme di GTK settings tertulis `RobloxCursors` tapi tidak ter-install di
  sistem — nggak masalah, fallback ke default/Bibata. Kalau mau Bibata, ganti
  `gtk-cursor-theme-name` jadi `Bibata-Modern-Ice`.
- Update repo kapan pun setelah ubah config:
  ```bash
  cd zara-dots && ./sync.sh   # tarik ulang config dari sistem ke repo
  ```

## Screenshot / ricing

Theme warna utama: background `#0a0a0a`, text `#e0e0e0`, accent `#ff5555` —
dipakai konsisten di waybar, rofi, alacritty, dan dunst.
