# F0-controlled bandfilter analysis script for the program 'Praat'.
# Sound editor script.
# Produces an envelope spectrum approximation from a few F0 periods of
#    an utterance around a user selected position in the Sound editor.

# INSTRUCTIONS FOR ADDING A BUTTON IN PRAAT'S SOUND EDITOR
# 1. Copy this script in a suitable directory and close this current script window.
# 2. Open the Sound editor for a present Sound object in Praat (doesn't matter which sound).
# 	(If there is no Sound object, create one.)
# 3. In its File menu select "Open editor script..."
# 4. Select the just copied script in your chosen directory and click "Open".
# 5. Now in the popped up script select the menu "File" and then "Add to menu..."
# 6. In the popped up window at the 2nd line ("Menu") fill in "Spectrum" (because that is
#	where you want to have this option).
# 7. At the 3rd line fill in how the command is to be named (say,
#	"View envelope spectrum at cursor...", because that is what it does).
#	(Don't forget the 3 dots: it means that a fill-in screen will emerge.)

# That's it. Close the Sound editor and open it anew. Now you see under the
#	menu Spectrum your new button.
# To use this button you must make sure that the sound editor displays the pitch contour
#	and that its parameters are set correctly; otherwise the script works from
#	wrong period lengths and the envelope spectrum makes no sense.


form F0-controlled Gauss BF envelope spectrum
   comment Method: moving Gauss window on DFT components of F0 periods.
   comment Take care of the right pitch settings!
   comment The specified number of periods around the cursor position, c.q. around
   comment    the mid position of the selection, are extracted automatically.
   comment MAKE SURE THAT NO OTHER EDITOR IS OPEN FOR THE SAME SOUND OBJECT!
   comment
   natural Segment_length_(number_of_F0_periods) 3
   positive Effective_filter_width_/F0_(Hz) 1.1
   positive Highest_frequency_(Hz) 6000
   boolean Pre-emphasis_6dB/oct no
   boolean Draw_spectrum no
endform


# shorten variables
numper = segment_length
bwcorr = 'Effective_filter_width_/F0'
fhi = highest_frequency
pe = 'Pre-emphasis_6dB/oct'

pos = Get cursor
f0 = Get pitch
if f0 = undefined
   pause No pitch detected. F0 set at 200Hz.
   f0 = 200
endif
per = 1/f0

# extract periods
leftish = pos-numper/2*per
rightish = leftish + numper*per
Select... leftish rightish
Extract selected sound (preserve times)
endeditor
# look for zero crossing adjacent to high peak, minimalizing noise influence
Rename... approx
leftpeakpos = Get time of maximum... 'leftish' 'leftish'+per None
editor
Select... leftpeakpos rightish
Move start of selection to nearest zero crossing
Move cursor to start of selection
Move end of selection by... 'numper'*'per'
Move end of selection to nearest zero crossing
Extract selected sound (windowed)... segment Hanning 1 no
endeditor

d = Get duration
newf0 = numper/d
f0ratio = abs(newf0/f0)
if f0ratio < 0.8 or f0ratio > 1.2
   exit No zero crossings can be found at segment boundaries for this position.
endif

# take rms for calibration
rms = Get root-mean-square... 0 0

To Spectrum... no
if pe = 1
     Formula... if x>50 then self*x/50 else self fi
endif

# calibrate spectral level
energy = Get band energy... 0 0
newrms = sqrt(energy/d)
Formula... self*'rms'/'newrms'

Copy... mult
bin = Get bin width

# calc. parameters for Gauss window
fbw = bwcorr*newf0
asquare = 2*ln(2)/fbw^2

# set up Matrix for spectral values
fstep = newf0/3
numsteps = ceiling(fhi/fstep)+1
Create Matrix... spectrum 0 ('numsteps'-1)*'fstep' 'numsteps'
... 'fstep' 0 1 2 2 1 1 0

# calculate spectral values
for step to numsteps
   f = (step-1)*fstep
   select Spectrum mult
   Formula... Spectrum_segment()*exp(-'asquare'*(x-'f')^2)
   energy = Get band energy... 0 0
   # convert to spectral component (noise bw = 1.056 * 3dB bw)
   specComp = sqrt(energy/1.056)
   # filling one row suffices: second remains 0
   select Matrix spectrum
   Set value... 1 'step' 'specComp'
endfor

To Spectrum
pos = round(pos*1000)
Rename... envelope'pos'
Edit
editor Spectrum envelope'pos'
   Zoom... 0 'fhi'
endeditor

if draw_spectrum = 1
   Draw... 0 'fhi' 0 0 yes
endif

# cleanup
select Sound segment
plus Sound approx
plus Spectrum segment
plus Spectrum mult
plus Matrix spectrum
Remove

# end of program