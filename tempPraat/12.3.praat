Remove tier: 3
kg = Create KlattGrid: "12.3" , 0, 1, 6, 1, 1, 6, 0, 0, 0
Add pitch point: 0.5 , 100
Add voicing amplitude point: 0.5, 90
for i to 11
  spectralTilt = (i - 1) * 5
  selectObject: kg
  Add spectral tilt point: 0.5,spectralTilt
  To Sound
  To Spectrum: "no"
  dif[i] = Get band density difference: 98, 102, 2998, 3002
  dif = 0
  if i > 1
    dif = dif[1] - dif[i]
  endif
  #...
  Remove spectral tilt points: 0, 1
  #...
endfor