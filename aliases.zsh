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
alias setalias='$editor $ZSH_CUSTOM/aliases.zsh'
alias setfunc='$editor $ZSH_CUSTOM/functions.zsh'
alias powerlevel9k='$editor $ZSH_CUSTOM/powerlevel9k.zsh'

# helpers and shorteners
alias mkdir='mkdir -p' # make parent dirs as well (no errors)
alias rm='rm -r' # recursive remove (directories)
alias py='python'
alias c='clear'
alias cl='clear'
alias quit='exit'
alias q='exit'
alias hibernate='systemctl hibernate'
alias hd='hexdump'

# personal pereferences
# alias yaourt='yay' # deprecated - use yay instead (same flags)
# alias yay='yay -a' # yay only for AUR, pacman for everything else
# alias fetch='neofetch'