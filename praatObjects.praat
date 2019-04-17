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
