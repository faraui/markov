{
  L[NR] = $1
  M[NR] = $2
  if ($3 == "^") { $3 = "" }
  R[NR] = $3
} 
END
{
  i = 0
  while (i <= NR) {
    i++
    if (sub(L[i], R[i], WORD)) {
      if (M[i] == ".") { break }
      i = 0
    }
  } print WORD
}
