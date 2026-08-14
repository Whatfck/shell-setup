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
        curl
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
        curl
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
# Instalar Oh My Zsh
# ==========================================

USER_HOME=$(eval echo "~$USER_NAME")

echo
echo "Configurando Oh My Zsh..."
echo

if [[ ! -d "$USER_HOME/.oh-my-zsh" ]]; then
    sudo -u "$USER_NAME" sh -c \
        'RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
    
    echo "✓ Oh My Zsh instalado."
else
    echo "✓ Oh My Zsh ya está instalado."
fi

# ==========================================
# Directorios personalizados de Oh My Zsh
# ==========================================

ZSH_CUSTOM="$USER_HOME/.oh-my-zsh/custom"

mkdir -p "$ZSH_CUSTOM/plugins"

# ==========================================
# Powerlevel10k
# ==========================================

echo
echo "Configurando Powerlevel10k..."
echo

if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
    sudo -u "$USER_NAME" git clone --depth=1 \
        https://github.com/romkatv/powerlevel10k.git \
        "$ZSH_CUSTOM/themes/powerlevel10k"

    echo "✓ Powerlevel10k instalado."
else
    echo "✓ Powerlevel10k ya está instalado."
fi

# ==========================================
# zsh-autosuggestions
# ==========================================

echo
echo "Configurando zsh-autosuggestions..."
echo

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    sudo -u "$USER_NAME" git clone --depth=1 \
        https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

    echo "✓ zsh-autosuggestions instalado."
else
    echo "✓ zsh-autosuggestions ya está instalado."
fi

# ==========================================
# zsh-syntax-highlighting
# ==========================================

echo
echo "Configurando zsh-syntax-highlighting..."
echo

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    sudo -u "$USER_NAME" git clone --depth=1 \
        https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

    echo "✓ zsh-syntax-highlighting instalado."
else
    echo "✓ zsh-syntax-highlighting ya está instalado."
fi

# ==========================================
# Permisos
# ==========================================

chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/.oh-my-zsh"

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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

echo
echo "Configurando dotfiles..."
echo

# Backup de configuración existente
if [[ -f "$USER_HOME/.zshrc" ]]; then
    cp "$USER_HOME/.zshrc" "$USER_HOME/.zshrc.backup"
    chown "$USER_NAME:$USER_NAME" "$USER_HOME/.zshrc.backup"

    echo "✓ Backup de .zshrc creado."
fi

if [[ -f "$USER_HOME/.p10k.zsh" ]]; then
    cp "$USER_HOME/.p10k.zsh" "$USER_HOME/.p10k.zsh.backup"
    chown "$USER_NAME:$USER_NAME" "$USER_HOME/.p10k.zsh.backup"

    echo "✓ Backup de .p10k.zsh creado."
fi

# .zshrc
if [[ -f "$DOTFILES_DIR/.zshrc" ]]; then
    cp "$DOTFILES_DIR/.zshrc" "$USER_HOME/.zshrc"
    chown "$USER_NAME:$USER_NAME" "$USER_HOME/.zshrc"

    echo "✓ .zshrc instalado."
else
    echo "⚠ No se encontró dotfiles/.zshrc"
fi

# .p10k.zsh
if [[ -f "$DOTFILES_DIR/.p10k.zsh" ]]; then
    cp "$DOTFILES_DIR/.p10k.zsh" "$USER_HOME/.p10k.zsh"
    chown "$USER_NAME:$USER_NAME" "$USER_HOME/.p10k.zsh"

    echo "✓ .p10k.zsh instalado."
else
    echo "⚠ No se encontró dotfiles/.p10k.zsh"
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