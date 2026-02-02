
#!/bin/bash

git clone https://aur.archlinux.org/yay-bin.git

#installers
#sudo pacman -S meson ninja cmake scdoc pkgconf base_devel --noconfirm

#dependencies
#sudo pacman -S jsoncpp libsigc++ fmt wayland wayland-protocols chrono-date spdlog gtk3 gobject-introspection \
#    libpulse libappindicator-gtk3 libdbusmenu-gtk3 libmpdclient libevdev upower pango cairo file libglvnd libjpeg-turbo libwebp hyprlang gcc pamixer \
#    libnl sndio --noconfirm

sudo pacman -S base_devel

#packages
sudo pacman -S fastfetch btop thunar --noconfirm

sudo pacman -S python --noconfirm
sudo pacman -S python-pip --noconfirm
sudo pacman -S python-packaging --noconfirm

#build packages
cd yay-bin
makepkg -srci --noconfirm

sudo pacman -S hyprpaper

#cd ~/sddm-sugar-dark
#makepkg pkgbuild -srci --noconfirm
#cd
sudo yay -S sddm-sugar-dark

mkdir wallpapers
mkdir wallpapers/active
#sudo mkdir /usr/local/etc/xdg/
#sudo mkdir /usr/local/etc/xdg/waybar
cd

#set up configs
sudo cp ~/archpkgs/tree.jpg /usr/share/sddm/themes/sugar-dark/Backgrounds/
sudo cp ~/archpkgs/tree.jpg ~/wallpapers/active/
sudo cp ~/archpkgs/wall2.png ~/wallpapers/
sudo cp ~/archpkgs/theme.conf /usr/share/sddm/themes/sugar-dark/
sudo cp ~/archpkgs/default.conf /usr/lib/sddm/sddm.conf.d/
sudo cp ~/archpkgs/hyprpaper.conf ~/.config/hypr/
sudo cp ~/archpkgs/hyprland.conf ~/.config/hypr/
sudo cp ~/archpkgs/btop.sh ~/.config/hypr
#sudo cp ~/archpkgs/waybar.conf /usr/local/etc/xdg/waybar/waybar.conf
#sudo mv /usr/local/etc/xdg/waybar/waybar.conf /usr/local/etc/xdg/waybar/config
#sudo cp -f ~/archpkgs/style.css /usr/local/etc/xdg/waybar/style.css
sudo cp ~/archpkgs/.bashrc ~/
sudo cp ~/archpkgs/.nanorc ~/
sudo cp ~/archpkgs/kitty.conf ~/.config/kitty/
sudo cp ~/archpkgs/startup.sh ~/.config/hypr/
sudo cp ~/archpkgs/paper.sh ~/

yay install python3-pip
sudo pacman -S python-pywal

#add startup script
cd
sudo chmod +x ~/.config/hypr/btop.sh

rm -rf ~/yay-bin

read -p 'Reboot? [Y/N]: ' confirm
if [ $confirm == 'y' ] || [ $confirm == 'Y' ]
    then exec reboot
    else exec clear
fi

