# DEMO 16.1. (Fig.16.6). Noise suppression by ac.

f1=400
f2=600
f3=800
f4=1200
#s1 = Create Sound from formula... chord Mono 0 1 192000
s1 = Create Sound from formula... chord Mono 0 1.1 44100
... sin(2*pi*'f1'*x)+sin(2*pi*'f2'*x)+cos(2*pi*'f3'*x)
... +cos(2*pi*'f4'*x)
Scale peak... 0.7

label START

Erase all
Black
Line width... 1
Times

# Draw part.
Select outer viewport... 0 5.5 0 2
call draw
s2 = Extract part: 0, 1, "rectangular", 1, "no"

beginPause ("")
   comment ("This chord waveform sounds like this)...")
clicked = endPause ("Stop", "Next", 2, 1)

if clicked = 1
   exit
endif

Play

# Add noise with 2 dB power above signal's.
select s1
rms = Get root-mean-square... 0 0
Formula... self+randomGauss(0,1.25*'rms')
Scale peak... 1

beginPause ("")
   comment ("A fair amount of noise added...")
clicked = endPause ("Stop", "Next", 2, 1)

if clicked = 1
   exit
endif

Select outer viewport... 0 5.5 1.5 3.5
call draw

beginPause ("")
   comment ("sounds like this...")
clicked = endPause ("Stop", "Next", 2, 1)

if clicked = 1
   exit
endif

Play

#ac.
select s1
Extract part... 1 1.1 rectangular 1 no
Rename... noisypart
select s1
Copy... chord2
plus Sound noisypart
Cross-correlate... "peak 0.99" zero
Rename... ac
##Extract part... 0.2 0.23 rectangular 1 no
Extract part... 0 0.999 rectangular 1 no
Scale peak... 0.9

beginPause ("")
   comment ("Autocorrelated...")
clicked = endPause ("Stop", "Next", 2, 1)

if clicked = 1
   exit
endif

Select outer viewport... 0 5.5 3 5
call draw

beginPause ("")
   comment ("sounds like this...")
clicked = endPause ("Stop", "Next", 2, 1)

if clicked = 1
   exit
endif

Play

# Convolve.
select Sound noisypart
plus Sound ac
cv = Convolve... integral zero
Scale peak... 0.9
Extract part... 0.2 0.23 rectangular 1 no

beginPause ("")
   comment ("Convolved...")
clicked = endPause ("Stop", "Next", 2, 1)

if clicked = 1
   exit
endif

Select outer viewport... 0 5.5 4.5 6.5
call draw

beginPause ("")
   comment ("sounds like this...")
clicked = endPause ("Stop", "Next", 2, 1)

if clicked = 1
   exit
endif

select cv
Extract part... 0.07 1.03 rectangular 1 no

Play
Select outer viewport... 0 5.5 0 6.5


procedure draw
   12
   Solid line
   Draw... 0 0.03 -1 1 no Curve
   Draw line... 0 -1 0 1
   Draw line... 0 -1 0.03 -1
   One mark left... 0 yes yes no
   execute drawDottedLine.script 16 0 0 0.03 0
   Marks bottom every... 1 0.005 no yes no
   Text special... 0.015 centre -1.4 half Times 12 0 Time
   Text special... 0.0075 centre -1.4 half Times 12 0 5ms
   Draw line... 0.005 -1.2 0.005 -1.6
   Draw line... 0.01 -1.2 0.01 -1.6
endproc

