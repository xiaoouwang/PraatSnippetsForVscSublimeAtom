# KlattGrid_create_a_and_au.praat
# Ils vibrent en moyenne 120 fois par seconde chez l ’ homme adulte, 240 fois chez la femme , 350 fois chez l ’enfant , 400 fois ou plus chez le nouveau-né.
# Read from file: "a50.wav"
# a series of a with varing pitch and fixed formant 830/1438
pitchBase = 50
while pitchBase < 400
  @bwGenerate: pitchBase
  pitchBase += 50
endwhile

procedure bwGenerate: pitch
Create KlattGrid: "a" + string$(pitch), 0, 0.3, 6, 1, 1, 6, 1, 1, 1
Add pitch point: 0.1, pitch
Add voicing amplitude point: 0.1, 90
Add oral formant frequency point: 1, 0.1, 850
Add oral formant bandwidth point: 1, 0.1, 50
Add oral formant frequency point: 2, 0.1, 1638
Add oral formant bandwidth point: 2, 0.1, 50
To Sound
thisSound$ = selected$("Sound")
Save as WAV file: thisSound$ + ".wav"
endproc
