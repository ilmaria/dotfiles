use github.com/zzamboni/elvish-completions/git

edit:prompt = { put (edit:styled "\n"(path-base $pwd)" > " lightyellow) }

E:BROWSER='/usr/bin/firefox'
E:EDITOR='/usr/bin/vim'
E:RUST_SRC_PATH=".rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"

# Allows installing local dependencies with 'pip install -t .pip'
E:PYTHONPATH="./.pip:$E:PYTHONPATH" 

# Enable erlang shell history
E:ERL_AFLAGS="-kernel shell_history enabled"

paths = [
    $@paths
    ~/bin
    ~/.npm-global
]

fn l [@args]{
    exa --long --all --group-directories-first $@args
}

fn dotfiles [@args]{
    git --git-dir=$E:HOME/.dotfiles/ --work-tree=$E:HOME $@args
}

fn g [@args]{
    git $@args
}

