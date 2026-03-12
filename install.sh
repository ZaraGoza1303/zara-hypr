#!/bin/bash

check_status() {
    if [ $? -eq 0 ]; then
        echo -e "\e[32m[OK]\e[0m $1 success."
    else
        echo -e "\e[31m[ERROR]\e[0m $1 failed!"
    fi
}

read -p "Are you sure want to install this dotfiles ? (Y/n)" CONFIRMATION
if [[ "$CONFIRMATION" == "y" || "$CONFIRMATION" == "Y" ]]; then
	echo "Installing Hyprland Essentials..."
	sudo pacman -S hyprland hyprpaper hypridle hyprlock waybar rofi dunst nwg-look wlogout grim slurp wl-clipboard xdg-desktop-portal-hyprland xdg-desktop-portal-gtk polkit-kde-agent qt5-wayland qt6-wayland

	echo "Installing Audio & Media Stack..."
	sudo pacman -S pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber gst-plugin-pipewire pavucontrol pamixer

	echo "Installing File Manager and Utilities..."
	sudo pacman -S thunar nautilus gvfs gvfs-mtp gvfs-google gvfs-afc gvfs-dnssd gvfs-goa gvfs-gphoto2 gvfs-nfs gvfs-onedrive gvfs-smb gvfs-wsdd xdg-user-dirs-gtk

	echo "Installing Alacritty..."
	sudo pacman -S alacritty

	echo "Symlink the configuration file to folder .config ...."
	mkdir -p ~/.config

	ln -sfn "$(pwd)/hypr" ~/.config/hypr && check_status "Symlink hypr"
    	ln -sfn "$(pwd)/waybar" ~/.config/waybar && check_status "Symlink waybar"
    	ln -sfn "$(pwd)/dunst" ~/.config/dunst && check_status "Symlink dunst"
    	ln -sfn "$(pwd)/rofi" ~/.config/rofi && check_status "Symlink rofi"
	ln -sfn "$(pwd)/alacritty" ~/.config/rofi && check_status "Symlink alacritty"


	echo "Success symlink the configuration files!"
	echo "Installed Successfully"
	
	echo "Bye"
	exit 1

fi
