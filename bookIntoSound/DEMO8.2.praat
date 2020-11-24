# DEMO8.2. (Fig.8.9)

f0 = 150
pcols = 45000/f0

Create Sound from formula... pulse Mono 0 0.5 45000 0
Formula... if col mod 'pcols' >0 and col mod 'pcols' <3 then 1 else 0 fi
To Spectrum (dft)
Create Sound from formula... dsine 1 0 0.5 45000 exp(-8*pi*x) * sin(2*pi*825*x-pi/3.5)
To Spectrum (dft)

Copy... magnitude
Formula... sqrt(Spectrum_dsine[1,col]^2 + Spectrum_dsine[2,col]^2)
plus Spectrum pulse
Multiply
Rename... zero
To Sound

select Spectrum dsine
plus Spectrum pulse
Multiply
Rename... nonzero
To Sound

# Make rms values equal.
select Sound zero
Scale... 1
level = Get root-mean-square... 0 0
select Sound nonzero
rms = Get root-mean-square... 0 0
Multiply... 'level'/'rms'

label AGAIN
select Sound nonzero

Select outer viewport... 0 6 0 2
Erase all
call draw

text$ = "Spectra of pulse and filter multiplied with phases taken into account..."
call prompt 'text$'
text$ = "sounds like this..."
call prompt 'text$'
Play

text$ = "Spectra of pulse and filter multiplied with phases NOT taken into account..."
call prompt 'text$'
select Sound zero
Select outer viewport... 0 6 2 4

call draw
text$ = "sounds like this..."
call prompt 'text$'
Play

beginPause ("")
clicked = endPause ("Again", "Stop", 2, 1)

if clicked = 1
   goto AGAIN
endif

Select outer viewport... 0 6 0 4



procedure draw
   Draw... 0 0.03 -1 1 no Curve
   Draw line... 0 -1 0 1
   Draw line... 0 -1 0.03 -1
   One mark left... 0 yes yes yes
   Marks bottom every... 1 0.01 yes yes no
   Text bottom... yes Time (s)
endproc

procedure prompt text$
   beginPause ("")
      comment (text$)
   clicked = endPause ("Stop", "Next", 2, 1)

   if clicked = 1
      exit
   endif
endproc


