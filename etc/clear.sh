#!/bin/dash -e
xc() {
  awk 'BEGIN {d = "\47"; printf "\33[36m"; while (++j < ARGC) {
  k = split(ARGV[j], q, d); q[1]; for (x in q) {
  printf q[x] ~ /^[[:alnum:]%+,./:=@_-]+$/ ? q[x] : d q[x] d
  if (x < k) printf "\\" d} printf j == ARGC - 1 ? "\33[m\n" : FS}}' "$@"
  "$@"
}

# clear explorer and wallpaper history
while read br
do
  if REG QUERY "$br" >/dev/null 2>&1
  then xc REG DELETE "$br" /f
  fi
done <<'eof'
HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths
HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers\Images
eof

# clear run history
xc rundll32 inetcpl.cpl ClearMyTracksByProcess 1

# remove dead symlinks
for br in /usr/local/bin/*
do
  if [ -h "$br" -a ! -f "$br" ]
  then
    rm -v "$br"
  fi
done
