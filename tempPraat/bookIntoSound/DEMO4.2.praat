# Demo4.2. Fourier synthesis (fig.4.3)

# form Fourier synthesis of sawtooth wave
#    positive Fundamental_frequency_(Hz) 200
#    integer Number_of_harmonics 40
# endform

dB_range = 80

# label START

f0 = 200
n = 40

Create Sound from formula... assembly Mono 0 0.5 44100 0
for i to n
   Formula... self + 0.5/'i'*sin(2*pi*'i'*'f0'*x)
endfor

# Set rms value at 0.25 Pa to make volume indep. of # of harmon.
rms = Get root-mean-square... 0 0
Multiply... 0.25/'rms'
Play

To Spectrum (dft)

Erase all
Select outer viewport... 0 6 0 2.5
Solid line
Draw... 0 10000 80-'dB_range' 80 no
Draw line... 0 80-'dB_range' 0 80
Draw line... 0 80-'dB_range' 10000 80-'dB_range'

Marks bottom every... 1 1000 yes yes no
Text bottom... yes Frequency (Hz)
Marks left every... 1 20 yes yes no
Text... -800 Centre 80-'dB_range'/2 Half dB

select Sound assembly
Select outer viewport... 0 6 2 4.5
Draw... 0 0.025 -1 1 no Curve
Draw line... 0 -1 0 1
Draw line... 0 -1 0.025 -1
Dotted line
Draw line... 0 0 0.025 0
Solid line

One mark left... 0 yes yes yes
Text bottom... yes Time (s)
Marks bottom every... 1 0.005 yes yes no

Select outer viewport... 0 6 0 4.5

plus Spectrum assembly
# Remove

# beginPause ("Generate waveform")
#    positive ("Fundamental frequency (Hz)",'f0')
#    positive ("Number of harmonics", 'n')
#    positive ("dB range", 'dB_range')
# clicked = endPause ("Stop","Restart", 2, 1)

# if clicked = 2
#    goto START
# endif
