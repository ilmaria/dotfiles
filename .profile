if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if uwsm check may-start; then
    exec uwsm start -S hyprland.desktop
fi
