# DEMO27.2

Read from file: "thumpInMusic.Sound"
obj$ = selected$("Sound")
pause$ = "Example with high intensity low frequency components"

beginPause: pause$
  comment ("You will hear a short music section.")
  comment ("Make sure that the Playing of sound in Windows is ok.")
action = endPause: "Stop", "Continue", 2, 1

if action = 2
  select Sound 'obj$'
  Play
else
  exit
endif

label START
beginPause: pause$
  comment ("")
action = endPause: "Stop", "Play again", "Continue", 2, 1

if action = 2
  select Sound 'obj$'
  Play
  goto START
elsif action = 1
  exit
endif

beginPause: pause$
  comment ("Now you will hear the sound while the waveform is displayed.")
action = endPause: "Stop", "Continue", 2, 1

if action = 1
  exit
endif

View & Edit

editor: "Sound 'obj$'"
  Show analyses: "no", "no", "no", "no", "no", 10
  Pitch settings: 150, 500, "Hertz", "autocorrelation", "automatic"
  Intensity settings: 40, 100, "mean energy", "no"
  label AGAIN
  Play window
  beginPause:""
  action = endPause: "Stop", "Play again", 2, 1
  if action = 2
    goto AGAIN
  endif
endeditor

exit


