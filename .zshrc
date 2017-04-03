# Zsh
ENABLE_CORRECTION="true"


# Exports
export BROWSER='/usr/bin/chromium'
export EDITOR='/usr/bin/vim'
export CHROMIUM_USER_FLAGS='--force-device-scale-factor=1.1'


# Aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ...=../..
alias ....=../../..
alias .....=../../../..
alias ......=../../../../..
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias _=sudo
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias g=git
alias l='ls -lahF --group-directories-first'
alias la='l'
alias ll='ls -lh'
alias ls='ls --color=auto'


# Zsh plugins
plugins='/usr/share/zsh/plugins'

source $plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Enable autocompletion
autoload -Uz compinit
compinit

# spelling correction for commands
setopt correct 


# Case insensitive autocompletion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# Search with 'Ctrl-r'
bindkey '^R' history-incremental-pattern-search-backward
