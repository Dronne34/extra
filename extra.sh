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

# Specify the path to the file containing package names
package_file="${PWD%/}/pklist"

# Check if the package list file exists
if [ ! -f "$package_file" ]; then
    echo "Package list file not found: $package_file"
    exit 1
fi

# Read package names from the file into an array
mapfile -t packages < "$package_file"

# Loop through each package
for package in "${packages[@]}"; do
    # Trim leading and trailing whitespaces
    package="$(echo "$package" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

    # Check if the package is already installed
    if pacman -Qqe "$package" &> /dev/null; then
        echo "$package is already installed. Skipping..."
    else
        # Install the package if not installed
        echo "Installing $package..."
        sudo pacman -S --color always --logfile log.txt --needed "$package"
    fi
done

echo "Package installation complete."
