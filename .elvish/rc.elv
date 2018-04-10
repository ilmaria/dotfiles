use github.com/zzamboni/elvish-completions/git

edit:prompt = { put (edit:styled "\n"(path-base $pwd)" > " lightyellow) }

E:BROWSER='/usr/bin/firefox'
E:EDITOR='/usr/bin/vim'
E:RUST_SRC_PATH=".rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
E:NVM_DIR="~/.nvm"
E:GOPATH="/Users/223961/go"

# Allows installing local dependencies with 'pip install -t .pip'
E:PYTHONPATH="./.pip:$E:PYTHONPATH" 

# Enable erlang shell history
E:ERL_AFLAGS="-kernel shell_history enabled"

paths = [
    /usr/local/bin
    ~/bin
    ~/.npm-global
    ~/go/bin
    /usr/local/go/bin
    $@paths
]

fn l [@args]{
    e:ls -lahF $@args
}

fn dotfiles [@args]{
    git --git-dir=$E:HOME/.dotfiles/ --work-tree=$E:HOME $@args
}

fn g [@args]{
    git $@args
}

fn npm [@args]{
    bash -c "source "$E:NVM_DIR/nvm.sh" && npm "(joins " " $args)
}

fn nvm [@args]{
    bash -c "source "$E:NVM_DIR/nvm.sh" && nvm "(joins " " $args)
}
