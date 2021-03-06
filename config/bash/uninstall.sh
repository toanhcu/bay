#!/bin/dash -e
. ./.profile

# /etc
rm -fv /etc/fstab
cp -v /etc/defaults/etc/profile /etc

# /home
rm -fv ~/.bash_history ~/.inputrc ~/.profile

# /usr
awklib '
BEGIN {
  FS = "\\"
}
{
  z = z " /usr/local/bin/" sh_escape($NF)
}
END {
  system("rm" z)
}
' symlink.txt
