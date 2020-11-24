# Demo 20.1.
# Show successive spectral slices from spectrogram.
# Bandwidth Gauss window in Spectrogram = 0.9*F0.

f0 = 200
window = 2*sqrt(6*ln(2))/(pi*0.9*f0)

Read from file: "filtered.wav"

Erase all
call drawSound

To Spectrogram: 'window', 6000, 0.0039, 10, "Gaussian"

obj$ = selected$("Spectrogram")
end = Get finishing time

maxf=6000
startTime=0.1
timeStep=0.0039

numSteps = floor(0.5*(end - startTime) / timeStep)

Select outer viewport: 0, 6, 2, 4.5

erase_spectrum = 0
garn = 1
for i to numSteps
  time = startTime + (i-1) * timeStep
  select Spectrogram 'obj$'
  To Spectrum (slice)... 'time'
  Draw... 0 'maxf' 50 110 no
  if garn = 1
    Draw line: 0, 50, 0, 110
    Draw line: 0, 50, 6000, 50
    One mark bottom: 0, "yes", "yes", "no", ""
      Marks bottom every: 1, 2000, "yes", "yes", "no"

      Marks left every: 1, 20, "yes", "yes", "no"
      Text bottom: "yes", "Frequency (Hz)"
      garn = 0
  endif

  beginPause ("Spectral slices")
    boolean ("Erase spectrum", 'erase_spectrum')
  clicked = endPause ("Stop", "Continue", 2, 1)

  Remove
  if erase_spectrum = 1
    Erase all
    call drawSound
    select Spectrogram 'obj$'
    Select outer viewport: 0, 6, 2, 4.5
    garn = 1
  endif

  if clicked = 1
    exit
  endif
endfor

procedure drawSound
  select Sound filtered
  Select outer viewport: 0, 6, 0, 2
  Draw: 0.1, 0.15, -0.22, 0.22, "no", "Curve"
  Dotted line
  Draw line: 0.096, 0, 0.154, 0
  Solid line
  Text bottom: "yes", "Time"
  Draw arrow: 0.097, 0, 0.096, 0
  Draw arrow: 0.153, 0, 0.154, 0
endproc

