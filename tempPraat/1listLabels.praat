clearinfo
endeditor
nbLabel = Get number of intervals: 1
squares# = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33, 44, 55, 66, 77 , 88 , 99, 00 }
for i from 1 to size(squares#)
  array[squares#[i]] = 0
endfor
for thisInterval from 1 to nbLabel
  phoneme$ = Get label of interval: 1, thisInterval
  if phoneme$ <> "" and phoneme$ <> "sound"
    appendInfoLine: phoneme$
    array[number(phoneme$)] += 1
  endif
endfor
for i from 1 to 20
# appendInfoLine: array[11], array[22], array[33]
for i from 1 to size(squares#)
  appendInfoLine: squares#[i],":",array[squares#[i]]
endfor

appendInfoLine: "done! :D"