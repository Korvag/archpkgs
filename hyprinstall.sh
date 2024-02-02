#!/bin/bash


#installers
sudo pacman -S meson ninja cmake scdoc pkgconf --noconfirm


#dependencies
sudo pacman -S jsoncpp libsigc++ fmt wayland wayland-protocols chrono-date spdlog libgtk-3 gobject-introspection libgirepository1.0\
    libpulse libappindicator-gtk3 libdbusmenu-gtk3 libmpdclient libevdev upower pango cairo file libglvnd libjpeg-turbo libwebp hyprlang gcc pamixer --noconfirm

#packages
sudo pacman -S hyprpaper neofetch btop gtkmm3 thunar --noconfirm

git clone --recursive https://github.com/hyprwm/Hyprland
git clone https://github.com/Alexays/Waybar
git clone https://aur.archlinux.org/sddm-sugar-candy-git.git
git clone https://aur.archlinux.org/yay-bin


#build packages
cd yay-bin
makepkg -srci --noconfirm

cd
yay -S gdb libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput\
  libxrender pixman seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus

cd ~/Hyprland
make all && sudo make install

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
sudo mkdir /usr/local/etc/xdg/
sudo mkdir /usr/local/etc/xdg/waybar
sudo mkdir ~/wallpapers
sudo mkdir ~/wallpapers/active
sudo mkdir ~/.config/kitty
cd

#set up configs
sudo cp ~/archpkgs/tree.jpg /usr/share/sddm/themes/sugar-candy/Backgrounds/
sudo cp ~/archpkgs/tree.jpg ~/wallpapers/
sudo cp ~/archpkgs/wall2.png ~/wallpapers/
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
sudo cp ~/archpkgs/paper.sh ~/
sudo cp ~/archpkgs/startup.sh ~/.config/hypr/
sudo cp ~/archpkgs/kitty.conf ~/.config/kitty/


#add startup script
cd
sudo chmod +x ~/.config/hypr/btop.sh

cd
sudo rm ~/archpkgs/btop.sh ~/archpkgs/paper.py

sudo reboot
