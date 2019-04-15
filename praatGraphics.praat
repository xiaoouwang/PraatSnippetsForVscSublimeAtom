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
