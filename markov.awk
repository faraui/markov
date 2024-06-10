{ if ($3 == "^") { $3 = "" }
  if (sub($1, $3, WORD)) {
    if ($2 == ",") {
      for (i = ARGC; i > ARGIND; i--)
        ARGV[i] = ARGV[i - 1]
      ARGC++
      ARGV[ARGIND + 1] = FILENAME
    }
    nextfile
  }
} END {
  print ""
  print WORD
}
