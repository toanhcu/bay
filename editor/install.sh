#!/bin/dash -e
install -Dvt "$APPDATA"/Notepad2 notepad2.ini
ln -sfv "$PWD"/notepad2.sh /usr/local/bin
ln -sfv "$PWD"/.editor ~
