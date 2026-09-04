#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec start-hyprland
fi


# Created by `pipx` on 2026-06-12 00:43:33
export PATH="$PATH:/home/farhan/.local/bin"
