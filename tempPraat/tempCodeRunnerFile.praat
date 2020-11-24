# create 5 different back a
f1 = 700
f2 = 1000
duration = 0.325
pitch = 140
b1 = 60
b2 = 80
Create KlattGrid: "backa", 0, duration, 5, 1, 1, 0, 0, 0, 0
Add pitch point: 0.15, pitch
Add open phase point: 0.1, 0.5
Add voicing amplitude point: 0.1, 90
Add oral formant frequency point: 1, 0.1, f1
Add oral formant bandwidth point: 1, 0.1, b1
Add oral formant frequency point: 2, 0.1, f2
Add oral formant bandwidth point: 2, 0.1, b2
