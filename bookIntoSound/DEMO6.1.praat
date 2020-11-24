Create Sound from formula... sine1 1 0 1 44100 1/2 * sin(2*pi*300*x)
Create Sound from formula... sine2 1 0 1 44100 1/2 * sin(2*pi*800*x)
select Sound sine1
plus Sound sine2
Multiply by window... Gaussian2
Concatenate
To Spectrum (dft)

select Sound sine2
Copy... sum
Formula... self+Sound_sine1[]

Create Sound from formula... embed 1 0 2 44100 0
Formula... self+Sound_sum(x-0.5)

Rename... sumLong
To Spectrum (dft)

select Sound chain
Erase all
Select outer viewport... 0 6 0 2
Solid line
Draw... 0 2 -1 1 no Curve
Draw line... 0 -1 0 1
Dotted line
Draw line... 0 -1 2 -1
Solid line
One mark left... 0 yes yes yes 
Text bottom... yes Time (s)
Marks bottom every... 1 0.2 yes yes no

text$ = "One after another..."
call prompt 'text$'

Play

text$ = "Its spectrum..."
call prompt 'text$'

select Spectrum chain
Select outer viewport... 0 6 2 4
Draw... 0 3000 -10 80 no
Draw line... 0 -10 0 80

Text bottom... yes Frequency (Hz)
Marks left every... 1 20 yes yes no
Text... -250 Centre 37 Half dB
One mark bottom... 0 yes yes no 
One mark bottom... 300 yes yes no 
One mark bottom... 800 yes yes no 
One mark bottom... 3000 yes yes no 

text$ = "The two sounds added..."
call prompt 'text$'

select Sound sumLong
Select outer viewport... 0 6 4 6
Solid line
Draw... 0 2 -1 1 no Curve
Draw line... 0 -1 0 1
Dotted line
Draw line... 0 -1 2 -1
Solid line
One mark left... 0 yes yes yes 
Text bottom... yes Time (s)
Marks bottom every... 1 0.2 yes yes no

Play

text$ = "Its spectrum is the same."
call prompt 'text$'

select Spectrum sumLong
Select outer viewport... 0 6 6 8
Draw... 0 3000 -10 80 no
Draw line... 0 -10 0 80

Text bottom... yes Frequency (Hz)
Marks left every... 1 20 yes yes no
Text... -250 Centre 37 Half dB
One mark bottom... 0 yes yes no 
One mark bottom... 300 yes yes no 
One mark bottom... 800 yes yes no 
One mark bottom... 3000 yes yes no 


procedure prompt text$
   beginPause ("")
      comment (text$)
   clicked = endPause ("Stop", "Next", 2, 1)

   if clicked = 1
      exit
   endif
endproc

