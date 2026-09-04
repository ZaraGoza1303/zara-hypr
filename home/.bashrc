#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias l='ls'
alias grep='grep --color=auto'
alias neofetch='fastfetch'
alias dockerco='sudo systemctl start docker'

# PS1='\[\e[36m\]\u@\h:\w\$ \[\e[0m\]'
# Prompt: white username@hostname, clean
PS1='\[\e[0;37m\]\u@\h\[\e[0m\] \[\e[0;34m\]\w\[\e[0m\] \$ '
export PATH=$PATH:/home/farhan/.npm-global/bin
export EDITOR='nvim'
export VISUAL='nvim'

# Created by `pipx` on 2026-06-12 00:43:33
export PATH="$PATH:/home/farhan/.local/bin"
