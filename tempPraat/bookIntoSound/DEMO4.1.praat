# Demo4.1. Fourier synthesis (fig.4.1)

# form Fourier synthesis of triangle wave
#    positive Fundamental_frequency_(Hz) 200
#    integer Number_of_components 10
# endform


# f0 = fundamental_frequency
# n = number_of_components

f0 = 200
n = 10

label START

Create Sound from formula... assembly Mono 0 0.5 44100 0
for i to n
   rank=2*i-1
   Formula... self + 0.5/'rank'^2*cos(2*pi*'rank'*'f0'*x)
endfor

Play

To Spectrum (dft)

Erase all
Select outer viewport... 0 6 0 2.5
Solid line
Draw... 0 10000 0 84 no
Draw line... 0 0 0 80

Marks bottom every... 1 1000 yes yes no
Text bottom... yes Frequency (Hz)
Marks left every... 1 20 yes yes no
Text... -800 Centre 40 Half dB

for i to n
   rank = 2*i-1
   h = 200*rank
   if h < 10000
      v = -38*log10('h'/35934)
      Text special... 'h' centre 'v' half Times 10 0 'rank'
   endif
endfor

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
#    positive ("Fundamental frequency (Hz)", 'f0')
#    positive ("Number of components", 'n')
# clicked = endPause ("Stop", "Restart", 2, 1)

# if clicked = 2
#    f0 = fundamental_frequency
#    n = number_of_components
#    goto START
# endif
