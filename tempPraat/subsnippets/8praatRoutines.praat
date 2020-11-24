### routines beginning : these are very common tasks in daily scripting files. We call them routines.
# remove all/caution!
removeAll
select all
Remove
# get starting time tier interval
getStartLabel
Get starting point: 1, 1
# get ending time tier interval
getEndLabel
Get end point: 1, 1
# do sth to each file
rtLoopFiles
dir$ = "$1"
fList = Create Strings as file list: "list", dir$ + "*.wav"
nbOfFiles = Get number of strings
for i from 1 to nbOfFiles
    selectObject: fList
    fName$ = Get string: i
    fPath$ = Read from file: dir$ + fName$
    # do
    $0
endfor
# simple pause
crSimplePause
pauseScript: "$0"
# form template
rtForm
form text
    real var 1
    comment hehe
    text hehe "ga"
    boolean hehe 1
    choice Colour: 2
       button Dark red
       button Sea green
endform
# pause template
rtPause
beginPause: "title"
    comment: "text"
    positive: "a positive", 1
    real: "a real", 2
    text: "enter text", "t"
    boolean: "a boolean", 1
  	choice: "Team", 3
  		option: "a"
  		option: "b"
  		option: "c"
clicked = endPause: "start", 1
# stop
stop
pauseScript: message
# do sth to each directory
rtLoopDir
dir$ = "$1"
dList = Create Strings as directory list: "dir", dir$
nbOfDirs = Get number of strings
for i from 1 to nbOfDirs
    selectObject: dList
    dName$ = Get string: i
    dPath$ = Read from file: dir$ + dName$
    # do
    $0
endfor
# addDynam
addDynamic
Add action command: "Sound", 0, "", 0, "", 0, "clearAll", "", 0, "path"
# addButton
Add action command: "Sound", 1, "", 0, "", 0, "Usual", "", 0, ""
Add action command: "Sound", 1, "", 0, "", 0, "removeAll", "Usual", 1, "/Users/xiaoou/Documents/vscPlugins/awesome_praat_snippets/clearAll.praat"
# create a pause
crPause
beginPause: "where to save?"
  text: "save path", "t"
clicked = endPause: "start", 1
# procedure
proc
procedure do: .arg$
  appendInfoLine: .arg$
endproc
# procedure1
proc1
@squareNumber: 5
writeInfoLine: "The square of 5 is ", squareNumber.result, "."
procedure squareNumber: .number
    .result = .number ^ 2
endproc
# procedure2
proc2
@squareNumber: "$0" # this is the return variable
writeInfoLine: "The square of 5 is ", $0, "."
procedure squareNumber: .name$
    '.name$' = 5 ^ 2
endproc
# get textgrid name
getTextGridName
tgName$ = selected$ ("TextGrid")
# read txt
readTxt
Read Strings from raw text file: "$0"
# select first
selectFirst
select all
$1# = selected# ("$2")
selectObject: $2#[1]
# routine direcory recursive
rtLoopDirRecur
dir$ = "$1"
dList = Create Strings as directory list: "dir", dir$
nbOfDirs = Get number of strings
for i from 1 to nbOfDirs
  selectObject: dList
  dName$ = Get string: i
  pathComplet$ = dir$ + dName$
  appendInfoLine: pathComplet$
  fList = Create Strings as file list: "list", pathComplet$ + "/" + "*.ext"
  nbOfFiles = Get number of strings
  for j from 1 to nbOfFiles
    selectObject: fList
    fName$ = Get string: j
    fPath$ = pathComplet$ + "/" + "'fName$'"
    appendInfoLine: fPath$
    # do something here
    f = Read from file: fPath$
    selectObject: f
    Remove
  endfor
  selectObject: fList
  Remove
endfor
selectObject: dList
Remove
# rt for intervals
rtInterval
nbLabel = Get number of intervals: 1
for thisInterval from 1 to nbLabel
    select TextGrid 'thisTextGrid$'
    phoneme$ = Get label of interval: 1, thisInterval
endfor
# rt for intervals
rtLabel
nbLabel = Get number of intervals: 1
for thisInterval from 1 to nbLabel
    phoneme$ = Get label of interval: 1, thisInterval
    $0
endfor
# rt for textgrid's labels
rtTextgrid
nbLabel = Get number of intervals: 1
for thisInterval from 1 to nbLabel
    phoneme$ = Get label of interval: 1, thisInterval
    $0
endfor
# rt for intervals
rtIntervals
nbLabel = Get number of intervals: 1
for thisInterval from 1 to nbLabel
    phoneme$ = Get label of interval: 1, thisInterval
    $0
endfo
# get number of intervals
getNbInterval
Get number of intervals: $0:whichTier
# insert boundary
insBoundary
Insert boundary: $1:tier, $0:time
# insert boundary
crBoundary
Insert boundary: $1:tier, $0:time
# extract part sound
extractPartSound
Extract part: $1:intervalstart, $0:intervalend, "rectangular", 1, "no"
# extract part textgrid
extractPartTextgri
Extract part: $1:intervalstart, $0:intervalend, "no"
# to wordlist
toWord
To WordList
# has word
hasWord
Has word: $0
