# Shell Setup

Script personal para preparar mi entorno de terminal en **Arch Linux**.

La idea de este proyecto es automatizar la instalación de las herramientas de consola que utilizo habitualmente y, posteriormente, añadir la configuración de mi shell y mis dotfiles.

## Estado

🚧 **En desarrollo**

Actualmente, el script instala las herramientas principales de mi entorno de terminal.

La configuración de Zsh y los dotfiles se añadirán en futuras versiones.

## Requisitos

* Arch Linux
* Un usuario normal con permisos de `sudo`
* Conexión a Internet
* Git

## Instalación

Clona el repositorio:

```bash
git clone <REPOSITORY_URL>
cd shell-setup
```

Después ejecuta el instalador con `sudo`:

```bash
sudo ./install.sh
```

El script detectará el usuario que ejecutó `sudo` y realizará la instalación mediante `pacman`.

## Herramientas instaladas

Actualmente se instalan:

* **Zsh** — shell
* **eza** — alternativa moderna a `ls`
* **bat** — alternativa a `cat`
* **btop** — monitor de recursos
* **fzf** — buscador interactivo
* **fd** — alternativa a `find`
* **ripgrep** — búsqueda rápida de texto
* **lazygit** — interfaz de terminal para Git
* **fastfetch** — información del sistema
* **JetBrains Mono Nerd Font** — fuente con iconos para terminales

## Próximamente

El proyecto irá incorporando progresivamente:

* Configuración de Zsh
* Powerlevel10k
* Oh My Zsh
* Plugins de Zsh
* Aliases personales
* Dotfiles
* Configuración específica para macOS
* Soporte para otras distribuciones Linux

## Nota

Este proyecto está pensado principalmente para mi propio entorno de trabajo. Las herramientas y configuraciones pueden cambiar a medida que evolucione mi flujo de trabajo.
