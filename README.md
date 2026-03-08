# dotfiles

Konfigurasi personal untuk setup Hyprland di Arch Linux.

## Komponen

| Komponen | Paket |
|---|---|
| Compositor | Hyprland |
| Terminal | Kitty |
| Shell | Zsh |
| Bar | Quickshell |
| Launcher | Rofi |
| Notifikasi | Mako |
| Wallpaper | swww |
| File Manager | Thunar |
| Browser | Google Chrome |
| Editor | Visual Studio Code |
| Notes | Obsidian |

## Instalasi

### 1. Clone repository

```bash
git clone https://github.com/username/dotfiles ~/dotfiles
```

### 2. Jalankan install script

```bash
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

Script akan otomatis:
- Menginstall semua dependensi yang dibutuhkan
- Mengaktifkan service yang diperlukan (Pipewire, Bluetooth, dll)
- Membuat symlink konfigurasi ke `~/.config`

> **Catatan:** Pastikan sudah login sebagai user biasa (bukan root) sebelum menjalankan script.

## Struktur

```
dotfiles/
└── .config/
    ├── hypr/
    ├── quickshell/
    ├── kitty/
    ├── mako/
    └── rofi/
```