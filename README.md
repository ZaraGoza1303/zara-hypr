## Installation
```
git clone https://ZaraGoza1303/zara-hypr.git
cd zara-hypr
./install.sh
```

## Start
You can start hyprland by just simply type, after login tty:
```
start-hyprland
```

Or if you want it to run automatically after login tty, you need to create **.bash_profile** file and then insert this command in the file:
```
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec start-hyprland
fi
```
