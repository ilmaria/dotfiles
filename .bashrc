export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export BROWSER="firefox"
export EDITOR="vim"
export VISUAL="vim"
# Enable erlang shell history
export ERL_AFLAGS="-kernel shell_history enabled"
export GOPATH="$HOME/go"
export HOMEBREW_NO_AUTO_UPDATE=1

# --ignore-case     Ignore case when searching
# --jump-target=12  Show lines above search results when jumping to next result
# --shift=1         Horizontal scroll speed 
# -R                Show colors
export LESS="        \
    --ignore-case    \
    --jump-target=12 \
    --shift=1        \
    -R               \
"

PATH=$HOME/bin:$HOME/.npm-global/bin:$GOPATH/bin:$HOME/.cargo/bin:$PATH

yellow='\[\e[93m\]'
end_color='\[\e[m\]'

PS1="$yellow\n\W > $end_color"
PS2="$yellow > $end_color"

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias g=git
alias kak='$HOME/bin/kakoune'

if command -v exa >/dev/null 2>&1; then
    alias l='exa --long --group-directories-first'
    alias la='l --all'
else
    alias l='ls -lhF --color=auto --group-directories-first'
    alias la='l -a'
fi

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

shopt -s histappend  # Append to the history file, don't overwrite it
shopt -s histverify  # Don't execute immediately upon history expansion

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function java_use() {
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
    export PATH=$JAVA_HOME/bin:$PATH
    java -version
}
