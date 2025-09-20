#!/bin/bash

# Script pentru verificarea pachetelor din pklist.txt în repository-urile Arch Linux
# Folosește pacman -Si pentru a verifica dacă pachetul există în repo-uri

echo "=== Verificare pachete din pklist.txt ==="
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
    
    # Verifică dacă pachetul există în repo-uri
    if pacman -Si "$package" &>/dev/null; then
        echo "$package" >> "$VALID_PACKAGES"
        valid_count=$((valid_count + 1))
        echo "✓ $package"
    else
        echo "$package" >> "$INVALID_PACKAGES"
        invalid_count=$((invalid_count + 1))
        echo "✗ $package"
    fi
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
    echo "=== SUGESTII ==="
    echo "Verificați dacă pachetele nevalide au fost:"
    echo "1. Redenumite în repository-uri"
    echo "2. Mutate în AUR"
    echo "3. Eliminate complet"
    echo "4. Înlocuite cu alte pachete"
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