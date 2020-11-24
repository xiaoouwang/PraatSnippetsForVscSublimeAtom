# DEMO8.1. (fig.8.6 and 8.7)


label START
f0 = 8
pcols = 40000/f0

Create Sound from formula... pulse1 Mono 0 1 40000 0
Formula... if col mod 'pcols' >0 and col mod 'pcols' <3 then 1 else 0 fi

Select outer viewport... 0 6 0 2
Erase all
call draw1

text$ = "Very short excitation pulses..."
call prompt 'text$'

To Spectrum (dft)
Create Sound from formula... dsine 1 0 1 40000 exp(-8*pi*x) * sin(2*pi*825*x-pi/3.5)
To Spectrum (dft)
plus Spectrum pulse1
Multiply
To Sound
Scale... 0.9

Select outer viewport... 0 6 2 4

call draw1

text$ = "activate the resonator, and sound like this..."
call prompt 'text$'

Play

To Spectrum (dft)
To Ltas (1-to-1)

Select outer viewport... 0 6 4 6
call draw3

text$ = "and in its spectrum the spectral lines are very close to each other."
call prompt 'text$'

select Spectrum dsine
Red
Line width... 2
Draw... 0 2000 3 73 no
Black
Line width... 1

text$ = "The resonator filter function is approximated very well (red curve)."
call prompt 'text$'

f0 = 200
pcols = 40000/f0

Create Sound from formula... pulse2 Mono 0 1 40000 0
Formula... if col mod 'pcols' >0 and col mod 'pcols' <3 then 1 else 0 fi

Select outer viewport... 0 6 0 2
Erase all
call draw2

To Spectrum (dft)
plus Spectrum dsine
Multiply
snd2 = To Sound
Scale... 0.9

Select outer viewport... 0 6 2 4
call draw2
Select outer viewport... 0 6 0 4

text$ = "A much faster repetition rate (has been 'zoomed in' to see more details)..."
call prompt 'text$'

To Spectrum (dft)
To Ltas (1-to-1)
Formula... self-26

Select outer viewport... 0 6 4 6
call draw3

select Spectrum dsine
Red
Draw... 0 2000 3 73 no
Black

text$ = "has its spectral lines much more apart. This sounds very different..."
call prompt 'text$'

select snd2
Play

beginPause ("")
clicked = endPause ("Stop", "Again", 2, 1)

if clicked = 1
  exit
else
  goto START
endif



procedure prompt text$
   beginPause ("")
      comment (text$)
   clicked = endPause ("Stop", "Next", 2, 1)

   if clicked = 1
      exit
   endif
endproc

procedure draw1
   Draw... 0 0.48 -1 1 no Curve
   Draw line... 0 -1 0.48 -1
   One mark left... 0 yes yes yes
   One mark bottom... 0 no yes no 0
   One mark bottom... 1/8 no yes no 1/8
   One mark bottom... 2/8 no yes no 2/8
   One mark bottom... 3/8 no yes no 3/8
   Text bottom... yes Time (s)
endproc

procedure draw2
   Draw... 0 0.1 -1 1 no Curve
   Draw line... 0 -1 0.1 -1
   One mark left... 0 yes yes yes
   Marks bottom every... 1 0.01 yes yes no
   Text bottom... yes Time (s)
endproc

procedure draw3
   Draw... 0 2000 20 90 no Curve
   Draw line... 0 20 2000 20
   Draw line... 0 20 0 90
   Marks bottom every... 1 400 yes yes no
   Text bottom... yes Frequency (Hz)
   Marks left every... 1 20 yes yes no
   Text... -150 Centre 55 Half dB
endproc

