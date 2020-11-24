# Fourier synthesis

# form Fourier synthesis of sawtooth wave
#    positive Fundamental_frequency_(Hz) 200
#    integer Number_of_harmonics 40
# endform

# label START

f0 = 200
n = 40

Create Sound from formula... assembly Mono 0 0.5 44100 0
for i to n/2
   rank1 = 2*i-1
   rank2 = rank1+1
   Formula... self + 0.5/'rank1'*sin(2*pi*'rank1'*'f0'*x)
   Formula... self + 0.5/'rank2'*cos(2*pi*'rank2'*'f0'*x)
endfor
#i

# Set rms value at 0.23 Pascal to match with other harmon scripts.
rms = Get root-mean-square... 0 0
Multiply... 0.23/'rms'
Play

Erase all
Select outer viewport... 0 6 0 2.5
Solid line
Draw... 0 0.025 -1 1 no Curve
Draw line... 0 -1 0 1
Dotted line
Draw line... 0 -1 0.025 -1
Solid line

One mark left... 0 yes yes yes
Text bottom... yes Time (s)
Marks bottom every... 1 0.005 yes yes no

To Spectrum (dft)
Select outer viewport... 0 6 2.5 5.5
Draw... 0 10000 0 80 no
Draw line... 0 0 0 80

Marks bottom every... 1 1000 yes yes no
Text bottom... yes Frequency (Hz)
Marks left every... 1 20 yes yes no
Text... -800 Centre 40 Half dB

Select outer viewport... 0 6 0 5.5

plus Sound assembly
# Remove

# beginPause ("Generate waveform")
#    positive ("Fundamental frequency (Hz)", 'f0')
#    positive ("Number_of_harmonics", 'n')
# clicked = endPause ("Stop","Restart", 2, 1)

# if clicked = 2
   # goto START
# endif
