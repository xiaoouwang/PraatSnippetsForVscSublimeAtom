# in absence of any points in these tiers a default open phase of 0.7
# When sound is synthesized a choice has to be made for one of the two. The default is cascade ﬁltering

# is used and the power1 and power2 values are default set to 3 and 4, respectively.
Create KlattGrid: "kg" , 0, 0.5 , 6, 1, 1, 6, 0, 0, 0
Add open phase point: 0, 0.5
# pitch 120
Add pitch point: 0.1 , 120
# voicing amplitude point of 90 dB
Add voicing amplitude point: 0.1 , 70
# Add oral formant frequency point: 1, 0.1 , 267
# Add oral formant bandwidth point: 1, 0.1 , 50
# Add oral formant frequency point: 2, 0.1 , 2310
# Add oral formant bandwidth point: 2, 0.1 , 50
Add oral formant frequency point: 3, 0.1 , 3395
Add oral formant bandwidth point: 3, 0.1 , 50
Add oral formant frequency point: 4, 0.1 , 3500
Add oral formant bandwidth point: 4, 0.1 , 50
To Sound
Play