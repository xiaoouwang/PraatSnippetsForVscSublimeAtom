clearinfo
@ids
initialSelections$ = ids.ids$
editor
margin = (256/11002)/2
appendInfoLine: margin*2
cursor = Get cursor
# label$ = Get label of interval
label$ = "temp"
milliseconds = round (cursor * 1000)
# extract pulses for time calculation
Show analyses... yes no no yes yes 20.0
Extract visible pulses
endeditor

# get one pulse
pulse_begin_index = Get low index... 'cursor'
pulse_end_index = pulse_begin_index+1


pulse_begin_time = Get time from index... 'pulse_begin_index'
pulse_end_time = Get time from index... 'pulse_end_index'
dur = round(pulse_end_time - pulse_begin_time)

# back editor to extract 1 pulse sound
editor
Select... 'pulse_begin_time' 'pulse_end_time'
Extract selection
endeditor
rd = randomInteger (1, 1000)
newNamePulse$ = "onePulse'dur''label$''rd'"
Rename: newNamePulse$
Copy...
duration = Get total duration
# test condition
while duration < 0.6
        plusObject: "Sound 'newNamePulse$'"
        Concatenate
        duration = Get total duration
endwhile
# rename the sound made from pulses
duration = round(duration)
durationMs = duration * 1000
newNamePulses$ = "multiplePulses'durationMs'ms'label$''rd'"
Rename: newNamePulses$
# Save an analysis window
selectObject: "Sound 'newNamePulses$'"
margin = 0.3
Edit
editor Sound 'newNamePulses$'
        new_cursor = Get cursor
        sel_start = new_cursor - margin
        sel_end = new_cursor + margin
        Select... sel_start sel_end
        # Extract windowed selection... slice Gaussian2 1.0 1
        # Extract windowed selection... slice Gaussian2 1.0 1
        Extract windowed selection... slice Hanning 1.0 1
        # Extract windowed selection... slice Hamming 1.0 1
        Close
endeditor
newNameDFT$ = "DFT_'label$''rd'"
Rename: newNameDFT$

# Make the Spectrum object from the new Sound
# To Spectrum (DFT)
# using FFT
# To Spectrum: "yes"
To Spectrum: "no"
 # using DFT
Rename... DFT_'milliseconds'ms_window'rd'
Edit
editor Spectrum DFT_'milliseconds'ms_window'rd'
        # zoom the spectrum to a comfortable frequency view...
        Zoom... 0 5000
endeditor

# @ids.final

editor
Move cursor to... cursor


procedure ids
  endeditor
  select all
  textgrids# = selected# ("TextGrid")
  .ids$ = ""
  for i from 1 to size (textgrids#)
  selectObject: textgrids# [i]
  .id = selected ("TextGrid")
  .ids$ = .ids$ + " '.id'"
  endfor
  select all
  sounds# = selected# ("Sound")
  for i from 1 to size (sounds#)
  selectObject: sounds# [i]
  .id = selected ("Sound")
  .ids$ = .ids$ + " '.id'"
  endfor
endproc


procedure ids.final
@ids
finalSelections$ = ids.ids$
wangIds = Create Strings as tokens: finalSelections$, " "
nbOfStr = Get number of strings
for i from 1 to nbOfStr
  select wangIds
  id = Get string: i
  if index(initialSelections$, string$ (id)) = 0
  selectObject: id
  Remove
  endif
endfor
removeObject: wangIds
endproc
