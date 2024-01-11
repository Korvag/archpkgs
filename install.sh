#!/bin/bash


#installers
sudo pacman -S meson ninja cmake scdoc pkgconf git

#dependencies
sudo pacman -S gtkmm3 jsoncpp libsigc++ fmt wayland wayland-protocols chrono-date spdlog libgtk-3-dev gobject-introspection libgirepository1.0-dev libpulse libn1 libappindicator-gtk3 libdbusmenu-gtk3 libmpdclient libsndio libevdev xkbregistry upower pango cairo file libglvnd libglvnd-core libjpeg-turbo libwebp hyprlang gcc

#yay
git clone https://aur.archlinux.org/yay-bin
cd yay-bin
makepkg -si
cd

#packages
sudo pacman -S hyprpaper neofetch btop waybar

cd Waybar
meson build
ninja -C build
ninja -C build install
cd

cd hyprpaper
make all
cd


git clone https://github.com/Korvag/wallpapers.git
git clone https://aur.archlinux.org/sddm-sugar-candy-git.git


cd sddm-sugar-candy-git
makepkg -si
cd


sudo cp ~/wallpapers/tree.jpg /usr/share/sddm/themes/sugar-candy/Backgrounds/
sudo cp ~/archpkgs/theme.conf /usr/share/sddm/themes/sugar-candy/
sudo cp ~/archpkgs/default.conf /usr/lib/sddm/sddm.conf.d/
sudo cp ~/archpkgs/hyprpaper.conf ~/.config/hypr/
sudo cp ~/archpkgs/hyprland.conf ~/.config/hypr/
sudo cp ~/archpkgs/btop.sh ~/.config/hypr
sudo cp ~/archpkgs/waybar.conf /usr/local/etc/xdg/waybar/
mv waybar.conf config
sudo cp ~/archpkgs/style.css /usr/local/etc/xdg/waybar/
sudo cp ~/archpkgs/.bashrc ~/



cd
sudo chmod +x ~/.config/hypr/btop.sh
