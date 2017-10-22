hook global WinSetOption filetype=rust %{
    set window formatcmd 'rustfmt'
}

hook global WinSetOption filetype=javascript %{
    set window formatcmd 'prettier --stdin --no-semi --single-quote --jsx-bracket-same-line --trailing-comma es5'
    set window lintcmd 'eslint -f $HOME/.config/kak/autoload/eslint-formatter.js -c $HOME/.config/kak/autoload/eslintrc.json'
    set global tabstop 2
    lint
}

hook global WinSetOption filetype=elixir %{
    set global tabstop 2
}

hook global WinSetOption filetype=go %{
    set window formatcmd 'gofmt'
    set window lintcmd 'golint'
    lint
}
