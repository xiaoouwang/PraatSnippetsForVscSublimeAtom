# get all the wave
clearinfo
dir$ = "/Users/xiaoou/Desktop/ooo0724/fr3/lise1207"
# fileEnd$ = right$ (dir$, 4)
# if fileEnd$ <> "trio"
#   beginPause: "please annotate in the trio folder"
#     text: "problem", "t"
#   clicked = endPause: "start", 1
# endif
lastSlash = rindex (dir$, "/")
strLen = length (dir$)
foldName$ = right$ (dir$, strLen-lastSlash)
dirnew$ = dir$ + "/'foldName$'trio"
appendInfoLine: lastSlash,strLen,dirnew$
createDirectory: dirnew$
fList = Create Strings as file list: "list", dir$ + "/*.wav"
nbOfFiles = Get number of strings
for i from 1 to nbOfFiles
  selectObject: fList
  fName$ = Get string: i
  f = Read from file: dir$ + "/" + fName$
  # do
  sName0$ = selected$ ("Sound", 1)
  Extract all channels
  sName1$ = selected$ ("Sound", 1)
  sName$ = selected$ ("Sound", 2)
  appendInfoLine: sName$
  selectObject: "Sound 'sName$'"
  Filter (pass Hann band): 0, 600 , 100
  plusObject: "Sound 'sName0$'"
  Combine to stereo
  Save as WAV file: dirnew$ + "/" + fName$
endfor

fList = Create Strings as file list: "list", dir$ + "/*.TextGrid"
nbOfFiles = Get number of strings
for i from 1 to nbOfFiles
  selectObject: fList
  fName$ = Get string: i
  f = Read from file: dir$ + "/" + fName$
  Save as text file: dirnew$ + "/" + fName$
  # do
endfor

appendInfoLine: "done! :)"