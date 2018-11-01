# Scripts
This repo will hold any useful shell scripts to automate various setup and configuration processes.

## How to
```sh
git clone https://github.com/imrancio/scripts.git
cd scripts
bash setup/<script name>
```

### setup/manjaro_xfce.sh
Interactive shell script to set up and configure fresh Manjaro XFCE install. Broken down into optional stages:
* Installs core packages from Manjaro repo
* Installs additional packages from AUR (must be enabled in pamac)
* Sets up BlackArch repo/menus and installs some pentesting tools
* Fixes incorrect datetime issue arising from Linux/Windows dual-boot
* Sets up `oh-my-zsh` with `powerlevel9k` theme and custom plugins `zsh-autocomplete` & `zsh-autosuggestions`

All this can be configured of course depending on the use case, but should apply to anyone wanting a similar setup.
