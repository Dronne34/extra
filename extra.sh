#!/usr/bin/env bash
echo  
tput setaf 3
echo "List of packages to install" & sleep 1
tput sgr0
echo
packages=(
accountsservice
adobe-source-han-sans-cn-fonts
adobe-source-han-sans-jp-fonts
adobe-source-han-sans-kr-fonts
adobe-source-sans-fonts
alacritty
alsa-firmware
alsa-plugins
alsa-utils
arc-gtk-theme
arch-install-scripts
bash-completion
bat
bind
bleachbit
bluez
bluez-libs
bluez-utils
broadcom-wl-dkms
btrfs-progs
clonezilla
cups
cups-filters
cups-pdf
dconf-editor
ddrescue
dhclient
dialog
dmidecode
dmraid
dnsmasq
dosfstools
duf
dunst
efibootmgr
ethtool
exfatprogs
expac
f2fs-tools
fatresize
feh
ffmpegthumbnailer
file-roller
firefox
fsarchiver
fzf
garcon
ghostscript
git
gnome-keyring
gnome-system-monitor
gnu-netcat
grub
gsfonts
gsimplecal
gst-libav
gst-plugins-bad
gst-plugins-base
gst-plugins-good
gst-plugins-ugly
gstreamer
gutenprint
gvfs
gvfs-afc
gvfs-gphoto2
gvfs-mtp
gvfs-nfs
gvfs-smb
hdparm
hwinfo
hyperv
imagemagick
iniparser
intel-media-driver
intel-ucode
inxi
irssi
iw
iwd
jfsutils
kvantum
kvantum-theme-materia
laptop-detect
libdvdcss
libfido2
libgsf
libopenraw
libpwquality
libusb-compat
libva-intel-driver
libva-mesa-driver
logrotate
lsb-release
lsd
lsscsi
lvm2
lxappearance
lynx
man-db
man-pages
mc
meld
mesa
mkinitcpio-nfs-utils
mlocate
mobile-broadband-provider-info
modemmanager
mpc
mpd
mpv
mtools
mtpfs
nano
nano-syntax-highlighting
nbd
ncmpcpp
ndisc6
nfs-utils
nilfs-utils
nitrogen
noto-fonts
nss-mdns
ntfs-3g
ntp
numlockx
nvme-cli
openconnect
open-iscsi
openresolv
openvpn
os-prober
p7zip
pamixer
partimage
pavucontrol
pcsclite
picom
pipewire-alsa
pipewire-docs
pipewire-pulse
polkit-gnome
poppler-glib
poppler-qt5
ppp
pptpclient
pv
python-pipx
python-pyparted
qt5ct
refind
reflector
reiserfsprogs
ripgrep
ristretto
rofi
rp-pppoe
rsync
rxvt-unicode
rxvt-unicode-terminfo
screen
scrot
sdparm
sg3_utils
slop
smartmontools
sof-firmware
squashfs-tools
streamlink
sxhkd
sxiv
syslinux
system-config-printer
tcpdump
terminus-font
testdisk
the_silver_searcher
thunar
thunar-archive-plugin
thunar-media-tags-plugin
thunar-volman
tlp
ttf-dejavu
ttf-font-awesome
ttf-hack
ttf-mononoki-nerd
ttf-roboto
ttf-roboto-mono
ttf-ubuntu-font-family
tumbler
udftools
udiskie
ueberzug
unace
unrar
upower
urxvt-perls
usb_modeswitch
usbmuxd
usbutils
variety
vim
vpnc
vulkan-intel
vulkan-radeon
w3m
webkit2gtk
wget
wireless-regdb
wireless_tools
wireplumber
wmctrl
wpa_supplicant
wvdial
xapp
xclip
xdg-desktop-portal-gtk
xdg-user-dirs
xdg-utils
xf86-input-elographics
xf86-video-amdgpu
xf86-video-ati
xf86-video-intel
xf86-video-nouveau
xf86-video-vmware
xfce4-taskmanager
xorg-bdftopcf
xorg-iceauth
xorg-mkfontscale
xorg-server
xorg-sessreg
xorg-smproxy
xorg-x11perf
xorg-xbacklight
xorg-xcmsdb
xorg-xcursorgen
xorg-xdpyinfo
xorg-xdriinfo
xorg-xev
xorg-xgamma
xorg-xhost
xorg-xinit
xorg-xinput
xorg-xkbevd
xorg-xkbprint
xorg-xkbutils
xorg-xkill
xorg-xlsatoms
xorg-xlsclients
xorg-xpr
xorg-xrandr
xorg-xrefresh
xorg-xsetroot
xorg-xvinfo
xorg-xwd
xorg-xwininfo
xorg-xwud
xterm
yad
yt-dlp
ytfzf
zenity
zsh
zsh-completions
zsh-syntax-highlighting


)

RED='\033[0;31m'
GREEN='\033[0;32m'
TODAY=$(date)
# tput setaf 0 = black
# tput setaf 1 = red
# tput setaf 2 = green
# tput setaf 3 = yellow
# tput setaf 4 = dark blue
# tput setaf 5 = purple
# tput setaf 6 = cyan
# tput setaf 7 = gray
# tput setaf 8 = light blue

# Loop through the package list and install if not already installed
for package in "${packages[@]}"; do
    if ! pacman -Q "$package" &>/dev/null; then
        echo -e "Installing $package..."
        sudo pacman -S --noconfirm "$package"
    else
        echo -e "$package is already installed. Skipping."
    fi
done


# Update the package database and install the packages
# sudo pacman -Syu --noconfirm
# sudo pacman -S --noconfirm "${packages[@]}"
# echo  "Packages install done"  & sleep 1

# Install trizen
# echo  -e "$GREEN Clone trizen for install \n"  & sleep 1
# echo  -e "$RED Remove older folder \n"  & sleep 1
# rm -rf trizen
# git clone https://aur.archlinux.org/trizen.git
# cd trizen
# makepkg -fsi --noconfirm
# cd
# echo  -e "$GREEN Trizen done"

#Install from AUR
echo -e "$GREEN Install from AUR"  & sleep 1
pkaur=(
brave-bin
downgrade
pulseaudio-nextsink
reddio
sublime-text-4
)
#AUR Loop through the package list and install if not already installed
for package in "${pkaur[@]}"; do
    if ! pacman -Qm "$package" &>/dev/null; then
        echo -e "Installing $package..."
        trizen -S --noconfirm "$package"
    else
        echo -e "$package --> From AUR is already installed. Skipping."
    fi
done

echo -e "$GREEN Install from AUR done" & sleep 1
