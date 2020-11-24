# DEMO 25.1.

Read from file: "spectralSubtr.Collection"

selectObject: "Sound si1901"
sound$ = selected$("Sound")
len = Get total duration
toptext$ = "Clean recording (max S/N = 58dB)"
pause$ = "  A normal recorded sentence; (max. S/N ratio is about 58 dB)"
href = 0.5
vref = 0.5
Erase all
call displayA

selectObject: "Sound sn6db"
sound$ = selected$("Sound")
len = Get total duration
toptext$ = "Noisy recording (max S/N = 14dB)"
pause$ = "  Noise added: max. S/N ratio is about 14 dB"
Erase all
call displayA

selectObject: "Sound sn6db_nr"
sound$ = selected$("Sound")
len = Get total duration
toptext$ = "Denoised (max S/N = 55dB)"
pause$ = "  Denoised: max. S/N ratio is now about 55 dB"
href = 0.5
vref = 4
call displayA

selectObject: "Sound sn0db"
sound$ = selected$("Sound")
len = Get total duration
toptext$ = "Noisy recording (max S/N = 10dB)"
pause$ = "  More noise added: max S/N ratio is about 10 dB"
href = 0.5
vref = 0.5
Erase all
call displayA

selectObject: "Sound sn0db_nr"
sound$ = selected$("Sound")
len = Get total duration
toptext$ = "Denoised (max S/N = 48dB)"
pause$ = "  Denoised: max S/N ratio is now about 48 dB but distortion is high"
href = 0.5
vref = 4
call displayA

label AGAIN
Erase all
beginPause ("Listen again to sounds")
  comment ("You can select a sound to listen to it.")
  action = endPause: "Stop", "Clean", "Noisy1", "Result1", "Noisy2",
  ... "Result2", 2, 3

if action = 2
  select Sound si1901
  Play
  goto AGAIN
elsif action = 3
  select Sound sn6db
  Play
  goto AGAIN
elsif action = 4
  select Sound sn6db_nr
  Play
  goto AGAIN
elsif action = 5
  select Sound sn0db
  Play
  goto AGAIN
elsif action = 6
  select Sound sn0db_nr
  Play
  goto AGAIN
else
  exit
endif


procedure displayA
  Select inner viewport: href, href+5, vref, vref+1.5
  Draw: 0, 0, -0.9, 1, "no", "Curve"
  Draw line: 0, -0.8, 0, 1
  One mark left: 0, "yes", "yes", "no", ""
  Text right: "no", "waveform"
  Text: 1.5, "Centre", 1.25, "Half", toptext$

  To Intensity: 90, 0, "yes"
  Select inner viewport: href, href+5, vref+1.5, vref+2.5
  Draw: 0, 0, 20, 90, "no"
  Draw line: 0, 20, 0, 90
  Draw line: 0, 20, len, 20
  Marks left every: 1, 20, "yes", "yes", "no"
  Marks bottom every: 1, 0.5, "yes", "yes", "no"
  Text: -0.23, "Centre", 50, "Half", "dB"
  Text right: "no", "intensity"
  Text: 1.5, "Centre", -5, "Half", "Time (s)"

  Select inner viewport: href, href+5, vref, vref+2.5

  label START
  beginPause (pause$)
    comment ("You can click 'Play' to listen to it.")
    action = endPause: "Stop", "Play", "Continue", 2, 3
  if action = 2
    select Sound 'sound$'
    Play
    goto START
  elsif action = 1
   exit
  endif
endproc

