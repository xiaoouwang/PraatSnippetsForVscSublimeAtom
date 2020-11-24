clearinfo
textgrids# = selected#("TextGrid")
len = size(textgrids#)
for i to len
  selectObject: textgrids#[i]
  # clearinfo
  leftover$ = Info
  # length of the text as number of words
  leftoverlength = length(leftover$)
  # first line end
  firstLineEnd = index (leftover$, newline$)
  # extract first line
  firstLine$ = left$ (leftover$, (firstLineEnd - 1))
  # update leftover$ as the rest of the strings
  leftover$ = right$ (leftover$, (leftoverlength - firstLineEnd))
  # second line end
  secondLineEnd = index (leftover$, newline$)
  secondLine$ = left$ (leftover$, secondLineEnd)
  lenSecondLine = length(secondLine$)
  fn_start = 18
  fn$ = mid$ (secondLine$ , fn_start , lenSecondLine-fn_start)
  appendInfoLine: fn$
  if fileReadable: (fn$)
    pauseScript: "this file already exists at ",right$ (fn$, 40)
  endif
  Save as text file: fn$
  appendInfoLine: "'fn$' saved"
endfor
