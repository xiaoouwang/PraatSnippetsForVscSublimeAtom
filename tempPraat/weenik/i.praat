# select all
# Remove
f1 = 275
# f1 = 400
f2 = 2400
# f2 = 700
antiformant = 800
spectralTilt = 20
# start end fo fn fzn
# Create KlattGrid: "i", 0, 0.5, 4, 1, 1, 6, 1,1 ,1
Create KlattGrid: "i", 0, 0.5, 4, 1, 0, 0, 0, 0, 0
Add pitch point: 0.1, 120
Add pitch point: 0.4, 95
Add open phase point: 0.1, 0.5
Add voicing amplitude point: 0.1, 90
# Add breathiness ampritude point: 0.2, 40
# Add spectral tilt point: 0.1 , spectralTilt
# Add aspiration amplitude point: 0.3, 10
Add oral formant frequency point: 1, 0.1, f1
# doesn't work
# Add oral formant bandwidth point: 1, 0.1, 400
Add oral formant bandwidth point: 1, 0.1, 50
# Add oral formant bandwidth point: 1, 0.1, 63
# Add oral formant bandwidth point: 1, 0.1, 300
Add oral formant frequency point: 2, 0.1, f2
Add oral formant bandwidth point: 2, 0.1, 57
Add oral formant frequency point: 3, 0.1, 2889
Add oral formant bandwidth point: 3, 0.1, 83
Add oral formant frequency point: 4, 0.1, 3400
Add oral formant bandwidth point: 4, 0.1, 80
# Add nasal formant frequency point: 1, 0.1, 900
# Add nasal formant bandwidth point: 1, 0.1, 200
To Sound
Play