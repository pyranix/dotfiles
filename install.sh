#!/bin/bash

# Script to setup system configurations and install packages based on Linux distribution

set -euo pipefail

# Configuration
readonly GTK2_SYSTEM_WIDE="/etc/gtk-2.0"
readonly GTK3_SYSTEM_WIDE="/etc/gtk-3.0"
readonly REPOSITORY="https://github.com/pyranix/dotfiles"
readonly DESTINATION="$HOME/dotfiles"

# Array of packages for Void Linux
void_packages=(
    xclip powertop xfce4-notifyd pulseaudio bluez blueman rofi pamixer
    NetworkManager alacritty git curl neovim xfce4-settings qtile xorg-minimal
    xorg-input-drivers xorg-fonts xorg-video-drivers xorg-server xsettingsd
    dconf-editor dconf rsync wget aria2 dunst python3 feh gtk+ gtk+3 gtk4
    nano xinit xsetroot dbus elogind gcc gcc-multilib thunar-volman
    thunar-archive-plugin thunar-media-tags-plugin pipewire pavucontrol
    starship psutils acpi acpica-utils acpid dhcpcd-gtk ImageMagick pfetch
    htop exa openssh openssl xdg-user-dirs xdg-user-dirs-gtk picom gnupg2
    mpv nwg-launchers nwg-look linux-firmware-intel intel-gmmlib
    intel-gpu-tools intel-media-driver intel-ucode intel-video-accel
    vulkan-loader android-file-transfer-linux android-tools android-udev-rules
    libvirt libvirt-glib libvirt-python3 gvfs udiskie udisks2 brightnessctl
    xdotool apparmor libselinux rpm rpmextract lxappearance lxappearance-obconf
    xfce4-power-manager xfce-polkit polkit-elogind maim viewnior nodeenv
    nodejs xdg-desktop-portal xdg-desktop-portal-kde xdg-desktop-portal-wlr
    xdg-desktop-portal-gnome xdg-desktop-portal-gtk zip unzip tar 7zip bzip2
    zstd lz4 xz libXft-devel libXinerama-devel make virt-manager fish-shell
    pasystray network-manager-applet
)

# Array of packages for Arch Linux
arch_packages=(
    plymouth schedtool modprobe-db update-grub xclip powertop libnotify
    xfce4-notifyd bluez bluez-plugins bluez-cups cups blueman rofi
    networkmanager alacritty git curl neovim xfce4-settings qtile xorg-xinput
    xorg-drivers xorg-fonts xorg-xvidtune xorg-server xsettingsd dconf
    dconf-editor rsync wget aria2 dunst python feh gtk3 gtk4 gtk2 nano
    xorg-xinit xorg-xsetroot gcc thunar thunar-archive-plugin
    thunar-media-tags-plugin thunar-volman pavucontrol psutils python-psutil
    acpi acpica acpid imagemagick htop exa fzf expac openssh openssl
    xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
    xdg-desktop-portal-xapp xdg-user-dirs xdg-user-dirs-gtk xdg-utils picom
    gnupg mpv linux-firmware intel-media-driver intel-gmmlib intel-gpu-tools
    intel-ucode intel-media-sdk xf86-input-libinput xf86-input-synaptics
    xf86-video-intel xf86-video-fbdev xf86-video-vesa xf86-input-evdev
    vulkan-intel vulkan-icd-loader vulkan-mesa-layers vulkan-tools
    vulkan-utility-libraries vulkan-virtio vulkan-validation-layers
    lib32-vulkan-icd-loader lib32-vulkan-intel lib32-vulkan-mesa-layers
    lib32-vulkan-validation-layers lib32-vulkan-virtio android-file-transfer
    android-tools android-udev gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2
    gvfs-mtp gvfs-nfs gvfs-smb udiskie udisks2 brightnessctl polkit xdotool
    apparmor lxappearance lxappearance-obconf xfce4-power-manager maim
    viewnior nodejs gedit gedit-plugins zip unzip tar p7zip unrar bzip2
    zstd lz4 xz libxft libxinerama make cmake fish pasystray
    network-manager-applet gamescope gamemode jq
)

