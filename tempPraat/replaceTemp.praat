nbLabel = Get number of intervals: 1
for thisInterval from 1 to nbLabel
  phoneme$ = Get label of interval: 1, thisInterval
  if length(phoneme$) < 4 and phoneme$ <> ""
    Set interval text: 1, thisInterval, "1"
  endif
endfor