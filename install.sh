#!/bin/bash

# install yay
if [ ! -d "yay" ]; then
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
else
    echo "Folder yay sudah ada, melewati clone..."
fi
cd /tmp/yay
makepkg -si --noconfirm
cd ..
rm -rf /tmp/yay

# update system
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm zsh zsh-autosuggestions zsh-syntax-highlighting


# Install hyprland
sudo pacman -S hyprland kitty --noconfirm
sudo pacman -S xdg-desktop-portal-hyprland --noconfirm

# Install audio pakages

sudo pacman -S pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack alsa-utils --noconfirm
sudo pacman -S pavucontrol --noconfirm

if systemctl --user is-enabled pipewire.service &>/dev/null; then
    echo "Pipewire sudah diaktifkan."
else
    echo "Mengaktifkan Pipewire..."
    systemctl --user enable --now pipewire.service
    systemctl --user enable --now pipewire-pulse.service
    systemctl --user enable --now wireplumber.service
fi

# bluetooth packages
sudo pacman -S bluez bluez-utils blueman --noconfirm

sudo systemctl enable --now bluetooth.service

# Install file manager
sudo pacman -S thunar gvfs thunar-archive-plugin thunar-media-tags-plugin tumbler --noconfirm

# Install notification daemon
sudo pacman -S mako --noconfirm

# Install clipboard
sudo pacman -S cliphist wl-clipboard --noconfirm

# Install polkit agent
sudo pacman -S hyprpolkitagent --noconfirm

systemctl --user enable --now hyprpolkitagent.service
systemctl --user start --now hyprpolkitagent.service

# Install packages from AUR
yay -S --noconfirm google-chrome 
yay -S --noconfirm visual-studio-code-bin
yay -S --noconfirm swww
yay -S --noconfirm greetd

# install extra packages
sudo pacman -S --noconfirm quickshell rofi obsidian
sudo pacman -S --noconfirm noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra
fc-cache -fv


echo "Creating symlink..."

ln -sf ~/dotfiles/.config/hypr ~/.config/hypr
ln -sf ~/dotfiles/.config/quickshell ~/.config/quickshell
ln -sf ~/dotfiles/.config/mako ~/.config/mako
ln -sf ~/dotfiles/.config/kitty ~/.config/kitty
ln -sf ~/dotfiles/.config/rofi ~/.config/rofi