# select all
# Remove
# f1 = 400
f1 = 480
f2 = 1340
f3 = 2470
b1 = 40
b2 = 300
b3 = 300
# f4 = 2600
# f2 = 700
fnp = 270
fnz = 800
spectralTilt = 20
amp = 50
# start end fo fn fzn
# Create KlattGrid: "i", 0, 0.5, 4, 1, 1, 6, 1,1 ,1
Create KlattGrid: "n", 0, 0.5, 0, 4, 2, 0, 0, 0, 0
# Add pitch point: 0.1, 120
Add pitch point: 0.4, 120
Add open phase point: 0.1, 0.5
Add voicing amplitude point: 0.1, amp
Add nasal formant frequency point: 1, 0.1, fnp
Add nasal formant bandwidth point: 1, 0.1, 100
# Add breathiness ampritude point: 0.2, 40
# Add spectral tilt point: 0.1 , spectralTilt
# Add aspiration amplitude point: 0.3, 10
# Add nasal formant frequency point: 2, 0.1, f1
# Add nasal formant bandwidth point: 2, 0.1, b1
# Add nasal antiformant frequency point: 1, 0.1, fnz
# Add nasal antiformant bandwidth point: 1, 0.1, 100
# Add oral formant bandwidth point: 1, 0.1, 63
# Add oral formant bandwidth point: 1, 0.1, 300
Add nasal formant frequency point: 3, 0.1, f2
Add nasal formant bandwidth point: 3, 0.1, b2
# Add nasal formant frequency point: 4, 0.1, f3
# Add nasal formant bandwidth point: 4, 0.1, b3
# Add nasal formant frequency point: 1, 0.1, 900
# Add nasal formant bandwidth point: 1, 0.1, 200
To Sound
Play