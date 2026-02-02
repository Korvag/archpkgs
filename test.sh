
#!/bin/bash

git clone https://aur.archlinux.org/yay-bin.git
sudo pacman -S base_devel

#packages
sudo pacman -S fastfetch btop thunar --noconfirm

sudo pacman -S python --noconfirm
sudo pacman -S python-pip --noconfirm
#sudo pacman -S python-packaging --noconfirm

#build packages
cd yay-bin
makepkg -srci --noconfirm

sudo pacman -S hyprpaper
sudo yay -S sddm-sugar-dark

mkdir wallpapers
mkdir wallpapers/active
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

