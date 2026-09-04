# zara-hypr

Dotfiles for my **Arch Linux + Hyprland** setup.
Contains only the **look / ricing** — not applications.

## Setup

- **WM**: Hyprland + hyprlock, hyprpaper, hypridle, hyprmod
- **Shell**: fish (Hyprland auto-starts from TTY1)
- **Bar**: Waybar (black clean theme)
- **Launcher**: Rofi (dark, JetBrains Mono)
- **Notifications**: Dunst
- **Terminal**: Alacritty (bg `#0a0a0a`, JetBrainsMono Nerd Font)
- **Editor**: Neovim (LazyVim, plugins locked via `lazy-lock.json`)
- **Visualizer**: Cava + shaders
- **GTK**: Nordic-darker-v40 + WhiteSur-dark (theme included in repo)
- **Wallpaper**: `~/Pictures/Wallpaper/arch.png` (included in repo)

Consistent palette: bg `#0a0a0a`, text `#e0e0e0`, accent `#ff5555`
(waybar, rofi, alacritty, dunst).

## Use on a fresh Arch install

```bash
sudo pacman -S --needed git
git clone https://github.com/ZaraGoza1303/zara-hypr.git
cd zara-hypr
./install.sh
```

What it does:

1. Installs `yay` if missing
2. Installs packages (45 official + 5 AUR) — lists in `packages/`, `#` comments are skipped
3. Backs up existing configs to `~/.config-backup-<date>/`
4. Copies configs into `~/.config` and dotfiles into `~`
5. Installs the GTK theme + wallpaper
6. Sets fish as the login shell

Then **reboot** — Hyprland auto-starts from TTY1 (via fish).

Skip package installation: `./install.sh --no-pkgs`

## Structure

```
zara-hypr/
├── install.sh              # install (repo → system)
├── sync.sh                 # update repo (system → repo)
├── packages/
│   ├── official.txt        # 44 official packages (look-only)
│   └── aur.txt             # 5 AUR packages
├── config/                 # → ~/.config/
├── home/                   # → ~/ (.gitconfig, .gtkrc-2.0)
├── extra/themes/           # Nordic-darker-v40 (not from pacman)
└── assets/wallpaper/       # arch.png
```

## Notes

- Package lists are kept **look-only**: Hyprland stack, waybar, rofi, dunst,
  alacritty, fonts, theme, screenshot/volume/brightness tools, cava, nautilus.
  Browsers, Ollama, databases, VPNs, etc. are **not** included — install those yourself.
- `playerctl`, `hyprpolkitagent`, `xsettingsd` are included on purpose even though
  the old system only had them as deps / didn't have them at all — my configs reference them.
- GPU is AMD (`vulkan-radeon`). On NVIDIA, add your own drivers.

## Keeping it up to date

After changing configs on the system, pull them into the repo, then commit & push:

```bash
./sync.sh
git add -A && git commit -m "sync dots" && git push
```
