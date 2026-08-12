#!/usr/bin/env bash

set -e

# ==========================================
# Shell Setup - Arch Linux
# ==========================================

# El script debe ejecutarse como root mediante sudo.
if [[ "$EUID" -ne 0 ]]; then
    echo "Este script debe ejecutarse con sudo."
    echo
    echo "Uso:"
    echo "  sudo ./install.sh"
    exit 1
fi

# Usuario que ejecutó sudo.
if [[ -z "$SUDO_USER" || "$SUDO_USER" == "root" ]]; then
    echo "No se pudo determinar el usuario que ejecutó sudo."
    echo "Ejecuta el script desde un usuario normal usando sudo."
    exit 1
fi

USER_NAME="$SUDO_USER"

echo "=========================================="
echo "          Shell Setup - Arch Linux"
echo "=========================================="
echo
echo "Usuario: $USER_NAME"
echo

# Comprobar Arch Linux.
if [[ ! -f /etc/arch-release ]]; then
    echo "Error: este script está diseñado para Arch Linux."
    exit 1
fi

echo "✓ Arch Linux detectado."
echo

# ==========================================
# Paquetes
# ==========================================

PACKAGES=(
    zsh
    eza
    bat
    btop
    fzf
    fd
    ripgrep
    lazygit
    fastfetch
    ttf-jetbrains-mono-nerd
)

echo "Se instalarán/verificarán estos paquetes:"
echo

printf '  • %s\n' "${PACKAGES[@]}"

echo
read -rp "¿Continuar? [Y/n] " ANSWER

if [[ "$ANSWER" =~ ^[Nn]$ ]]; then
    echo "Cancelado."
    exit 0
fi

echo
echo "Instalando paquetes..."
echo

pacman -S --needed "${PACKAGES[@]}"

echo
echo "=========================================="
echo "       Instalación completada"
echo "=========================================="
echo
echo "Paquetes instalados/verificados correctamente."
echo
echo "Usuario configurado: $USER_NAME"