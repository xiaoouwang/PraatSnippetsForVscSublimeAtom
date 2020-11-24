# DEMO_acoustics.


Read from file: "femDry.Sound"
Read from file: "s1_r1_b_44k1_mod.Sound"
plus Sound femDry
Convolve: "peak 0.99", "zero"
Rename... spacy

label START

Erase all
select Sound femDry

beginPause ("")
   comment ("A recording without reverberation")
   comment ("  made in an anechoing room.")
   comment ("'Continue' will play it.")
clicked = endPause ("Stop","Continue", 2, 1)
if clicked = 1
   exit
endif

Play

select Sound s1_r1_b_44k1_mod

Select inner viewport: 0.5, 5.5, 0.5, 3
Draw: 0, 1.5, -1, 1, "no", "Curve"
Draw line... 0 -1 0 1
Draw line... 0 -1 1.5 -1
One mark left... 0.5 no yes no 0
One mark left... -0.5 no yes no 0
One mark right... 0.5 no no no left
One mark right... -0.5 no no no right
Marks bottom every... 1 0.1 yes yes no
Text bottom... yes Time (s)
Text top: "yes", "Impulse responses"


beginPause ("")
   comment ("The church's impulse responses for left and right;")
   comment ("'Continue' will play the convolution result.")
clicked = endPause ("Stop","Continue", 2, 1)
if clicked = 1
   exit
endif

select Sound spacy

Play

beginPause ("")
   comment ("")
   comment ("")
clicked = endPause ("Stop","Again?", 2, 1)
if clicked = 1
   exit
endif
goto START
