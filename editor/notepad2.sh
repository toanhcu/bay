#!/bin/dash -e
if [ "$1" ]
then k=$(cygpath -w "$1")
elif [ "$#" != 0 ]
then k=
fi
Notepad2 ${k+"$k"}
