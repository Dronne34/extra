#!/bin/bash

# Test script pentru primele 10 pachete
echo "=== Test verificare pachete ==="

packages=("accountsservice" "alacritty" "alsa-firmware" "alsa-plugins" "alsa-utils" "arc-gtk-theme" "arch-install-scripts" "arch-wiki-docs" "arc-icon-theme" "atool")

for package in "${packages[@]}"; do
    echo "Verificând: $package"
    response=$(curl -s "https://archlinux.org/packages/search/json/?name=${package}" 2>/dev/null)
    
    if [[ -n "$response" ]] && echo "$response" | grep -q "\"pkgname\": \"${package}\""; then
        echo "✓ $package - VALID"
    else
        echo "✗ $package - INVALID"
        # Debug: afișează primele caractere din response
        echo "  Response preview: $(echo "$response" | head -c 100)..."
    fi
    echo "---"
    sleep 0.2
done