### editor beginning
# create an edit window
edit
Edit
# enter an edit window
enterEdit
editor: "$1:type $2:name"
# zoom
zoom
Zoom in
# end an editor
endEditor
endeditor
# close an editor
close
Close
# move cursor to
moveCursor
Move cursor to: $1:valueInSecond
# move cursor by
moveCursorBy
Move end of seletion by: $2:valueInSecond
# zoom selection
zoomSelection
Zoom to selection
# extract selection
extractSelection
Extract selected sound (time from 0)
# play the editor
playEditor
Play window
# draw visible sound
drVisible
Draw visible sound: "no", "yes", 0, 0, "no", "no", "no", "yes"
# extract selectionHamming
extractHamming
Extract selected sound (windowed): "slice", "Hamming", 1, "yes"### file and directory operations beginning
# read a file
readFile
Read from file: "$1"
# read long file
readLongFile
Open long sound file: "$1"
# save wav file
saveWav
Save as WAV file: "$1"
# save txt file (textgrid too)
saveTxt
Save as text file: "$1"
# remove a file
remove
Remove
# play a sound
play
Play
# play a pitch
playPitch
Hum
# create directory
createDirectory
createDirectory: "$1:directoryPath"
# delete file
deleteFile
deleteFile: $1:filePath
# check file existence and readability
checkFile
fileReadable ($1)
$0
# write line to file
writeLineToFile
writeFileLine: "$1:filePath", $2:content
$0
# append line to file, no need to have the file prexisting
appendLine
appendFileLine: "$1:filePath", $2:content
$0### formulas beginning
# round number to zero
round
round($1:number)
# round number to decimal precision
roundPrecision
number(fixed$($1:number,$2:1precision))
$0### graphics beginning
# erase the whole graphics
eraseGraph
Erase all
# draw a sound waveform
drWaveform
Draw: 0, 0, 0, 0, "yes", "Curve"
# draw intensty
drIntensity
Draw: 0, $1:timeRange, 0, $2:decibelRange, "no"
# draw inner box
drInnerBox
Draw inner box
# set Y step
setYstep
Marks left every: 1, $2:maybe50, "yes", "yes", "no"
# draw pitch
drPitch
Draw: 0, 0, $1:range1, $2:range2, "no"
# set outer viewport
setOuterView
Select outer viewport: 0, $1:horizontal, $2:verticalUp, $3:verticalDown
# set line width
setLineWidth
Line width: $1:1
# set line form
setLineForm
$1:Solid line
# set y label
setY
Text left: "yes", "$1"
$0
# set color
color
$1:Red### information beginning
# write information in new line
writeLine
writeInfoLine: $1:multipleInfoSeperatedByComma
$0
# append information in new line
appendLine
appendInfoLine: $1:multipleInfoSeperatedByComma
$0
# clear information
clear
clearinfo
# output the info window
printInfoWindow
appendFile: "$1:outputFilePath", info$()
$0
### interaction with user
# allow user to choose directory
chooseDirectory
chooseDirectory$: "$1:chooseTheDirectoryContainingSound"
# allow user to choose file to open
chooseFile
chooseReadFile$: "$1:open a file"
# create a form
form
form $1
  $2
endform### others beginning
# create a form
form
form $1
  $2
endform
$0
# tab character
tab
tab$
# newline character
newLine
newline$
# select an object
selObject
selectObject: $1
$0
### conditions and loop
# for loop
for
for i from 1 to $1
  $1:doSomething
endfor
$0
# while loop
while
while $1
  $2
endwhile
$0
# if
if
if
  $1
endif
$0
# if else
ifelse
if $1
  $2
elsif $3
  $4
endif
$0### object creation beginning
# create textgrid object
toTextgrid
To TextGrid: "$1:muitipleTiersSeperatedBySpace", "$2:eventTier"
$0
# create formant object
toFormant
To Formant (burg): 0, 5, $1:5000forMale5500forWomen, 0.025, 50
$0
# create pitch object
toPitch
To Pitch: $1:0timestep, $1:75floor, $2:600ceiling
# create intensity object
toIntensity
To Intensity: $1:100(maximumPitch), $2:0(timestep), "yes"
# create a tone with duration and fundamental frequency
toTone
Create Sound as pure tone: "$1:objectName", 1, 0, $2:duration, 44100, $3:fundamentalFrequency, 0.2, 0.01, 0.01
$0
# create sound from formula
toSoundwithFormula
Create Sound from formula "$1:objectName", 1, 0, $2:duration, $3:frequency, "$4:formula"
$0
### object manipulation
# choose selected object
chooseSelected
selected()
# copy an object (often useful to make a object last on the list)
Copy: "$1:newname"
$0
# remove selected files
removeSelected
Remove
# play a sound
play
Play
# play a pitch
playPitch
Hum
# rename an object
rename
Rename: "$1:newname"
# convert to number
convertNumber
number($1:stringToConvert)
# convert to string
convertString
string($2:numberToConvert)
# select an object
select
selectObject: $1:multipleObjectsSeperatedbyComma
# plus an object
plus
plusObject: $1
# minus an object
minus
minusObject: $1
# remove an object without selecting
removeObject
removeObject: $1:differentObjectsSeperatedByComma
### object query
# get maximum pitch
getMaximumPitch
Get maximum: $1:0timerange, 0, "Hertz", "Parabolic"
$0
# get sound frequency
getFrequency
Get sampling frequency
# get information
getInfo
Info
# get sound duration
getDuration
Get total duration
# get mean
getMean
Get mean: 1, 0, 0, "Hertz"
# get standard deviation
getSd
Get standard deviation: 1, 0, 0, "Hertz"
# get time of maximum formant
getTimeMaximumFormant
Get time of maximum: $1:whichFormant, 0, 0, "Hertz", "Parabolic"
### routines beginning : these are very common tasks in daily scripting files. We call them routines.
# remove all
removeAll
select all
Remove