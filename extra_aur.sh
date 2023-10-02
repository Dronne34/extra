#!/usr/bin/env bash
echo  
tput setaf 3
echo "Installing packages from pklist!" & sleep 1
tput sgr0
echo
#echo -e "\n"

BLUE='\033[38;5;4m'
RED='\033[0;31m'
GREEN='\033[0;32m'
# TODAY=$(date)
# tput setaf 0 = black
# tput setaf 1 = red
# tput setaf 2 = green
# tput setaf 3 = yellow
# tput setaf 4 = dark blue
# tput setaf 5 = purple
# tput setaf 6 = cyan
# tput setaf 7 = gray
# tput setaf 8 = light blue

# sudo pacman -S --needed - < pkglist.txt
echo  -e $GREEN"Installing packages done! \n"  & sleep 1


# Install trizen
 echo  -e $GREEN"Clone trizen for install! \n"  & sleep 1

 echo  -e $RED"Remove older folder! \n"  & sleep 1
 cd /tmp
 rm -rf trizen
 git clone https://aur.archlinux.org/trizen.git 
 cd /tmp/trizen
 makepkg -fsi --noconfirm
 rm -rf /tmp/trizen
 cd

 echo  -e $GREEN"Trizen done" & sleep 1

#Install from AUR
echo -e $RED"Install from AUR"  & sleep 1
pkaur=(
pulseaudio-nextsink
sublime-text-4
brave-bin
downgrade
reddio
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

echo -e $BLUE"Install from AUR done" & sleep 1

echo -e $BLUE"Git Clone oh-my-zsh and tool" & sleep 1

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Dronne34/config ~/.config
git clone https://github.com/Dronne34/.fonts
git clone https://github.com/Dronne34/home ~/.home
cp -arf ~/.home/. ~/ && rm -rf ~/.home
# sh papirus.sh
echo -e $BLUE"Install oh-my-zsh setup done!" & sleep 1