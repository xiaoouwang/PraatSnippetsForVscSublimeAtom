dir$ = "/Users/xiaoou/Desktop/ooo0724/fr3/alex1107/donetrio"
fileEnd$ = right$ (dir$, 4)
# must end in trio
if fileEnd$ <> "trio"
  beginPause: "please annotate in the trio folder"
    text: "problem", "warning, please annotate in the trio folder"
  clicked = endPause: "continue malgre l'avertissement", 1
endif
fList = Create Strings as file list: "list", dir$ + "/*.TextGrid"
nbOfFiles = Get number of strings
tierMn = 3
for i to nbOfFiles
  selectObject: fList
  fName$ = Get string: i
  writeInfoLine: fName$
  f = Read from file: dir$ + "/" + fName$
  # do
  Duplicate tier: 1, tierMn, "mn"
  nbLabel = Get number of intervals: 2
  for thisInterval from 1 to nbLabel
    phoneme$ = Get label of interval: 2, thisInterval
    # clean sound
    if phoneme$ = "sound"
      Set interval text: 1, thisInterval, ""
      Set interval text: 2, thisInterval, ""
      Set interval text: tierMn, thisInterval, ""
      Set interval text: 4, thisInterval, ""
    endif
  endfor
  for thisInterval from 1 to nbLabel
    phoneme$ = Get label of interval: 2, thisInterval
    # clean sound
    if phoneme$ = "sound"
      Set interval text: 1, thisInterval, ""
      Set interval text: 2, thisInterval, ""
      Set interval text: tierMn, thisInterval, ""
      Set interval text: 4, thisInterval, ""
    endif
    if phoneme$ <> "sound" and phoneme$ <> ""
      appendInfoLine: phoneme$
      # Set interval text: tierMn, thisInterval, ""
      start = Get start time of interval: 2, thisInterval
      appendInfoLine: start
      end = Get end time of interval: 2, thisInterval
      mid = start + (end - start )/2
      quin = (end-start)/3
      nearend = end - quin
      # appendInfoLine: start,end,mid
      Insert boundary: tierMn, mid-quin
      # Insert boundary: tierMn, nearend
      left = Get interval at time: tierMn, start
      midInterval = Get interval at time: tierMn, mid
      nearendInterval = Get interval at time: tierMn, nearend
      appendInfoLine: left, " ", nearendInterval, " ", right
      Set interval text: tierMn, left, "o"
      Set interval text: tierMn, midInterval, "n"
      # Set interval text: tierMn, nearendInterval, "q"
      # get interval number by time
      # doesn't work here
      # Set interval text: 2, thisInterval, "o"
      # Set interval text: 2, thisInterval+1, "n"
    endif
  endfor
  Save as text file: dir$ + "/" + fName$
endfor
appendInfoLine: "done! :)"