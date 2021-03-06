#!/bin/sh

command -v kak >/dev/null 2>&1 || {
    echo >&2 "Kakoune is not installed. Aborting."
    exit 1
}

socket_file=$(kak -l | grep $USER)

if [ "$socket_file" != "$USER" ]; then        
    # Create new kakoune deamon for current dir
    kak -d -s $USER
fi

kak -c $USER $@