# Function to check if a command exists
command_exists() {
    command -v "$1" &>/dev/null
}

# Function to install yay if not already installed
install_yay() {
    if ! command_exists yay; then
        echo "[ INFO ] Yay not found, installing yay..."
        temp_dir=$(mktemp -d)
        git clone https://aur.archlinux.org/yay-bin.git "$temp_dir"
        cd "$temp_dir"
        makepkg -si --noconfirm
        cd -
        rm -rf "$temp_dir"
        echo "[ INFO ] Yay installed successfully."
    else
        echo "[ INFO ] Yay is already installed."
    fi
}

# Function to determine distribution and install packages
install_packages() {
    if command_exists xbps-install; then
        echo "[ INFO ] Installing packages for Void Linux..."
        sudo xbps-install -Sy void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree
        sudo xbps-install -Sy "${void_packages[@]}"
        echo "[ INFO ] Packages installed successfully on Void Linux."
    elif command_exists pacman; then
        install_yay
        echo "[ INFO ] Installing packages for Arch Linux..."
        yay -S --noconfirm "${arch_packages[@]}"
        echo "[ INFO ] Packages installed successfully on Arch Linux."
    else
        echo "[ INFO ] Package installation not supported on this distribution."
        exit 1
    fi
}

# Function to clone repository if not already present
clone_repository() {
    if [ ! -d "$DESTINATION" ]; then
        echo "[ INFO ] Cloning repository..."
        if git clone "$REPOSITORY" "$DESTINATION"; then
            echo "[ INFO ] Repository cloned successfully."
        else
            echo "[ INFO ] Failed to clone repository."
            exit 1
        fi
    else
        echo "[ INFO ] Repository already cloned. Skipping."
    fi
}

# Function to sync configuration files
sync_config_files() {
    echo "[ INFO ] Synchronizing configuration files..."
    rsync -a --exclude={".git*", "install.sh", "images", ".scripts*", "README.md"} "$DESTINATION/" "$HOME"
    echo "[ INFO ] Configuration files synchronized."
}

# Function to install Starship shell prompt
starship_shell_install() {
    echo "[ INFO ] Installing Starship shell prompt..."
    if command_exists xbps-install || command_exists pacman; then
        sudo xbps-install -Sy starship || yay -S --noconfirm starship
    else
        curl -fsSL https://starship.rs/install.sh | sh
    fi
    echo "[ INFO ] Starship installed successfully."
}

# Function to change font across all XFCE components
change_font_all_xfce() {
    echo "[ INFO ] Setting XFCE font..."
    fc-cache -f
    if fc-list | grep -iq "JetBrainsMono Nerd Font"; then
        xfconf-query -c xsettings -p /Gtk/FontName -s "JetBrainsMono Nerd Font 11"
        xfconf-query -c xfwm4 -p /general/title_font -s "JetBrainsMono Nerd Font Bold 11"
        xfconf-query -c xsettings -p /Xft/DPI -s "96"
        echo "[ INFO ] Font has been set to JetBrainsMono Nerd Font."
    else
        echo "[ INFO ] JetBrainsMono Nerd Font not found. Please install it first."
        exit 1
    fi
}

# Function for additional configurations
additional_configuration() {
    echo "[ INFO ] Applying additional configurations..."
    sudo cp -r "$DESTINATION/.icons/"* /usr/share/icons/
    sudo cp -r "$DESTINATION/.themes/"* /usr/share/themes/
    sudo cp -r "$DESTINATION/.fonts/"* /usr/share/fonts/

    sudo cp "$DESTINATION/.config/gtk-3.0/settings.ini" "$GTK3_SYSTEM_WIDE/"
    sudo cp "$DESTINATION/.gtkrc-2.0" "$GTK2_SYSTEM_WIDE/"

    xdg-user-dirs-update
    xdg-user-dirs-gtk-update
    echo "[ INFO ] Additional configurations applied."
}

# Main execution
install_packages
clone_repository
sync_config_files
starship_shell_install
change_font_all_xfce
additional_configuration

echo "[ INFO ] Configuration setup completed."
