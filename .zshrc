# ZSH
ENABLE_CORRECTION="true"


# EXPORTS
export BROWSER='/usr/bin/chromium'
export EDITOR='/usr/bin/vim'


# ALIASES
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# alias -='cd -'
# alias ...=../..
# alias ....=../../..
# alias .....=../../../..
# alias ......=../../../../..
# alias 1='cd -'
# alias 2='cd -2'
# alias 3='cd -3'
# alias 4='cd -4'
# alias 5='cd -5'
# alias 6='cd -6'
# alias 7='cd -7'
# alias 8='cd -8'
# alias 9='cd -9'
# alias _=sudo
# alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# alias g=git
# alias l='ls -lahF --group-directories-first'
# alias la='l'
# alias ll='ls -lh'
# alias ls='ls --color=auto'


# PLUGINS
plugins='/usr/share/zsh/plugins'

source $plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
