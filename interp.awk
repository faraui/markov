#!/bin/mawk -f

{ 
  L[FNR] = $1
  M[FNR] = $2
  if ($3 == "^") { $3 = "" }
  R[FNR] = $3
} END {
  i = 1
  while (i <= FNR) {
    if (sub(L[i], R[i], WORD)) {
      if (M[i] == ".") { break }
      i = 1
    } else { i++ }
  } print WORD
}
-v
