if status is-interactive
    alias l='ls --color=auto'
    alias grep='grep --color=auto'
    alias neofetch=fastfetch
    alias dockerco='sudo systemctl start docker'
end

# Prompt: white username@hostname, clean
function fish_prompt
    set_color white
    echo -n (whoami)@(hostname)' '
    set_color blue
    echo -n (prompt_pwd)' '
    set_color normal
    echo -n '$ '
end

fish_add_path ~/.npm-global/bin ~/.local/bin

set -gx EDITOR nvim
set -gx VISUAL nvim

# Firefox Wayland
set -gx MOZ_ENABLE_WAYLAND 1
set -gx MOZ_USE_PIPEWIRE 1

# Start Hyprland on TTY1
if status is-login; and test "$XDG_VTNR" = 1; and test -z "$DISPLAY"; and test -z "$WAYLAND_DISPLAY"
    exec start-hyprland
end
