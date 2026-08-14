# ==========================================
# Shell Setup
# ==========================================

# ==========================================
# Powerlevel10k instant prompt
# ==========================================

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ==========================================
# Oh My Zsh
# ==========================================

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Cargar Oh My Zsh solamente si está instalado.
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
    source "$ZSH/oh-my-zsh.sh"
fi


# ==========================================
# Aliases
# ==========================================

# Navegación

alias ..='cd ..'
alias ...='cd ../..'


# Terminal

alias c='clear'


# Listado de archivos

if command -v eza >/dev/null 2>&1; then
    alias ll='eza -lah --icons'
    alias la='eza -A --icons'
    alias l='eza -CF --icons'
    alias ls='eza --icons'
    alias lt='eza --tree --icons'
fi


# ==========================================
# Git
# ==========================================

if command -v git >/dev/null 2>&1; then
    alias gs='git status'
    alias gp='git pull'
    alias ga.='git add .'
fi


# ==========================================
# Herramientas
# ==========================================

# Fastfetch

if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi


# ==========================================
# Editor
# ==========================================

if command -v micro >/dev/null 2>&1; then
    export EDITOR='micro'
    export VISUAL='micro'
fi


# ==========================================
# Powerlevel10k
# ==========================================

if [[ -f "$HOME/.p10k.zsh" ]]; then
    source "$HOME/.p10k.zsh"
fi