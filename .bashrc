# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export DISPLAY=:0
export BROWSER="firefox"

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
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
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias g=git
alias l='ls -lahF --color=auto --group-directories-first'
alias kak='$HOME/bin/kakoune'

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

LC_CTYPE=fi_FI.UTF-8
LC_NUMERIC=fi_FI.UTF-8
LC_TIME=fi_FI.UTF-8
LC_COLLATE=fi_FI.UTF-8
LC_MONETARY=fi_FI.UTF-8
LC_PAPER=fi_FI.UTF-8
LC_NAME=fi_FI.UTF-8
LC_ADDRESS=fi_FI.UTF-8
LC_TELEPHONE=fi_FI.UTF-8
LC_MEASUREMENT=fi_FI.UTF-8
LC_IDENTIFICATION=fi_FI.UTF-8
# LC_MESSAGES="en_US.UTF-8"

shopt -s histappend   # append to the history file, don't overwrite it
shopt -s histverify  # Don't execute immediately upon history expansion

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

PS1="\n\W \$ "

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
