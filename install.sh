#!/usr/bin/env bash

set -e

# ==========================================
# Shell Setup
# Arch Linux / Ubuntu
# ==========================================

# ==========================================
# Comprobar sudo
# ==========================================

if [[ "$EUID" -ne 0 ]]; then
    echo "Este script debe ejecutarse con sudo."
    echo
    echo "Uso:"
    echo "  sudo ./install.sh"
    exit 1
fi

# ==========================================
# Detectar usuario
# ==========================================

if [[ -z "$SUDO_USER" || "$SUDO_USER" == "root" ]]; then
    echo "No se pudo determinar el usuario que ejecutó sudo."
    echo "Ejecuta el script desde un usuario normal usando sudo."
    exit 1
fi

USER_NAME="$SUDO_USER"

# ==========================================
# Detectar distribución
# ==========================================

if [[ ! -f /etc/os-release ]]; then
    echo "No se pudo determinar la distribución."
    exit 1
fi

source /etc/os-release

case "$ID" in
    arch)
        DISTRO="Arch Linux"
        PACKAGE_MANAGER="pacman"
        ;;

    ubuntu)
        DISTRO="Ubuntu"
        PACKAGE_MANAGER="apt"
        ;;

    *)
        echo "Distribución no soportada: $ID"
        echo
        echo "Actualmente Shell Setup soporta:"
        echo "  - Arch Linux"
        echo "  - Ubuntu"
        exit 1
        ;;
esac

# ==========================================
# Encabezado
# ==========================================

echo "=========================================="
echo "             Shell Setup"
echo "=========================================="
echo
echo "Sistema:  $DISTRO"
echo "Usuario:  $USER_NAME"
echo "Gestor:   $PACKAGE_MANAGER"
echo

# ==========================================
# Definir paquetes
# ==========================================

if [[ "$ID" == "arch" ]]; then

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

elif [[ "$ID" == "ubuntu" ]]; then

    PACKAGES=(
        zsh
        eza
        bat
        btop
        fzf
        fd-find
        ripgrep
        lazygit
        fastfetch
        fonts-jetbrains-mono
    )

fi

# ==========================================
# Mostrar paquetes
# ==========================================

echo "Se instalarán/verificarán estos paquetes:"
echo

printf '  • %s\n' "${PACKAGES[@]}"

echo
read -rp "¿Continuar? [Y/n] " ANSWER

if [[ "$ANSWER" =~ ^[Nn]$ ]]; then
    echo "Cancelado."
    exit 0
fi

# ==========================================
# Instalar paquetes
# ==========================================

echo
echo "Instalando paquetes..."
echo

if [[ "$ID" == "arch" ]]; then

    pacman -S --needed "${PACKAGES[@]}"

elif [[ "$ID" == "ubuntu" ]]; then

    apt update
    apt install -y "${PACKAGES[@]}"

fi

# ==========================================
# Configurar Zsh como shell predeterminado
# ==========================================

ZSH_PATH="$(command -v zsh)"

if [[ -z "$ZSH_PATH" ]]; then
    echo "Error: no se encontró Zsh después de la instalación."
    exit 1
fi

echo
echo "Configurando Zsh como shell predeterminado..."

chsh -s "$ZSH_PATH" "$USER_NAME"

echo "✓ Zsh configurado como shell predeterminado para $USER_NAME."

# ==========================================
# Instalar dotfiles
# ==========================================

DOTFILES_DIR="$(dirname "$(realpath "$0")")/dotfiles"
USER_HOME="$(eval echo "~$USER_NAME")"

if [[ -f "$DOTFILES_DIR/.zshrc" ]]; then

    echo
    echo "Instalando configuración de Zsh..."

    cp "$DOTFILES_DIR/.zshrc" "$USER_HOME/.zshrc"

    chown "$USER_NAME:$USER_NAME" "$USER_HOME/.zshrc"

    echo "✓ .zshrc instalado correctamente."

else

    echo
    echo "⚠ No se encontró dotfiles/.zshrc."
fi

# ==========================================
# Resultado
# ==========================================

echo
echo "=========================================="
echo "       Instalación completada"
echo "=========================================="
echo
echo "Paquetes instalados/verificados correctamente."
echo
echo "Sistema:  $DISTRO"
echo "Usuario:  $USER_NAME"
echo "Shell:    $ZSH_PATH"
echo