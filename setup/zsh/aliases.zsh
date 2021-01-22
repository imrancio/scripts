##################
# Custom aliases #
##################

# pick text editor - nano, vim, subl, etc
editor=nano

# configs
alias bashrc='$editor ~/.bashrc'
alias bashreset='source ~/.bashrc'
alias zshrc='$editor ~/.zshrc'
alias zshreset='source ~/.zshrc'
alias ohmyzsh='cd ~/.oh-my-zsh'
alias setalias='$editor $ZSH_CUSTOM/aliases.zsh && source $ZSH_CUSTOM/aliases.zsh'
alias setfunc='$editor $ZSH_CUSTOM/functions.zsh && source $ZSH_CUSTOM/functions.zsh'
alias powerlevel9k='$editor $ZSH_CUSTOM/powerlevel9k.zsh && source $ZSH_CUSTOM/powerlevel9k.zsh'

# helpers and shorteners
alias mkdirp='mkdir -p' # make parent dirs as well (no errors)
alias rmrf='rm -rf' # recursive remove (directories)
alias cpr='cp -r' # recursive copy
alias py='python'
alias quit='exit'
alias q='exit'
alias hibernate='systemctl hibernate'
alias hd='hexdump'
alias ping4='ping -4'
alias ping6='ping -6'
alias ssh4='ssh -4'
alias ssh6='ssh -6'

# aircrack shortcuts
alias airmon='sudo airmon-ng'
alias aircrack='sudo aircrack-ng'
alias airodump='sudo airodump-ng'
alias aireplay='sudo aireplay-ng'

# personal pereferences
alias conkyrc='$editor ~/.conky/Conky-Skeleton/conkyrc.lua'
alias yaourt='yay' # deprecated - use yay instead (same flags)
alias yay='yay -a' # yay only for AUR, pacman for everything else
alias fetch='neofetch'
alias devenv='deactivate'
alias abyss-web='~/src/abyss/abyss-web'
alias abyss-extract='~/src/abyss/abyss-extract'
alias mongo-start='systemctl start mongodb'
alias mongo-stop='systemctl stop mongodb'
alias mongo-status='systemctl status mongodb'
