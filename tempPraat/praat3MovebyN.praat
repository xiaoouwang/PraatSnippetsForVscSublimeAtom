folder$ = "/Users/xiaoou/Documents/languages/formants/"
file$ = "gaWang2.txt"
# file$ = "french.txt"
subj = 1
outputfile$ = folder$ + file$
clearText = 0
# if clearText = 1
writeFileLine: outputfile$,"subj,vowel,f1,f2,f3,f4,point"
# endif
dir$ = "/Users/xiaoou/Documents/languages/todo/"
fList = Create Strings as file list: "list", dir$ + "*.wav"
nbOfFiles = Get number of strings
for i from 1 to nbOfFiles
  selectObject: fList
  fName$ = Get string: i
  fPath = Read from file: dir$ + fName$

  # do

endfor
# file$ = "mandarinReference.txt"
# file$ = "mandarin.txt"
# file$ = "frenchLearner.txt"
# check if file exists if no add header
if !fileReadable(outputfile$)
  writeFileLine: outputfile$,"subj,vowel,f1,f2,f3,f4,point"
endif
clearinfo
n = 10
total = Get selection length
# appendInfoLine: total
Move cursor to start of selection
cursor = Get cursor
# appendInfoLine: cursor
# Select next interval
# Select previous interval
# Move cursor to: cursor
move = total/n
# appendInfoLine: move
for i from 1 to n
  Move cursor by: move-0.00000001
  @hehe: i
  # cursor = Get cursor
  # appendInfoLine: cursor
endfor

procedure hehe: arg1

  # endif
  # oralPart = 30
  # cursor = Get cursor
  # start = Get start of selection
  # percentage ? is this really necessary no !
  # Select: cursor, cursorEnd
  # f1 = Get first formant
  # f1 = round (f1)
  # n=1
  f1 = Get first formant
  # while f1 > 1100 and n < 10
  f1 = round (f1)
  # 	cursor = cursor + 0.001
  # 	f1 = Get first formant
  # 	f1 = round (f1)
  # 	n = n+1
  # endwhile
  # n=1
  f2 = Get second formant
  f2 = round (f2)
  # while f2 < 400 and n < 10
  #   cursor = cursor + 0.001
  #   f2 = Get first formant
  #   f2 = round (f1)
  #   n = n+1
  # endwhile
  # n = 1
  f3 = Get third formant
  f3 = round (f3)
  f4 = Get fourth formant
  f4 = round (f4)
  # differenceF2F1 = f2 - f1
  # differenceF3F2 = f3 - f2
  # differenceF4F3 = f4 - f3
  # intensite = Get intensity
  # intensite = round (intensite)
  # pitch = Get pitch
  # pitch = round(pitch)

  # selection = Get selection length
  # writeInfoLine: selection
  label$ = Get label of interval
  appendFileLine: outputfile$, "'subj','label$','f1','f2','f3','f4','point','arg1'"
endproc