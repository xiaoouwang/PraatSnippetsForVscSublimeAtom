### object creation beginning
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
Rename: $0:newname
# random integer
randomInteger
randomInteger (1, 1000)
# show pulses
showPulses
Show pulses
# spec,f0,intensi,f,p
showAnalysis
Show analyses... yes no no yes yes 20.0
# random real
randomReal
randomUniform (1, 10)
# convert to number
convertNumber
number($1:stringToConvert)
# convert to string
convertString
string($2:numberToConvert)
# minus an object
minus
minusObject: $1
# remove an object without selecting
removeObject
removeObject: $0
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
# number array
arrayNum
squares# = { 1, 4, 9, 16, 25 }
for i from 1 to size(squares#)
  appendInfoLine: squares#[i]
endfor
# string array
arrayStr
$text[i] = "hehe"
# get selected name
getSelectedName
selected$ ("$0:type")
# get selected id
getSelectedId
selected ("$0:number")
# get selected full name
getSelectedFullName
fullName$ = selected$ ()
type$ = extractWord$ (fullName$, "")
name$ = extractLine$ (fullName$, " ")
# selected textgrids
rtSelectedTextgrid
select all
textgrids# = selected# ("TextGrid")
for i from 1 to size (textgrids#)
  selectObject: textgrids# [i]
  $0
endfor
# selected sounds
rtSelectedSound
select all
sounds# = selected# ("Sound")
for i from 1 to size (sounds#)
  selectObject: sounds# [i]
  $0
endfor
# do to all textgrids
rtAllTextgridObjects
textgrids# = selected #("TextGrid")
for iii from 1 to size (textgrids#)
  selectObject: textgrids# [iii]
	$0
endfor
# variable exist
existVariable
variableExists ($0)
# get right string
getRight
right$ (1$, $0:n)
# get left string
getLeft
left$ (1$, $0:n)
# get middle string
getMiddle
mid$ ($1 , 3, $0:2c)
# length
lengthString
length ($0)
# get length string
getLenStr
length ($0)
# get right index
getRightIndex
rindex ($1:searchAt, $0:searchFor)
# get left index
getLeftIndex
index ($1:searchAt, $0:searchFor)
# horizontal
horizontal
appendInfoLine: "----------------"
# get number of strings
getNbStr
nbOfStr = Get number of strings
# loop string
rtLoopStr
noOfStr = Get number of strings
for i from 1 to nbOfStr
	selectObject: fList
	fName$ = Get string: i
	f = Read from file: dir$ + "/" + fName$
	# do
endfor
# get string
getStr
Get string: $0:row
# get label
getLabel
Get label of interval: $1:tier, $0:interval
# get label at time
getIntervalTime
Get interval at time: $1:tier, $0:time
# get label editor
getLabelEdit
Get label of interva
# get label editor
getIntervalEdit
Get label of interval
# set label
setLabel
Set interval text: $1:tier, $2:interval, $3:text
# set label editor
setLabelEdit
Set interval text:
# get label
getInterval
Get label of interval: $1:tier, $0:interval
# set label
setInterval
Set interval text: $1:tier, $2:interval, $3:text
# extract one channel
extractChannel
Extract one channel: $0
# extract all channels
extractAllChannels
Extract all channels
# done
done
appendInfoLine: "done! $0"
# duplicate tier
dupTier
Duplicate tier: 1, 2, "$0:name"
# remove tier
rmTier
Remove tier: $0
# stereo
stereo
Combine to stereo