#!/usr/local/bin/awklib -f

BEGIN {
  if (ARGC != 4) {
    _["SYNOPSIS", "ff-seq.awk <start> <duration> <file>", "",
    "DESCRIPTION", "Make an image sequence from a video"]
    str_dump(arr_search(_))
    exit 1
  }
  _["ffmpeg", "-hide_banner", "-ss", ARGV[1], "-i", ARGV[3], "-t", ARGV[2],
  "-vf", "select='eq(pict_type, I)'", "-vsync", "vfr", "-q", 1, "%d.jpg"]
  sh_trace(arr_search(_))
}
