# select all
# Remove
f1 = 270
f2 = 2300
f3 = 2900
f4 = 3700
f5 = 4500
b1 = 60
b2 = 80
b3 = 150
b4 = 170
b5 = 250
nf1 = 400
steps =
# change here
for
nz1 = 400
bnf1 = 100
bnz1 = 100
duration = 0.325
antiformant = 800
# start end fo fn fzn
Create KlattGrid: "i", 0, duration, 5, 1, 1, 0, 0, 0, 0
Add pitch point: 0.02, 140
Add pitch point: 0.05, 150
Add pitch point: 0.28, 120
Add open phase point: 0.1, 0.5
Add voicing amplitude point: 0.1, 90
Add oral formant frequency point: 1, 0.1, f1
Add oral formant bandwidth point: 1, 0.1, b2
Add oral formant frequency point: 2, 0.1, f2
Add oral formant bandwidth point: 2, 0.1, b3
Add oral formant frequency point: 3, 0.1, f3
Add oral formant bandwidth point: 3, 0.1, b3
Add oral formant frequency point: 4, 0.1, f4
Add oral formant bandwidth point: 4, 0.1, b4
Add oral formant frequency point: 5, 0.1, f5
Add oral formant bandwidth point: 5, 0.1, b5
Add nasal formant frequency point: 1, 0.1, nf1
Add nasal formant bandwidth point: 1, 0.1, bnf1
Add nasal antiformant frequency point: 1, 0.1, nz1
Add nasal antiformant bandwidth point: 1, 0.1, bnz1
To Sound
Play