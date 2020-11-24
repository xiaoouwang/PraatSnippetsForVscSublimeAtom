# Xiaoou WANG, Lpp, 2020
# get ids of all the existing objects
@ids
initialSelections$ = ids.ids$
clearinfo
editor
left_start = Get start of selection
total_len = Get selection length
mid = left_start + total_len/2
Move cursor to: mid
cursor = Get cursor
label$ = "temp"
milliseconds = round (cursor * 1000)
# extract pulses for time calculation
Show analyses... yes no no yes yes 20.0
Extract visible pulses
endeditor

pulse_begin_index = Get low index... 'cursor'
pulse_end_index = pulse_begin_index+1

pulse_begin_time = Get time from index... 'pulse_begin_index'
pulse_end_time = Get time from index... 'pulse_end_index'
period = pulse_end_time-pulse_begin_time
appendInfoLine: period
editor
Select... 'pulse_begin_time' 'pulse_end_time'
Extract selection
endeditor
Rename... 'milliseconds'ms_onepulse

Copy...
duration = Get total duration
# four periods for spectrum
# for i from 1 to 3
#   plus Sound 'milliseconds'ms_onepulse
#   Concatenate
# endfor
Rename... 'milliseconds'ms_fourpulses
# more pulses
while duration < 0.6
        plus Sound 'milliseconds'ms_onepulse
        Concatenate
        duration = Get total duration
endwhile
Rename... 'milliseconds'ms_pulses

select Sound 'milliseconds'ms_pulses
Edit
editor Sound 'milliseconds'ms_pulses
        new_cursor = Get cursor
        # 5 3 1 10
        much = 5
        sel_start = new_cursor-period*much
        sel_end = new_cursor+period*much
        Select... sel_start sel_end
        Extract windowed selection... slice Gaussian2 1.0 1
        # Extract windowed selection... slice Hamming 1.0 1, just for comparaison
        Close
endeditor
Rename... DFT_'milliseconds'ms_window
select Sound 'milliseconds'ms_pulses
Edit
editor Sound 'milliseconds'ms_pulses
        new_cursor = Get cursor
        # 5 3 1 10
        much = 5
        sel_start = new_cursor-period*much
        sel_end = new_cursor+period*much
        Select... sel_start sel_end
        Extract selected sound (time from 0)

        # Extract windowed selection... slice Gaussian2 1.0 1
        # Extract windowed selection... slice Hamming 1.0 1, just for comparaison
        Close
endeditor
Rename... DFT_'milliseconds'ms_nowindow
# Rename... FFT_'milliseconds'ms_window

# Make the Spectrum object from the new Sound
# To Spectrum: "yes"
selectObject: "Sound DFT_'milliseconds'ms_window"
To Spectrum: "no"
Rename... DFT_'milliseconds'ms_window
# Rename... FFT_'milliseconds'ms_window
# editor Spectrum FFT_'milliseconds'ms_window
selectObject: "Sound 'milliseconds'ms_fourpulses"
Multiply by window: "Gaussian2"
To Spectrum: "no"
Rename... DFT_'milliseconds'ms_fourpulses
selectObject: "Spectrum DFT_'milliseconds'ms_window"
# Edit

# editor Spectrum DFT_'milliseconds'ms_window
#         # zoom the spectrum to a comfortable frequency view...
#         Zoom... 0 5500
# endeditor

# Erase all
# draw 4 periods spectrum with red pen
# Red
# selectObject: "Spectrum DFT_'milliseconds'ms_fourpulses"
# Draw: 0, 5500, 0, 0, "no"
# 12
Marks bottom every: 1, 500, "yes", "yes", "yes"
Marks bottom every: 1, 1000, "yes", "yes", "yes"

# draw 10 periods with black pen
Select outer viewport: 0, 6, 0, 4
Solid line
# Black
selectObject: "Spectrum DFT_'milliseconds'ms_window"
Draw: 0, 5500, -20, 46, "yes"

# draw LPC with cyan pen
# selectObject: "Sound DFT_'milliseconds'ms_window"
# To LPC (autocorrelation): 11, 0.025, 0.005, 50
# To Spectrum (slice): 0, 2, 0, 50
# Cyan
# Draw: 0, 5500, 0, 0, "no"

# draw LPC with cyan pen
# selectObject: "Sound DFT_'milliseconds'ms_nowindow"
# To LPC (autocorrelation): 11, 0.025, 0.005, 50
# To Spectrum (slice): 0, 2, 0, 50
# Dashed line

# Cyan
# Draw: 0, 5500, 0, 0, "no"

# get rid of all the existing objects
@ids.final

# editor Spectrum DFT_'milliseconds'ms_window
# Move cursor to... cursor

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
