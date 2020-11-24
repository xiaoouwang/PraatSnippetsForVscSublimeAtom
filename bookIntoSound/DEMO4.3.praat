# Violin waveform (fig.4.4)

s1 = Read from file... violinRecirc.wav
s2 = Extract part... 0 0.018 rectangular 1 no

label AGAIN
select s2

Erase all
Select outer viewport... 0 6 0 2.5
Draw... 0 0.02 -0.5 0.5 no Curve
Draw line... 0 -0.5 0 0.5
Draw line... 0 -0.5 0.02 -0.5

One mark left... 0 yes yes no
Dotted line
Draw line... 0 0 0.02 0
Text bottom... yes Time (s)
Marks bottom every... 1 0.005 yes yes no
Solid line

select s1
Play

beginPause ("The waveform")
clicked = endPause ("Stop", "continue", 2,1)

if clicked = 1
   goto STOP
endif

sp = To Spectrum (dft)

Select outer viewport... 0 6 2 4.5
Draw... 0 10000 10 80 no
Marks left every... 1 20 yes yes no
Draw line... 0 10 0 80
Draw line... 0 10 10000 10
Marks bottom every... 1 2000 yes yes no
Text bottom... yes Frequency (Hz)
Text special... -1000 centre 45 half Times 12 0 dB

Select outer viewport... 0 6 0 4.5

beginPause ("Its spectrum")
clicked = endPause ("Stop", "Again", 2, 1)

select sp
Remove

if clicked = 2
   goto AGAIN
else

endif

label STOP
select s1
plus s2
Remove
