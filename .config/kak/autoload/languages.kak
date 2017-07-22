hook global WinSetOption filetype=rust %{
    set window formatcmd 'rustfmt'
}

hook global WinSetOption filetype=javascript %{
    set window formatcmd 'prettier --stdin --no-semi --single-quote --jsx-bracket-same-line'
    set window lintcmd 'eslint --stdin  -f $HOME/.config/kak/autoload/eslint-formatter.js -c $HOME/.config/kak/autoload/eslintrc'
    lint-enable
    lint
}

hook global WinSetOption filetype=go %{
    set window formatcmd 'gofmt'
    set window lintcmd 'golint'
    lint-enable
    lint
}
