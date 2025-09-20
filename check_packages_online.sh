#!/bin/bash

# Script pentru verificarea pachetelor din pklist.txt folosind API-ul Arch Linux
# Folosește archlinux.org package search API

echo "=== Verificare pachete din pklist.txt folosind API Arch Linux ==="
echo "Data: $(date)"
echo

# Fișierele de output
VALID_PACKAGES="valid_packages.txt"
INVALID_PACKAGES="invalid_packages.txt"
REPORT="package_verification_report.txt"

# Curăță fișierele de output
> "$VALID_PACKAGES"
> "$INVALID_PACKAGES"
> "$REPORT"

echo "Verificare pachete în curs..."

# Contoare
valid_count=0
invalid_count=0
total_count=0

# Verifică fiecare pachet din pklist.txt
while IFS= read -r package; do
    # Sări peste liniile goale
    [[ -z "$package" ]] && continue
    
    total_count=$((total_count + 1))
    
    # Verifică dacă pachetul există folosind API-ul Arch Linux
    # API endpoint: https://archlinux.org/packages/search/json/?name=PACKAGE_NAME
    response=$(curl -s "https://archlinux.org/packages/search/json/?name=${package}&exact" 2>/dev/null)
    
    if [[ -n "$response" ]] && echo "$response" | grep -q '"results":\[' && ! echo "$response" | grep -q '"results":\[\]'; then
        echo "$package" >> "$VALID_PACKAGES"
        valid_count=$((valid_count + 1))
        echo "✓ $package"
    else
        echo "$package" >> "$INVALID_PACKAGES"
        invalid_count=$((invalid_count + 1))
        echo "✗ $package"
    fi
    
    # Pauză mică pentru a nu overwhelm API-ul
    sleep 0.1
done < pklist.txt

# Generează raportul
{
    echo "=== RAPORT VERIFICARE PACHETE ARCH LINUX ==="
    echo "Data verificării: $(date)"
    echo "Total pachete verificate: $total_count"
    echo "Pachete valide: $valid_count"
    echo "Pachete nevalide: $invalid_count"
    echo "Rata de validitate: $(( (valid_count * 100) / total_count ))%"
    echo
    echo "=== PACHETE NEVALIDE ==="
    if [[ $invalid_count -gt 0 ]]; then
        cat "$INVALID_PACKAGES"
    else
        echo "Toate pachetele sunt valide!"
    fi
    echo
    echo "=== SUGESTII PENTRU PACHETE NEVALIDE ==="
    echo "Verificați dacă pachetele nevalide au fost:"
    echo "1. Redenumite în repository-uri"
    echo "2. Mutate în AUR (Arch User Repository)"
    echo "3. Eliminate complet"
    echo "4. Înlocuite cu alte pachete"
    echo "5. Scrise greșit în listă"
} > "$REPORT"

echo
echo "=== REZULTATE ==="
echo "Total pachete: $total_count"
echo "Pachete valide: $valid_count"
echo "Pachete nevalide: $invalid_count"
echo "Rata de validitate: $(( (valid_count * 100) / total_count ))%"
echo
echo "Raport salvat în: $REPORT"
echo "Pachete valide salvate în: $VALID_PACKAGES"
echo "Pachete nevalide salvate în: $INVALID_PACKAGES"