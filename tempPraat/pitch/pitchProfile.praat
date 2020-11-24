select all
Remove
resultFile$ = "pitchLogCnCn.txt"
# resultFile$ = "pitchLogCnFr.txt"
# resultFile$ = "pitchLogCnFr.txt"
if not fileReadable: (resultFile$)
  header_row$ = "subject" + "," + "phoneme" + "," + "mean" + "," + "median" + "," + "min" + "," + "max" + newline$
  fileappend "'resultFile$'" 'header_row$'
endif
# create an array of users
# french speakers
# users = Create Strings as tokens: "alex alexis anne annemarie astrid aurelie camille chloe claude clelia elodie iris lise nono stella", " "
# chinese leaners
users = Create Strings as tokens: "amelieDB amelieLP chengyuan feige jianying mingming niuniu wangqi xiaoyi yali yiran yongxin yuting zeijie", " "

nbOfStr = Get number of strings
for i from 1 to nbOfStr
  selectObject: users
  user$ = Get string: i
  level1$ = user$ + "done"
  level2$ = user$ + "mono"
  # appendInfoLine: user$ , level1$, level2$
  # for chinese learners
  pathSound$ = "/Users/xiaoou/Desktop/doneChineseMimi/" + level1$ + "/" + level2$ + "/cn1triangleVoc.wav"
  # for french speakers
  # pathSound$ = "/Users/xiaoou/Desktop/doneFrenchMimi/" + level1$ + "/" + level2$ + "/fr1triangleVoc.wav"
  sound = Read from file: pathSound$
  pitchObject = To Pitch: 0, 75, 400
  max = Get maximum: 0,0, "Hertz", "Parabolic"
  min = Get minimum: 0,0, "Hertz", "Parabolic"
  mean = Get mean: 0,0, "Hertz"
  median = Get quantile: 0,0, 0.5, "Hertz"
  max = round(max)
  min = round(min)
  mean = round(mean)
  median = round(median)
  result_row$ = "'user$'" + "," + "global" + "," + "'mean'" + "," + "'median'" + "," + "'min'" + "," + "'max'" + newline$
  fileappend "'resultFile$'" 'result_row$'
  pathTextGrid$ = pathSound$ - ".wav" + ".TextGrid"
  textGrid = Read from file: pathTextGrid$
  appendInfoLine: textGrid
  selectObject: textGrid
  nbLabel = Get number of intervals: 2
  for thisInterval from 1 to nbLabel
    selectObject: textGrid
    phoneme$ = Get label of interval: 2, thisInterval
    start = Get starting point: 2, thisInterval
    end = Get end point: 2, thisInterval
    selectObject: pitchObject
    max = Get maximum: start,end, "Hertz", "Parabolic"
    min = Get minimum: start,end, "Hertz", "Parabolic"
    mean = Get mean: start,end, "Hertz"
    median = Get quantile: start,end, 0.5, "Hertz"
    max = round(max)
    min = round(min)
    mean = round(mean)
    median = round(median)
    if phoneme$ <> ""
      result_row$ = "'user$'" + "," + "'phoneme$'" + "," + "'mean'" + "," + "'median'" + "," + "'min'" + "," + "'max'" + newline$
      fileappend "'resultFile$'" 'result_row$'
    endif
  endfor
endfor
