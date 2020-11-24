# in absence of any points in these tiers a default open phase of 0.7
# When sound is synthesized a choice has to be made for one of the two. The default is cascade ﬁltering

# is used and the power1 and power2 values are default set to 3 and 4, respectively.
Create KlattGrid: "kg" , 0, 0.3 , 6, 1, 1, 6, 0, 0, 0
# Add open phase point: 0, 0.5
# pitch 120
 Add pitch point: 0.1 , 120
 # voicing amplitude point of 90 dB
 Add voicing amplitude point: 0.1 , 80
 # 100 Hz and ﬂutter = 1, the synthesized pitch may vary between approximately 97 and 103 Hz. Too much
#  Add flutter point: 0.25 , 0.2
# To Sound but it would be no longer manipulable
#  Add voicing amplitude point: 0.1 , 90
#  Play
# bandwidth F1 50 F2 100 F3 120 F4 100
# a
Add oral formant frequency point: 1, 0.1 , 800
# Add oral formant frequency point: 1, 0.2 , 300
# Add oral formant bandwidth point: 1, 0.01 , 500
Add oral formant bandwidth point: 1, 0 , 50
Add oral formant bandwidth point: 1, 0.1 , 50
# Add oral formant bandwidth point: 1, 0.2 , 50
Add oral formant frequency point: 2, 0.1 , 1313
Add oral formant bandwidth point: 2, 0.1 , 50
Add oral formant frequency point: 3, 0.1 , 2582
Add oral formant bandwidth point: 3, 0.1 , 50
Add oral formant frequency point: 4, 0.1 , 3896
Add oral formant bandwidth point: 4, 0.1 , 50
To Sound
Play
# View & Edit
# Create KlattGrid: "kg" , 0, 0.5 , 6, 1, 1, 6, 0, 0, 0
# Add open phase point: 0, 0.5
# # pitch 120
#  Add pitch point: 0.1 , 120
#  # voicing amplitude point of 90 dB
#  Add voicing amplitude point: 0.1 , 7
# Add oral formant frequency point: 1, 0.1 , 953
# Add oral formant bandwidth point: 1, 0.1 , 600
# # Add oral formant bandwidth point: 1, 0.1 , 50
# Add oral formant frequency point: 2, 0.1 , 1860
# Add oral formant bandwidth point: 2, 0.1 , 120
# To Sound
# Play
# au
# Add oral formant frequency point: 1, 0.3 , 300
# Add oral formant frequency point: 2, 0.3 , 600
# Play

# Create KlattGrid: "kg" , 0, 0.3 , 6, 1, 1, 6, 0, 0, 0
# # pitch 120
# Add open phase point: 0, 0.5
#  Add pitch point: 0.1 , 120
#  # voicing amplitude point of 90 dB
#  Add voicing amplitude point: 0.1 , 70
#  Add flutter point: 0.25 , 0.1
#  # Spectral tilt makes it possible to attenuate the higher frequencies. The attenuation is implemented by a ﬁrst order recursive ﬁlter

# # i
# Add oral formant frequency point: 1, 0.1 , 300
# Add oral formant bandwidth point: 1, 0.1 , 50
# Add oral formant frequency point: 2, 0.1 , 2200
# Add oral formant bandwidth point: 2, 0.1 , 50
# Add oral formant frequency point: 3, 0.1 , 3300
# Add oral formant bandwidth point: 3, 0.1 , 50
# Add oral formant frequency point: 4, 0.1 , 4159
# # Add oral formant frequency point: 4, 0.1 , 3400
# Add oral formant bandwidth point: 4, 0.1 , 50
# Play