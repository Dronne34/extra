#!/bin/bash

# Define the list of packages to install
packages=($(<"${PWD%/}/pklist"))

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

