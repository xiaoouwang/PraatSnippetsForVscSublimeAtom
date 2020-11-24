# a default open phase of 0.7 is used and
# the power1 and power2 values are default set to 3 and 4
# ! glottal source alone
# 0.3s
Create KlattGrid: "12.1" , 0, 0.3 , 6, 1, 1, 6, 0, 0, 0
# pitch
Add pitch point: 0.1 , 120
# intensity
Add voicing amplitude point: 0.1 , 90
# Play
# use 1 value at 0.1 allows extrapolation
Add oral formant frequency point: 1, 0.1 , 800
Add oral formant bandwidth point: 1, 0.1 , 50
Add oral formant frequency point: 2, 0.1 , 1200
Add oral formant bandwidth point: 2, 0.1 , 50
# Play
# diphtongue
# In the interval between times 0.1 and 0.3 s, the oral formant frequencies will be interpolated.
Add oral formant frequency point: 1, 0.3 , 300
Add oral formant frequency point: 2, 0.3 , 600
# Play