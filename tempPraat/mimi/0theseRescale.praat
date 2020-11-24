clearinfo
dirUp$ = "/Users/xiaoou/Desktop/doneFrenchMimi/"
dList = Create Strings as directory list: "dir", dirUp$
nbOfDirs = Get number of strings
# appendInfoLine: nbOfDirs
for i to nbOfDirs
  selectObject: dList
  dName$ = Get string: i
  # do
  end = rindex (dName$, "done")
  subjectName$ = left$(dName$,end-1)
  soundDir$ = dirUp$+dName$+"/"+subjectName$ + "trio"+"/"
  # appendInfoLine: soundDir$
  createDirectory: dirUp$+dName$+"/"+subjectName$+"filtered"
  # appendInfoLine: soundDir$
  fList = Create Strings as file list: "list", soundDir$ + "*.wav"
  nbOfFiles = Get number of strings
  for j to nbOfFiles
    selectObject: fList
    fName$ = Get string: j
    # read sound
    f = Read from file: dirUp$ + dName$ + "/"+subjectName$ + "trio"+"/" + fName$
  #   # extract all
    Extract all channels
    channel1$ = selected$("Sound",1)
    channel2$ = selected$("Sound",2)
    channel3$ = selected$("Sound",3)
    selectObject: "Sound 'channel1$'"
    Scale peak: 0.5
    selectObject: "Sound 'channel2$'"
    # selectObject: "Sound 'channel3$'"
    Scale peak: 0.2
    # Filter (pass Hann band): 0, 600 , 100
    Copy: "temp"
    plusObject: "Sound 'channel1$'"
    Combine to stereo
    newPath$ = dirUp$+dName$+"/"+subjectName$+"filtered/" + fName$
    Save as WAV file: newPath$
    Read from file: dirUp$ + dName$ + "/"+subjectName$ + "trio"+"/" + fName$ - ".wav" + ".TextGrid"
    Save as text file: dirUp$ + dName$ + "/"+subjectName$ + "filtered"+"/" + fName$ - ".wav" + ".TextGrid"
    appendInfoLine: "'newPath$' saved"
    selectObject: "Sound 'channel1$'"
    plusObject: "Sound 'channel2$'"
    plusObject: "Sound 'channel3$'"
    plusObject: "Sound temp"
    plusObject: f
    Remove
  endfor
endfor
# selectObject:dList
select all
Remove
appendInfoLine: "done!"
