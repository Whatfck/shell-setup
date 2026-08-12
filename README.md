# Shell Setup

Script personal para preparar mi entorno de terminal en **Linux**.

La idea de este proyecto es automatizar la instalación de las herramientas de consola que utilizo habitualmente y, posteriormente, añadir la configuración de mi shell y mis dotfiles.

## Estado

🚧 **En desarrollo**

Actualmente, el script instala las herramientas principales de mi entorno de terminal y soporta:

* Arch Linux
* Ubuntu

La configuración de Zsh y los dotfiles se añadirán en futuras versiones.

## Requisitos

* Arch Linux o Ubuntu
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

El script detectará automáticamente la distribución Linux y utilizará el gestor de paquetes correspondiente.

Actualmente:

* **Arch Linux** → `pacman`
* **Ubuntu** → `apt`

El script también detectará el usuario que ejecutó `sudo`, por lo que la instalación está orientada al **usuario que ejecuta el script**, no a `root`.

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

Los nombres de los paquetes pueden variar dependiendo de la distribución. El script se encarga de utilizar el nombre correspondiente para cada sistema.

## Uso

El instalador está diseñado para ser ejecutado desde un usuario normal mediante `sudo`:

```bash
sudo ./install.sh
```

No está diseñado para ejecutarse directamente como `root`.

## Próximamente

El proyecto irá incorporando progresivamente:

* Configuración de Zsh
* Powerlevel10k
* Oh My Zsh
* Plugins de Zsh
* Aliases personales
* Dotfiles
* Soporte para macOS
* Soporte para Fedora y otras distribuciones Linux
* Detección y manejo de paquetes que no estén disponibles directamente en los repositorios de cada distribución

## Nota

Este proyecto está pensado principalmente para mi propio entorno de trabajo. Las herramientas y configuraciones pueden cambiar a medida que evolucione mi flujo de trabajo.
