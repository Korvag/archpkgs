#!/bin/bash


#installers
sudo pacman -S meson ninja cmake scdoc pkgconf --noconfirm


#dependencies
sudo pacman -S jsoncpp libsigc++ fmt wayland wayland-protocols chrono-date spdlog libgtk-3-dev gobject-introspection libgirepository1.0-dev\
    libpulse libappindicator-gtk3 libdbusmenu-gtk3 libmpdclient libevdev upower pango cairo file libglvnd libjpeg-turbo libwebp hyprlang gcc pamixer\
    libnl libsndio xkbregistry --noconfirm


#packages
sudo pacman -S hyprpaper neofetch btop gtkmm3 thunar --noconfirm

git clone https://github.com/Alexays/Waybar
git clone https://aur.archlinux.org/sddm-sugar-candy-git.git
git clone https://aur.archlinux.org/yay-bin

sudo pacman -S python -y
sudo pacman -S python-pip -y
sudo pacman -S python-packaging -y

#build packages
cd yay-bin
makepkg -srci --noconfirm

cd ~/Waybar
sudo meson build
sudo ninja -C build
sudo ninja -C build install

cd ~/hyprpaper
make all

cd ~/sddm-sugar-candy-git
makepkg -srci --noconfirm
cd

mkdir wallpapers
#sudo mkdir /usr/local/etc/xdg/
#sudo mkdir /usr/local/etc/xdg/waybar
cd

#set up configs
sudo cp ~/archpkgs/tree.jpg /usr/share/sddm/themes/sugar-candy/Backgrounds/
sudo cp ~/archpkgs/tree.jpg ~/wallpapers/
sudo cp ~/archpkgs/theme.conf /usr/share/sddm/themes/sugar-candy/
sudo cp ~/archpkgs/default.conf /usr/lib/sddm/sddm.conf.d/
sudo cp ~/archpkgs/hyprpaper.conf ~/.config/hypr/
sudo cp ~/archpkgs/hyprland.conf ~/.config/hypr/
sudo cp ~/archpkgs/btop.sh ~/.config/hypr
sudo cp ~/archpkgs/waybar.conf /usr/local/etc/xdg/waybar/waybar.conf
sudo mv /usr/local/etc/xdg/waybar/waybar.conf /usr/local/etc/xdg/waybar/config
sudo cp -f ~/archpkgs/style.css /usr/local/etc/xdg/waybar/style.css
sudo cp ~/archpkgs/.bashrc ~/
sudo cp ~/archpkgs/.nanorc ~/
sudo cp ~/archpkgs/kitty.conf ~/.config/kitty/


#add startup script
cd
sudo chmod +x ~/.config/hypr/btop.sh
