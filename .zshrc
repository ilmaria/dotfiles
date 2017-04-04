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


# History
HISTFILE=~/.history_zsh
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history         # Save timestamp
setopt append_history           # Append rather than overwrite
setopt inc_append_history       # Write to history file immediately, not when exiting shell
setopt share_history            # Share history between terminals
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS         # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS     # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS        # Do not display a line previously found
setopt HIST_SAVE_NO_DUPS        # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks before recording entry
setopt HIST_VERIFY              # Don't execute immediately upon history expansion
