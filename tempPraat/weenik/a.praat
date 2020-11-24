# select all
# Remove
antiformant = 800
spectralTilt = 20
f1 = 800
f2 = 1200
f3 = 2100
b3 = 50
b1 = 50
b2 = 60
fn1 = 500
bn1 = 200
amplitude = 90
# start end fo fn fzn
# Create KlattGrid: "i", 0, 0.5, 4, 1, 1, 6, 1,1 ,1
Create KlattGrid: "a", 0, 0.5, 4, 1, 0, 0, 0, 0, 0
Add pitch point: 0.1, 120
Add pitch point: 0.4, 95
Add open phase point: 0.1, 0.5
Add voicing amplitude point: 0.1, 90
# Add breathiness ampritude point: 0.2, 40
Add spectral tilt point: 0.1 , spectralTilt
# Add aspiration amplitude point: 0.3, 10
Add oral formant frequency point: 1, 0.1, f1
# doesn't work
# Add oral formant bandwidth point: 1, 0.1, 400
Add oral formant bandwidth point: 1, 0.1, b1
# Add oral formant bandwidth point: 1, 0.1, 63
# Add oral formant bandwidth point: 1, 0.1, 300
Add oral formant frequency point: 2, 0.1, f2
Add oral formant bandwidth point: 2, 0.1, b2
Add oral formant frequency point: 2, 0.1, f3
Add oral formant bandwidth point: 2, 0.1, b3
# Add oral formant frequency point: 3, 0.1, 2889
# Add oral formant bandwidth point: 3, 0.1, 83
# Add oral formant frequency point: 4, 0.1, 3400
# Add oral formant bandwidth point: 4, 0.1, 152
Add nasal formant frequency point: 1, 0.1, fn1
Add nasal formant bandwidth point: 1, 0.1, bn1
To Sound
Play