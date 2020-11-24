# DEMO9.1. (Fig.9.1)

label START

Create Sound from formula... dsine1 1 0 0.8 44100 exp(-8*pi*x) * sin(2*pi*825*x-pi/3.5)

Erase all
Select inner viewport... 0.5 3 0.5 2
call draw1


To Spectrum (dft)
Select inner viewport... 3.5 6 0.5 2
call draw2

Select inner viewport... 0.5 6 0.5 2
beginPause ("")
   comment ("Resonator once activated")
   comment ("sounds as follows:")
clicked = endPause ("Stop","Continue", 2, 1)
if clicked = 1
   exit
endif

select Sound dsine1
Play

Create Sound from formula... dsine2 1 0 0.8 44100 exp(-2*pi*x) * sin(2*pi*825*x-pi/3.5)

Select inner viewport... 0.5 3 2.5 4
call draw1

To Spectrum (dft)
Select inner viewport... 3.5 6 2.5 4
call draw2

Select inner viewport... 0.5 6 2.5 4
beginPause ("")
   comment ("Resonator with low damping (B = 2 Hz)")
   comment ("sounds as follows:")
clicked = endPause ("Stop","Continue", 2, 1)
if clicked = 1
   exit
endif

select Sound dsine2
Play

Create Sound from formula... dsine3 1 0 0.8 44100 exp(-35*pi*x) * sin(2*pi*825*x-pi/3.5)

Select inner viewport... 0.5 3 4.5 6
call draw1

To Spectrum (dft)
Select inner viewport... 3.5 6 4.5 6
call draw2

Select inner viewport... 0.5 6 4.5 6
beginPause ("")
   comment ("Resonator with high damping (B = 35 Hz)")
   comment ("sounds as follows:")
clicked = endPause ("Stop","Continue", 2, 1)
if clicked = 1
   exit
endif

select Sound dsine3
Play

beginPause ("")
   comment ("Again?")
clicked = endPause ("Stop","Yes", 2, 1)
if clicked = 1
   exit
else
   goto START
endif


procedure draw1
   Draw... 0 0.6 -1 1 no Curve
   Draw line... 0 -1 0 1
   Draw line... 0 -1 0.6 -1
   Marks bottom every... 1 0.1 yes yes no
   One mark left... 0 yes yes no
   Text bottom... yes Time (s)
endproc

procedure draw2
   Draw... 0 2000 10 80 no Curve
   Draw line... 0 10 2000 10
   Draw line... 0 10 0 80
   Marks bottom every... 1 400 yes yes no
   Text bottom... yes Frequency (Hz)
   Marks left every... 1 20 yes yes no
   Text... -150 Centre 50 Half dB
endproc
