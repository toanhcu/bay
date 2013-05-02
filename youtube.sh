# Bash download from YouTube
# http://youtube.com/watch?v=LHelEIJVxiE
# http://youtube.com/watch?v=L7ird1HeEjw

if [[ $OSTYPE =~ linux ]]
then
  FIREFOX=firefox
else
  FIREFOX="$PROGRAMFILES/mozilla firefox/firefox"
fi

qual=(
  [5]='240p FLV h.263'
  [17]='144p 3GP mpeg4 simple'
  [18]='360p MP4 h.264 baseline'
  [22]='720p MP4 h.264 high'
  [34]='360p FLV h.264 main'
  [35]='480p FLV h.264 main'
  [36]='240p 3GP mpeg4 simple'
  [37]='1080p MP4 h.264 high'
  [43]='360p WebM vp8'
  [44]='480p WebM vp8'
  [45]='720p WebM vp8'
  [46]='1080p WebM vp8'
  [82]='360p MP4 h.264 3D'
  [84]='720p MP4 h.264 3D'
  [100]='360p WebM vp8 3D'
  [102]='720p WebM vp8 3D'
)

warn ()
{
  printf '\e[36m%s\e[m\n' "$*"
}

usage ()
{
  echo usage
  echo $0 URL
  echo or
  echo $0 ITAG URL
  exit
}

decode ()
{
  read $1 <<< $(sed 's % \\\\x g' <<< ${!2} | xargs printf)
}

log ()
{
  unset PS4
  set $((set -x; : "$@") 2>&1)
  shift
  warn $*
  eval $*
}

download ()
{
  IFS=/ read gg hh <<< "$1"
  exec 3< /dev/tcp/$gg/80
  {
    echo GET /$hh HTTP/1.1
    echo connection: close
    echo host: $gg
    echo
  } >&3
  sed '1,/^$/d' <&3
}

[ $1 ] || usage
[ $2 ] || set '' $1
arg_itag=$1
arg_url=$2

# set
# declare
# decode

set ${arg_url//[&?]/ }
shift
declare $*
set $(curl -s www.youtube.com/get_video_info?video_id=$v)
[ $1 ] || exit
declare ${1//&/ }
decode fmt_stream_map url_encoded_fmt_stream_map

set ${fmt_stream_map//,/ }
for oo
do
  declare ${oo//&/ }
  decode decoded_url url
  if ! [ $arg_itag ]
  then
    printf ' %3.3s  %s\n' $itag "${qual[itag]}"
  elif [ $arg_itag = $itag ]
  then
    break
  fi
done

[ $arg_itag ] || usage
"$FIREFOX" "$decoded_url&signature=$sig" &
