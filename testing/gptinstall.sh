#!/bin/bash

TOTAL_STEPS=12
CURRENT_STEP=0

progress_bar() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    PERCENT=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    FILLED=$((PERCENT / 2))
    EMPTY=$((50 - FILLED))

    BAR=$(printf "%${FILLED}s" | tr ' ' '#')
    SPACE=$(printf "%${EMPTY}s")

    echo -ne "\r[${BAR}${SPACE}] ${PERCENT}% - $1"
}

echo "Starting installation..."

# wallpapers prompt
read -p 'Do you want to install extra wallpapers? [Y/n]: ' walls
if [[ $walls == 'Y' || $walls == 'y' || $walls == '' ]]; then
    git clone https://github.com/D3Ext/aesthetic-wallpapers.git && papers='y'
else
    papers='n'
fi
progress_bar "Wallpaper selection done"

# clone repos
git clone https://github.com/Alexays/Waybar
git clone https://aur.archlinux.org/sddm-sugar-dark.git
git clone https://aur.archlinux.org/yay-bin
progress_bar "Repositories cloned"

# installers
sudo pacman -S meson ninja cmake scdoc pkgconf --noconfirm
progress_bar "Installed build tools"

# dependencies
sudo pacman -S jsoncpp libsigc++ fmt wayland wayland-protocols chrono-date spdlog libgtk-3-dev gobject-introspection libgirepository1.0-dev \
    libpulse libappindicator-gtk3 libdbusmenu-gtk3 libmpdclient libevdev upower pango cairo file libglvnd libjpeg-turbo libwebp hyprlang gcc pamixer \
    libnl libsndio xkbregistry --noconfirm
progress_bar "Dependencies installed"

# packages
sudo pacman -S glib2-devel hyprpaper neofetch btop gtkmm3 thunar --noconfirm
progress_bar "Base packages installed"

sudo pacman -S python python-pip python-packaging --noconfirm
progress_bar "Python setup done"

# build yay
cd yay-bin
makepkg -srci --noconfirm
progress_bar "yay built"

# build waybar
cd ~/Waybar
sudo meson build
sudo ninja -C build
sudo ninja -C build install
progress_bar "Waybar built"

# build hyprpaper
cd ~/hyprpaper
make all
progress_bar "Hyprpaper built"

# build sddm theme
cd ~/sddm-sugar-dark
makepkg -srci --noconfirm
cd
progress_bar "SDDM theme built"

# setup dirs
mkdir -p wallpapers/active
progress_bar "Directories created"

# configs
sudo cp ~/archpkgs/tree.jpg /usr/share/sddm/themes/sugar-dark/Backgrounds/
sudo cp ~/archpkgs/tree.jpg ~/wallpapers/active/
sudo cp ~/archpkgs/wall2.png ~/wallpapers/
sudo cp ~/archpkgs/theme.conf /usr/share/sddm/themes/sugar-dark/
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
sudo cp ~/archpkgs/startup.sh ~/.config/hypr/
sudo cp ~/archpkgs/paper.sh ~/
progress_bar "Configs applied"

# wallpapers move
if [[ $papers == 'y' ]]; then
    sudo mv ~/aesthetic-wallpapers/images/* ~/wallpapers/
fi

# final installs
yay install python3-pip
sudo pacman -S python-pywal
progress_bar "Final packages installed"

# permissions + cleanup
sudo chmod +x ~/.config/hypr/btop.sh
rm -rf ~/aesthetic-wallpapers ~/sddm-sugar-dark ~/yay-bin
sudo rm -rf ~/Waybar
progress_bar "Cleanup complete"

echo -e "\nInstallation complete!"

# reboot prompt
read -p 'Reboot? [Y/N]: ' confirm
if [[ $confirm == 'y' || $confirm == 'Y' ]]; then
    exec reboot
else
    exec clear
fi