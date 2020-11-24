# get all the first channel from the trio folder
clearinfo
# chinese users
# users = Create Strings as tokens: "amelieDB amelieLP chengyuan feige jianying mingming niuniu wangqi xiaoyi yali yiran yongxin yuting zeijie", " "
# french users
users = Create Strings as tokens: "alex anne annemarie astrid aurelie camille chloe claude clelia elodie iris lise nono stella alexis", " "
# users = Create Strings as tokens: "annemarie astrid aurelie camille chloe claude clelia elodie iris lise nono", " "
nbOfStr = Get number of strings
for i from 1 to nbOfStr
  selectObject: users
  user$ = Get string: i
  level1$ = user$ + "done"
  level2$ = user$ + "filtered"
  # for chinese
  # dir$ = "/Users/xiaoou/Desktop/doneChineseMimi/" + level1$ + "/" + level2$
  # for french
  dir$ = "/Users/xiaoou/Desktop/doneFrenchMimi/" + level1$ + "/" + level2$
  # appendInfoLine: dir$
  fileEnd$ = right$ (dir$, 4)
  # if fileEnd$ <> "trio"
  #   beginPause: "warning"
  #     text: "problem", "warning! folder not ended with trio"
  #   clicked = endPause: "continue", 1
  # endif
  dirnew$ = dir$ - "filtered" + "monoScaled"
  createDirectory: dirnew$
  fList = Create Strings as file list: "list", dir$ + "/*.wav"
  nbOfFiles = Get number of strings
  for j from 1 to nbOfFiles
    selectObject: fList
    fName$ = Get string: j
    f = Read from file: dir$ + "/" + fName$
    # do
    Extract one channel: 1
    Save as WAV file: dirnew$ + "/" + fName$
    appendInfoLine: dirnew$ + "/" + fName$ + " saved"
    removeObject: f
  endfor
  # save textgrids too
  fList = Create Strings as file list: "list", dir$ + "/*.TextGrid"
  nbOfFiles = Get number of strings
  for k from 1 to nbOfFiles
    selectObject: fList
    fName$ = Get string: k
    f = Read from file: dir$ + "/" + fName$
    Save as text file: dirnew$ + "/" + fName$
    removeObject: f
    # do
  endfor
endfor
appendInfoLine: "done! :D"