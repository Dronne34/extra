# #!/usr/bin/env bash
# pklist="${PWD%/}/pklist"
# for package in "${pklist[@]}"; do
#     if ! pacman -Qqe "$pklist" &>/dev/null; then
#         echo -e "Installing $package..."
#         sudo pacman -U --noconfirm "$pklist"
#     else
#         echo -e "$pklist --> From Core, Extra is already installed. Skipping."
#     fi
# done

#!/bin/bash

# Define the list of packages to install
packages=("${PWD%/}/pklist")

# Loop through each package
for package in "${packages[@]}"; do
    # Check if the package is already installed
    if pacman -Qi "$package" &> /dev/null; then
        echo "$package is already installed. Skipping..."
    else
        # Install the package if not installed
        echo "Installing $package..."
        sudo pacman -S "$package"
    fi
done

echo "Package installation complete."
