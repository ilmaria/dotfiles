# Install modules if they are not already installed
use epm
epm:install &silent-if-installed=$true \
    github.com/zzamboni/elvish-completions \
    github.com/zzamboni/elvish-modules \
    github.com/xiaq/edit.elv \

use github.com/zzamboni/elvish-completions/git

E:BROWSER='firefox'
E:EDITOR='vim'
E:RUST_SRC_PATH=".rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
E:NVM_DIR="~/.nvm"
E:GOPATH="/Users/223961/go"
E:PLAN9="/usr/local/plan9"

# Allows installing local dependencies with 'pip install -t .pip'
E:PYTHONPATH="./.pip:$E:PYTHONPATH" 
# Enable erlang shell history
E:ERL_AFLAGS="-kernel shell_history enabled"

E:LESS = (joins " " [
    "--ignore-case"
    "--jump-target=12"
    "--shift=1"
    "-R"
])

paths = [
    /usr/local/bin
    ~/bin
    ~/.npm-global
    ~/go/bin
    /usr/local/go/bin
    ~/flutter/bin
    /usr/local/opt/node@8/bin
    ~/.cargo/bin
    $@paths
	$E:PLAN9"/bin"
]

# Aliases and functions
fn l [@args]{
    exa --long --all --group-directories-first $@args
}

fn ls [@args]{
    exa --long --group-directories-first $@args
}
fn dotfiles [@args]{
    git --git-dir=$E:HOME/.dotfiles/ --work-tree=$E:HOME $@args
}

fn g [@args]{
    git $@args
}

# Navigate directory history
use github.com/zzamboni/elvish-modules/dir
edit:insert:binding[Alt-a] = $dir:history-chooser~

# Custom prompt
use git-prompt
edit:prompt = { edit:styled (path-base $pwd)" > " lightyellow }
edit:rprompt = (git-prompt:prompt)

# A matcher that tries the following matchers: prefix match, smart-case
# prefix match, substring match, smart-case substring match,
# subsequence match and smart-case subsequence match.
use github.com/xiaq/edit.elv/smart-matcher
smart-matcher:apply
