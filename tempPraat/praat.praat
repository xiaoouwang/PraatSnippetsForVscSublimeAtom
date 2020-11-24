# create an edit window
edit
Edit
# enter an edit window type + name
enterEdit
editor: "$1 $2"
# zoom
zoom
Zoom in
# end an editor
endEditor
endeditor
# close editor (should select the editor first)
closeEditor
Close
# new line
newline
newline$
# save textgrid
saveTextgrid
Save as text file: $0
# draw visible sound
drVisible
Draw visible sound: "no", "yes", 0, 0, "no", "no", "no", "yes"
# extract selectionHamming
extractHamming
Extract selected sound (windowed): "slice", "Hamming", 1, "yes"
# writeInfoLine
writeInfo
writeInfoLine: "x"
# appendInfoLine
appendInfo
appendInfoLine: newline$, "x"
# save wave
saveWav
Save as WAV file: $0
# annotate (the second pair of quotes define the point tier)
annotate
To TextGrid: "phoneme word", ""
# add button
addButton
Add action command: "Sound", 1, "", 0, "", 0, "Usual", "", 1, ""
Add action command: "Sound", 1, "", 0, "", 0, "queryFrequency", "Usual", 1, "/Users/rosingle/Desktop/praatscript/queryFrequency.praat"
Add action command: "Sound", 1, "", 0, "", 0, "removeAll", "Usual", 1, "/Users/rosingle/Desktop/praatscript/removeAll.praat"
Add action command: "Sound", 1, "", 0, "", 0, "quickAnnotate", "Usual", 1, "/Users/rosingle/Desktop/praatscript/quickAnnotate.praat"
Add action command: "Sound", 1, "", 0, "", 0, "formantCalc", "Usual", 1, "/Users/rosingle/Desktop/praatscript/formantCalc.praat"
Add action command: "Sound", 1, "", 0, "", 0, "test", "Usual", 1, "/Users/rosingle/Desktop/praatscript/test.praat"
# select by object and name
selectObjectName
selectObject: "Sound chain"
# get sound name
getSoundName
thisSound$ = selected$("Sound")
# get textgrid name
getTextgridName
thisTextgrid$ = selected$("TextGrid")
# get number of selected
getNumberSelected
numberOfSelectedSounds = numberOfSelected ()
# convert to string
toString
string$()
# create a directory
createDirectory
createDirectory: directoryName$
# delete a file
deleteFile
deleteFile:
# end with (left = the original string, right = check condition)
endWith
endsWith(a$, b$)
# start with (left = the original string, right = check condition)
startWith
startsWith(a$, b$)
# replace string b = search, c = replace with, n = replacement how many 0 = replace all
replaceString
replace$(a$, b$, c$, n)
# get string length
lengthString
length(a$)
# slice a string from left n = how many characters
sliceLeft
left$(a$, n)
# slice a string from right n = how many characters
sliceRight
left$(a$, n)
# index of the first occurrence from the left
indexLeft
index(a$, b$)
# index of the first occurrence from the right
indexRight
rindex(a$, b$)
# index of the first regex occurrence from the left
indexRegex
index_regex (a$, b$)
# index of the first regex occurrence from the right
rindexRegex
rindex_regex (a$, b$)
# replace regex, b = search, c = replace with, n = replacement how many 0 = replace all
replaceRegex
replace_regex$ (a$, b$, c$, n)
# print preference direcotory
pref
writeInfoLine: preferencesDirectory$
# remove all files corresponding to a certain condition
removeCond
select all
sounds# = selected# ("Sound")
writeInfoLine: size (sounds#)
for i to size (sounds#)
    selectObject: sounds# [i]
    name$ = selected$ ("Sound")
    if name$ = "chain"
      Remove
    endif
endfor
# mark bottom
Marks bottom every: 1, 1000, "yes", "yes", "yes"
# draw fft
Draw: 0, 5000, 0, 60, "yes"
# legend
Text top: "yes", "text"
# get sound start
Get start time
# get sound end
Get end time
# get start selection
Get start of selection
# get end selection
Get end of selection
# get number of intervals
numberOfPhonemes = Get number of intervals: 1
# get label 3 = interval index
thisPhoneme$ = Get label of interval: 1, 3
# get interval index at time
thisWordIntervalIndex = Get interval at time: 1, time
# loop through each interval
numberOfPhonemes = Get number of intervals: 1
for thisInterval from 1 to numberOfPhonemes
    select TextGrid 'thisTextGrid$'
    thisPhoneme$ = Get label of interval: 1, thisInterval
endfor
# get general interval infos with interval index = $1
getIntervalInfo
startTime = Get start point: 1, $1
endTime = Get end point: 1, $1
duration = endTime - startTime
midPoint = startTime + duration/2
Get interval at time: 1, midPoint # get index
Get label of interval: 1, j # get interval label
# get number of intervals
getNumberInterval
Get number of intervals: 1
# get index of interval at certain time
getIndexInterval
Get interval at time: 1, time$
# get number of intervals
getNumberTier
Get number of tiers
# get label (j = interval index)
getLabel
label_1tier$ = Get label of interval: 1, j
# to formant (5000 for men and 5500 for women)
toFormant
To Formant (burg)... 0 5 5000 0.025 50
# extract formant
select Formant 'thisSound$'
f1 = Get value at time... 1 midpoint Hertz Linear
f2 = Get value at time... 2 midpoint Hertz Linear
f3 = Get value at time... 3 midpoint Hertz Linear
# write column names to a file
writeFile
writeFileLine: outputPath$, "a,b,c"
# append to a file, the comma separates columns
appendFile
appendFileLine: outputPath$, "a",",","b",",",variable
# if
if
if $1
  $0
endif
# while
while
while $1
  $0
endwhile
# for
for
for $1
  $0
endfor