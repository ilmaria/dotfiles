# Zsh
ENABLE_CORRECTION="true"


# Exports
export BROWSER='/usr/bin/firefox'
export EDITOR='/usr/bin/vim'
export RUST_SRC_PATH=".rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
# Allows installing local dependencies with 'pip install -t .pip'
export PYTHONPATH="./.pip:$PYTHONPATH" 
# Enable erlang shell history
export ERL_AFLAGS="-kernel shell_history enabled"
export GOPATH="/Users/223961/go"

# --ignore-case     Ignore case when searching
# --jump-target=N   Show lines above search results when jumping to next result
# --shift=1         Horizontal scroll speed 
# -R                Show colors
export LESS="        \
    --ignore-case    \
    --jump-target=4  \
    --shift=1        \
    -R               \
"

PATH=/usr/local/bin:$PATH:$HOME/bin:$HOME/.npm-global/bin:/usr/local/go/bin:$HOME/go/bin

if [ -d "/opt/android-sdk/platform-tools" ]
then
    export PATH="$PATH:/opt/android-sdk/platform-tools"
fi

PS1=$'\n%C > '
PS2=' > '


# Aliases
alias _=sudo
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias g=git
alias l='ls -lahF'
alias kak='$HOME/bin/kakoune'


# Zsh plugins
plugins='/usr/local/share'
source $plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Completions path
fpath+=~/.zfunc

# Enable autocompletion
autoload -Uz compinit
compinit

setopt correct          # Spelling correction for commands
setopt auto_cd          # Perform 'cd' command if input is valid path
setopt menu_complete    # Select first completion item on key press

# Case insensitive autocompletion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# Search with 'Ctrl-r'
bindkey '^R' history-incremental-pattern-search-backward

# Fix special buttons
bindkey "^[[7~"     beginning-of-line
bindkey "^[[8~"     end-of-line
bindkey "^[[3~"     delete-char 
bindkey "^[[1;5C"   forward-word
bindkey "^[[1;5D"   backward-word


# History
HISTFILE=$HOME/.zhistory
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
