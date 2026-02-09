
#!/bin/bash

if [ -e "~/archpkgs/tree.jpg" ]; then
    clone=0
else
    clone=1
fi

git clone https://aur.archlinux.org/yay-bin.git
sudo pacman -S base-devel --noconfirm

#packages
sudo pacman -S fastfetch btop thunar --noconfirm

sudo pacman -S python --noconfirm
sudo pacman -S python-pip --noconfirm
sudo pacman -S python-packaging --noconfirm

#build packages
cd yay-bin
makepkg -srci --noconfirm

sudo pacman -S hyprpaper --noconfirm
yay -S sddm-sugar-dark --noconfirm

mkdir wallpapers
mkdir wallpapers/active
cd

if [ $clone -ne 0 ]; then
    clone https://github.com/Korvag/archpkgs.git
else 
    :
fi

#set up configs
sudo cp ~/archpkgs/tree.jpg /usr/share/sddm/themes/sugar-dark/Backgrounds/
sudo cp ~/archpkgs/tree.jpg ~/wallpapers/active/
sudo cp ~/archpkgs/wall2.png ~/wallpapers/
sudo cp ~/archpkgs/theme.conf /usr/share/sddm/themes/sugar-dark/
sudo cp ~/archpkgs/default.conf /usr/lib/sddm/sddm.conf.d/
sudo cp ~/archpkgs/hyprpaper.conf ~/.config/hypr/
sudo cp ~/archpkgs/hyprland.conf ~/.config/hypr/
sudo cp ~/archpkgs/btop.sh ~/.config/hypr
sudo cp ~/archpkgs/.bashrc ~/
sudo cp ~/archpkgs/.nanorc ~/
sudo cp ~/archpkgs/kitty.conf ~/.config/kitty/
sudo cp ~/archpkgs/startup.sh ~/.config/hypr/
sudo cp ~/archpkgs/paper.sh ~/

yay install python3-pip
sudo pacman -S python-pywal --noconfirm

#add startup script
cd
sudo chmod +x ~/.config/hypr/btop.sh

rm -rf ~/yay-bin

if [ -e "~/archpkgs/tree.jpg" ]; then
    rm -rf ~/archpkgs
else
    :
fi

read -p 'Reboot? [Y/N]: ' confirm
if [ $confirm == 'y' ] || [ $confirm == 'Y' ]
    then exec reboot
    else exec clear
fi

