clearinfo
res_freq = 11000
dirUp$ = "/Users/xiaoou/Desktop/doneChineseMimi/"
dList = Create Strings as directory list: "dir", dirUp$
nbOfDirs = Get number of strings
# appendInfoLine: nbOfDirs
for i to nbOfDirs
  selectObject: dList
  dName$ = Get string: i
  # do
  end = rindex (dName$, "done")
  subjectName$ = left$(dName$,end-1)
  soundDir$ = dirUp$+dName$+"/"+subjectName$ + "monoScaled"+"/"
  drCreated$ = dirUp$+dName$+"/"+subjectName$+"resampled/"
  createDirectory: drCreated$
  fList = Create Strings as file list: "list", soundDir$ + "*.wav"
  nbOfFiles = Get number of strings
  for j to nbOfFiles
    selectObject: fList
    fName$ = Get string: j
    # read sound
    f = Read from file: dirUp$ + dName$ + "/"+subjectName$ + "monoScaled"+"/" + fName$
    # resample
    Resample: res_freq, 50
    newPath$ = drCreated$ + fName$
    Save as WAV file: newPath$
    Read from file: soundDir$ + fName$ - ".wav" + ".TextGrid"
    Save as text file: drCreated$ + fName$ - ".wav" + ".TextGrid"
    appendInfoLine: "'newPath$' saved"
  endfor
endfor
select all
Remove
appendInfoLine: "done!"
