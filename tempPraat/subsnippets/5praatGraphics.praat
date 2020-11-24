### graphics beginning
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
$1:Red