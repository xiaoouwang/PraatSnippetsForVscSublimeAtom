clearinfo
dirUp$ = "/Users/xiaoou/Desktop/ooo0724/fr2/"
dList = Create Strings as directory list: "dir", dirUp$
nbOfDirs = Get number of strings
# appendInfoLine: nbOfDirs
for i to nbOfDirs
  selectObject: dList
  dName$ = Get string: i
  # do
  fList = Create Strings as file list: "list", dirUp$ + dName$ + "/*.wav"
  nbOfFiles = Get number of strings
  for j to nbOfFiles
    selectObject: fList
    fname$ = Get string: j
    # read sound
    f = Read from file: dirUp$ + dName$ + "/" + fname$
    appendInfoLine: dirUp$ + dName$ + "/" + fname$
    # segment
    To TextGrid (silences): 100, 0, -25, 0.1, 0.1, "", "sound"
    Set tier name: 1, "index"
    # save
    thisTextGrid$ = selected$ ("TextGrid")
    path$ = dirUp$ + dName$ + "/" + thisTextGrid$ + ".TextGrid"
    if fileReadable (path$)
      appendInfoLine: "file 'thisTextGrid$' existed"
    else
      Save as text file: path$
    endif
    plusObject: f
    Remove
  endfor
  selectObject: fList
  Remove
endfor
selectObject:dList
plusObject: nbOfDirs
appendInfoLine: "done!"
