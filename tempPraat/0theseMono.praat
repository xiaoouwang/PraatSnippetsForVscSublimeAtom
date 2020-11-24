# get all the first channel from the trio folder
clearinfo

dir$ = "/Users/xiaoou/Desktop/doneFrenchMimi/stelladone/stella1607trio"
fileEnd$ = right$ (dir$, 4)
if fileEnd$ <> "trio"
  beginPause: "warning"
    text: "problem", "warning! folder not ended with trio"
  clicked = endPause: "continue", 1
endif
dirnew$ = dir$ - "trio" + "mono"
createDirectory: dirnew$
fList = Create Strings as file list: "list", dir$ + "/*.wav"
nbOfFiles = Get number of strings
for i from 1 to nbOfFiles
  selectObject: fList
  fName$ = Get string: i
  f = Read from file: dir$ + "/" + fName$
  # do
  Extract one channel: 1
  Save as WAV file: dirnew$ + "/" + fName$
  removeObject: f
endfor

fList = Create Strings as file list: "list", dir$ + "/*.TextGrid"
nbOfFiles = Get number of strings
for i from 1 to nbOfFiles
  selectObject: fList
  fName$ = Get string: i
  f = Read from file: dir$ + "/" + fName$
  Save as text file: dirnew$ + "/" + fName$
  removeObject: f
  # do
endfor
appendInfoLine: "done! :D"