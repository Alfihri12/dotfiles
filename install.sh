#!/bin/bash

# Tambahkan di awal
if [ "$EUID" -eq 0 ]; then
    echo "Jangan jalankan script ini sebagai root!"
    exit 1
fi


# install yay
if command -v yay &>/dev/null; then
    echo "yay sudah terinstall, melewati..."
else
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    ORIGINAL_DIR=$(pwd)
    cd /tmp/yay
    makepkg -si --noconfirm
    cd "$ORIGINAL_DIR"
fi


# update system
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm brightnessctl zsh zsh-autosuggestions zsh-syntax-highlighting


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

systemctl --user start --now hyprpolkitagent.service

# install keyring
sudo pacman -S gnome-keyring --noconfirm

# Install packages from AUR
yay -S --noconfirm google-chrome visual-studio-code-bin swww greetd


# install extra packages
sudo pacman -S --noconfirm quickshell rofi obsidian
sudo pacman -S --noconfirm noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra
fc-cache -fv


echo "Creating symlink..."

# ln -sf ~/dotfiles/.config/hypr ~/.config/hypr
# ln -sf ~/dotfiles/.config/quickshell ~/.config/quickshell
# ln -sf ~/dotfiles/.config/mako ~/.config/mako
# ln -sf ~/dotfiles/.config/kitty ~/.config/kitty
# ln -sf ~/dotfiles/.config/rofi ~/.config/rofi

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# Cek apakah folder dotfiles ada
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "ERROR: Folder dotfiles tidak ditemukan di $DOTFILES_DIR"
    echo "Clone dotfiles dulu, dan simpan di home directory."
    exit 1
fi

# Buat ~/.config jika belum ada
mkdir -p "$CONFIG_DIR"

# Daftar config yang akan di-symlink
configs=(hypr quickshell mako kitty rofi)

for cfg in "${configs[@]}"; do
    src="$DOTFILES_DIR/.config/$cfg"
    dst="$CONFIG_DIR/$cfg"

    # Cek apakah source ada
    if [ ! -d "$src" ]; then
        echo "SKIP: $src tidak ditemukan, melewati..."
        continue
    fi

    # Hapus symlink lama jika ada
    if [ -L "$dst" ]; then
        echo "Menghapus symlink lama: $dst"
        rm "$dst"
    # Backup folder asli jika bukan symlink
    elif [ -d "$dst" ]; then
        echo "Backup folder asli: $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi

    ln -sf "$src" "$dst"
    echo "Symlink dibuat: $dst -> $src"
done

echo "Semua symlink selesai dibuat."