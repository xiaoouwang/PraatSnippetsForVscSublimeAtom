# DEMO10.1. (Fig. 10.1)

label START

Create Sound from formula... sine1 1 0 1 44100 sin(2*pi*300*x)
Create Sound from formula... sine2 1 0 1 44100 sin(2*pi*1000*x)
Copy... mult
Formula... self*Sound_sine1[]

select Sound sine1
Erase all
Select inner viewport... 0.5 3 0.5 2
call draw1

To Spectrum (dft)
Select inner viewport... 3.5 6 0.5 2
call draw2

Select inner viewport... 0.5 6 0.5 2
beginPause ("")
   comment ("A sine wave of 300 Hz;")
   comment ("'Continue' will play it.")
clicked = endPause ("Stop","Continue", 2, 1)
if clicked = 1
   exit
endif

select Sound sine1
Multiply... 0.5
Play

select Sound sine2
Select inner viewport... 0.5 3 2.5 4
call draw1

To Spectrum (dft)
Select inner viewport... 3.5 6 2.5 4
call draw2

Select inner viewport... 0.5 6 2.5 4
beginPause ("")
   comment ("And now a sine wave of 1000 Hz;")
   comment ("'Continue' will play it.")
clicked = endPause ("Stop","Continue", 2, 1)
if clicked = 1
   exit
endif

select Sound sine2
Multiply... 0.5
Play

select Sound mult
Select inner viewport... 0.5 3 4.5 6
call draw1

To Spectrum (dft)
Select inner viewport... 3.5 6 4.5 6
call draw2

Select inner viewport... 0.5 6 4.5 6
beginPause ("")
   comment ("The two sine waves multiplied;")
   comment ("'Continue' will play it.")
clicked = endPause ("Stop","Continue", 2, 1)
if clicked = 1
   exit
endif

select Sound mult
Multiply... 0.5
Play


beginPause ("")
   comment ("The 300 Hz and 1000 Hz tones have disappeared.")
   comment ("Again?")
clicked = endPause ("Stop","Yes", 2, 1)
if clicked = 1
   exit
else
   goto START
endif



procedure draw1
   Draw... 0 0.018 -1.1 1.1 no Curve
   Draw line... 0 -1.1 0 1.1
   One mark left... 0 yes yes yes
   Draw line... 0 -1.1 0.018 -1.1
   Marks bottom every... 1 0.005 yes yes no
   Text bottom... yes Time (s)
endproc

procedure draw2
   Draw... 0 2000 30 100 no Curve
   Draw line... 0 30 2000 30
   Draw line... 0 30 0 100
   Marks bottom every... 1 400 yes yes no
   Text bottom... yes Frequency (Hz)
   Marks left every... 1 20 yes yes no
   Text... -150 Centre 70 Half dB
endproc
