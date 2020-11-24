# DEMO19.1.

Erase all
d = 1
Create Sound as tone complex: "toneComplex", 0, d, 44100, "cosine", 220, 0, 0, 0
Subtract mean
Multiply: 0.5

source1 = Filter (de-emphasis): 100

Filter (one formant): 1200, 150
text1$ = "The formant frequency falls about midway between adjacent F0 harmonics."
text2$ = "The bandwidth is 150 Hz. Select Play to hear it."
call prompt

select source1
Filter (one formant): 1200, 50
text1$ = "The same formant frequency and F0 but now the bandwidth is 50 Hz instead of 150 Hz."
text2$ = ("Select Play to hear it.")
call prompt

select source1
Filter (one formant): 1100, 150
text1$ = "Now the formant frequency coincides with the 5th harmonic."
text2$ = "The bandwidth is 150 Hz.Select Play to hear it."
call prompt

select source1
Filter (one formant): 1100, 50
text1$ = "The same but now the bandwidth is 50 Hz."
text2$ = ("Select Play to hear it.")
call prompt

d = 1.5
f0start = 190
f0end = 110
# Make pulse train.
Create PitchTier... pulseTrain 0 'd'
Add point... 0 'f0start'
Add point... 'd' 'f0end'
#source2 = To Sound (phonation): 44100, 1, 0.05, 0.7, 0.03, 3, 4, "no"
To Sound (pulse train)... 44100 1 0.05 2000 no
source2 = Filter (de-emphasis): 100
Multiply: 0.5

text1$ = "/a/ sound with formant bandwidths of 1/12 of formant frequency."
text2$ = ("Select Play to hear it.")
relB = 1/12
call formants
call prompt

text1$ = "/a/ sound with formant bandwidths of 1/36 of formant frequency."
text2$ = ("Select Play to hear it.")
relB = 1/36
call formants
call prompt

exit

procedure prompt
  label AGAIN
  beginPause ("BANDWIDTH TEST")
    comment (text1$)
    comment (text2$)
  clicked = endPause ("Stop", "PLAY", "Next", 3, 2)

   if clicked = 1
      exit
   elsif clicked = 2
      Play
      goto AGAIN
   endif
endproc


procedure formants
  f1 = 900
  f2 = 1300
  f3 = 2450
  f4 = 3600

  select source2
  for i to 4
    Filter (one formant): f'i', f'i'*relB
  endfor
endproc



Create Sound as tone complex: "toneComplex", 0, 1, 44100, "cosine", 220, 0, 0, 0
source2 = Filter (de-emphasis): 100



# Make pulse train.
Create PitchTier... pulseTrain 0 'd'
Add point... 0 'f0start'
Add point... 'd' 'f0end'
To Sound (pulse train)... 44100 1 0.05 2000 no
Subtract mean

##To Sound (phonation): 44100, 1, 0.05, 0.7, 0.03, 3, 4, "no"

source = Filter (de-emphasis): 100
##source = Copy... source

# Filter with formant values
call filter
Rename... q12
Play

select source
q = 36
call filter
Rename... q36
Play

procedure filter
   count = 0
   for i from 1 to 5
      b = f'i'/q
      Filter (one formant)... f'i' 'b'
      count += 1
   endfor
endproc

