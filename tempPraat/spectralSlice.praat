# get spectral slice at the center
a = Get start of selection
b = Get end of selection
cursor = (b - a) /2 + a
writeInfoLine: cursor

milliseconds = round (cursor * 1000)
label$ = Get label of interval

# Analyze pulses
Show analyses... yes no no yes yes 20.0
Extract visible pulses
endeditor

pulse_begin_index = Get low index... 'cursor'
pulse_end_index = pulse_begin_index+1

pulse_begin_time = Get time from index... 'pulse_begin_index'
pulse_end_time = Get time from index... 'pulse_end_index'

editor
Select... 'pulse_begin_time' 'pulse_end_time'
Extract selection (time from 0)
endeditor
Rename... 'label$'_'milliseconds'ms_onepulse

Copy...
duration = Get total duration

i = 1
while i < 11
        plus Sound 'label$'_'milliseconds'ms_onepulse
        Concatenate
        i = i+1
endwhile
# while duration < 0.5
#         plus Sound 'label$'_'milliseconds'ms_onepulse
#         Concatenate
#         duration = Get total duration
# endwhile

Rename... 'label$'_'milliseconds'ms_pulses










# Save an analysis window
select Sound 'label$'_'milliseconds'ms_pulses
        sel_start = Get start time
        sel_end = Get end time
Edit
editor Sound 'label$'_'milliseconds'ms_pulses
        # new_cursor = 0.25
        # sel_start = new_cursor-0.015
        # sel_end = new_cursor+0.015
        Select... sel_start sel_end
        View spectral slice
        # Extract windowed selection... slice Hamming 1.0 1
        # Close
endeditor
spectrumName$ = selected$ ("Spectrum")
# editor Sound 'label$'_'milliseconds'ms_pulses
#         new_cursor = Get cursor
#         sel_start = new_cursor-0.015
#         sel_end = new_cursor+0.015
#         Select... sel_start sel_end
#         Extract selected sound (time from 0)
#         # Extract windowed selection... slice Hamming 1.0 1
#         Close
# endeditor

# Rename... 'label$'_'milliseconds'ms_window

## Make the Spectrum object from the new Sound
# To Spectrum: "no"
# Rename... 'label$'_'milliseconds'ms_window
# Edit
editor Spectrum 'spectrumName$'
        # zoom the spectrum to a comfortable frequency view...
        Zoom... 0 5000
endeditor
# editor Spectrum 'label$'_'milliseconds'ms_window
#         # zoom the spectrum to a comfortable frequency view...
#         Zoom... 0 5000
# endeditor

# select and remove the temporary Sound objects
# select Sound 'label$'_'milliseconds'ms_onepulse
# plus Sound 'label$'_'milliseconds'ms_onepulse
# selectObject: "Sound 'label$'_'milliseconds'ms_window"
# plusObject: "PointProcess untitled"
selectObject: "PointProcess untitled"
Remove
select all
sounds# = selected# ("Sound")
# writeInfoLine: size (sounds#)
# Median pitches of all selected sounds:
for i to size (sounds#)
    selectObject: sounds# [i]
    name$ = selected$ ("Sound")
    if name$ = "chain" or endsWith(name$,"pulse") or endsWith(name$,"pulses")
      Remove
    endif
endfor
# select Spectrum 'spectrumName$'
# # select Spectrum 'label$'_'milliseconds'ms_window
# # return to the Sound editor window and recall the original cursor position
# editor
# Move cursor to... cursor