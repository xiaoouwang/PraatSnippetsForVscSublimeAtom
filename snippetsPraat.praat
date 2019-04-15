### object creation
# create pitch object
crPitch
To Pitch: 0, 75, 600
# create intensity object
crIntensity
To Intensity: 100, 0, "yes"
# create a tone with duration and fundamental frequency
crTone
Create Sound as pure tone: "$1:name", 1, 0, $2:duration, 44100, $3:fundamentalFrequency, 0.2, 0.01, 0.01
$0
#
### graphics
# erase the whole graphics
eraseGraph
Erase all
# draw a sound signal
drSignal
Draw: 0, 0, 0, 0, "yes", "Curve"
# draw intensty
drSignal
Draw: 0, 0, 0, 0, "no"
# draw inner box
drInnerBox
Draw inner box
# set Y step
setYstep
Marks left every: 1, $2, "yes", "yes", "no"
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
$1:Solid line $0
# set y label
setY
Text left: "yes", "$1"
$0
### information window
# write information
print
writeInfoLine: $1
$0
# append information
append
appendInfoLine: $1
$0
# clear information
clear
clearinfo
# output the info window
printInfoWindow
appendFile: "$1:outputFilePath", info$ ( )
$0
### file and directory operations
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
createDirectory: $1:directoryPath
# delete file
deleteFile
deleteFile: $1:filePath
# check file existence and readability
checkFile
fileReadable ($1)
$0
# write line to file
writeLine
writeFileLine: "$1:filePath", $2:content
$0
# append line to file, no need to have the file prexisting
appendLine
appendFileLine: "$1:filePath", $2:content
$0
###
### miscellaneous
# create a form
form
form $1
  $2
endform
$0
# input tab
tab
tab$
# input newline
newLine
newline$
# select an object
selObject
selectObject: $1
$0
# enter edit window
edit
Edit
#
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
$0
#

