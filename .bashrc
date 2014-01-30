# some of these variables should also go into scripts, that
# way they can apply to people not using this environment
HISTCONTROL=ignoredups
HISTIGNORE=c
HISTSIZE=10000
HOST=x86_64-w64-mingw32
PREFIX=/usr/x86_64-w64-mingw32/sys-root/mingw
PS1="\e];\s\a\n\e[33m\w \e[36m\$(pc)\n\[\e[m\]$ "
export CYGWIN=nodosfilewarning
export EDITOR='cygpath.sh notepad2'
_PATH=(
  /usr/local/bin    # ffmpeg php
  /usr/local/sbin   #
  /usr/bin          # find php
  /opt/imagemagick  # convert ffmpeg
  /opt/7-zip        #
  /opt/googlecl     #
  /opt/notepad2     #
  /windows/system32 # convert find
  /srv/a            #
  /srv/a/scripts    #
)
IFS=: read PATH <<< "${_PATH[*]}"
unset _PATH

c () {
  printf '\ec'
}

pc () {
  history -a
  [ -d .git ] || exit
  cd .git
  read ee <HEAD
  [[ $ee < g ]] && echo ${ee::7} || echo ${ee##*/}
  [ -g config ] && exit
  git config core.filemode 0
  chmod +s config
}

setup ()
{
  IFS=, read <<< "$*"
  setup-x86_64 -nqP $REPLY
}
