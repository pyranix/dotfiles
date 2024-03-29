#!/bin/bash

## Arch Packages ------------------------------
packages=(
  # General
  alsa-utils
  amd-ucode
  arch-install-scripts
  archinstall
  b43-fwcutter
  base
  bind
  brltty
  broadcom-wl
  btrfs-progs
  clonezilla
  cloud-init
  cryptsetup
  darkhttpd
  ddrescue
  dhclient
  dhcpcd
  diffutils
  dmidecode
  dmraid
  dnsmasq
  dosfstools
  e2fsprogs
  edk2-shell
  efibootmgr
  ethtool
  exfatprogs
  f2fs-tools
  fatresize
  foot-terminfo
  fsarchiver
  gnu-netcat
  gpart
  gpm
  gptfdisk
  hdparm
  hyperv
  intel-ucode
  irssi
  iw
  iwd
  jfsutils
  kitty-terminfo
  less
  lftp
  libfido2
  libusb-compat
  linux
  linux-atm
  linux-firmware
  linux-firmware-marvell
  lsscsi
  lvm2
  lynx
  man-db
  man-pages
  mc
  mdadm
  mkinitcpio
  mkinitcpio-archiso
  mkinitcpio-nfs-utils
  modemmanager
  mtools
  nano
  nbd
  ndisc6
  nfs-utils
  nilfs-utils
  nmap
  ntfs-3g
  nvme-cli
  open-iscsi
  open-vm-tools
  openconnect
  openssh
  openvpn
  partclone
  parted
  partimage
  pcsclite
  ppp
  pptpclient
  pv
  refind
  reflector
  reiserfsprogs
  rp-pppoe
  rsync
  rxvt-unicode-terminfo
  screen
  sdparm
  sg3_utils
  smartmontools
  sof-firmware
  squashfs-tools
  sudo
  syslinux
  systemd-resolvconf
  tcpdump
  terminus-font
  testdisk
  tmux
  tpm2-tss
  udftools
  usb_modeswitch
  usbmuxd
  usbutils
  vim
  vpnc
  wezterm-terminfo
  wireless-regdb
  wireless_tools
  wpa_supplicant
  wvdial
  xfsprogs
  xl2tpd
  zsh

  # Bootloader
  os-prober
  lsb-release

  # Xorg Server
  xorg

  # Touchpad and Mouse
  xorg-xinput
  xf86-input-libinput

  # GPU Drivers (Intel/AMD/VM)
  xf86-video-fbdev
  xf86-video-vesa
  xf86-video-intel
  xf86-video-amdgpu
  xf86-video-ati
  mesa
  mesa-utils

  # GPU Drivers (Nvidia)
  xf86-video-nouveau
  nvidia
  nvidia-utils
  nvidia-settings

  # Hypervisors
  virtualbox-guest-utils
  qemu-guest-agent
  open-vm-tools
  xf86-input-vmmouse
  xf86-video-vmware

  # System
  # ... (no specific packages listed)

  # Networking
  networkmanager
  networkmanager-openconnect
  networkmanager-openvpn
  networkmanager-pptp
  networkmanager-strongswan
  networkmanager-vpnc
  network-manager-sstp
  nm-connection-editor
  network-manager-applet

  # Bluetooth
  bluez
  bluez-utils
  blueman

  # Audio
  pipewire
  wireplumber
  pipewire-alsa
  pipewire-pulse
  pipewire-jack
  pulsemixer
  pavucontrol
  gst-plugin-pipewire

  # Video
  libde265
  libdv
  libmpeg2
  schroedinger
  libtheora
  libvpx
  x264
  x265
  xvidcore
  gstreamer
  ffmpeg
  gst-libav
  gst-plugins-good
  gst-plugins-ugly
  gst-plugins-bad

  # Print
  cups
  cups-pdf
  cups-filters
  ghostscript
  gsfonts
  foomatic-db-engine
  foomatic-db
  gutenprint

  # QT Style
  kvantum
  qt5ct

  # Display Manager
  sddm-git

  # Desktop
  # Terminal
  alacritty
  xfce4-terminal

  # Apps
  firefox
  geany
  geany-plugins
  thunar
  thunar-archive-plugin
  thunar-media-tags-plugin
  thunar-volman
  viewnior
  atril

  # Media
  mpc
  mpd
  ncmpcpp
  mplayer

  # Utilities
  acpi
  dialog
  dunst
  galculator
  gparted
  gtk-engine-murrine
  gnome-keyring
  inetutils
  inotify-tools
  jq
  light
  meld
  nitrogen
  pastel
  picom
  plank
  polkit
  polybar
  python-pywal
  rofi
  maim
  simplescreenrecorder
  slop
  udisks2
  wmctrl
  wmname
  xclip
  xcolor
  xdotool
  xfce4-power-manager
  xfce4-settings
  xmlstarlet
  xsettingsd
  yad

  # Functionality
  # Fonts
  noto-fonts
  noto-fonts-emoji
  noto-fonts-cjk
  terminus-font

  # Multimedia
  ffmpeg
  ffmpegthumbnailer
  tumbler

  # Images
  jasper
  libwebp
  libavif
  libheif

  # Files
  gvfs
  gvfs-mtp
  gvfs-afc
  gvfs-gphoto2
  gvfs-smb
  gvfs-google
  highlight
  trash-cli
  ueberzug
  xdg-user-dirs
  xdg-user-dirs-gtk

  # Archives
  bzip2
  gzip
  lrzip
  lz4
  lzip
  lzop
  xz
  zstd
  p7zip
  zip
  unzip
  unrar
  unarchiver
  xarchiver

  # Misc
  # Package Tools
  bison
  fakeroot
  flex
  make
  automake
  autoconf
  pkgconf
  patch
  gcc

  # CLI Tools
  htop
  nethogs
  ncdu
  powertop
  ranger
  vim

  # AUR Packages
  timeshift
)

## Print the unique package names
sudo pacman -S --noconfirm "${packages[@]}"

## EOF ------------------------------
