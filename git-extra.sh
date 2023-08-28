#!/usr/bin/env bash

#Configuration files
git clone https://github.com/Dronne34/config
cd config 

source=(
alacritty cava dconf dunst 
fontconfig gtk-2.0 gtk-3.0 htop mpd 
mpv ncmpcpp nitrogen picom ranger 
screen sxhkd systemd Thunar trizen 
xfce4 yt-dlp ytfzf mimeapps.list  
up.sh user-dirs.dirs user-dirs.locale
)

cp -rf $source ~/.config
cd
rm -rf config

#Home directory
git clone https://github.com/Dronne34/home
cd home 

source=(
.local .vim .bash_alias .bash_logout 
.bash_profile .bashrc .fontscripts 
.fzf.bash .fzf.zsh .gtkrc-2.0 .nanorc 
.viminfo .vimrc .xinitrc .Xresources
)

cp -rf $source ~/
cd
rm -rf home