clearinfo
# @ids
# initialSelections$ = ids.ids$
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

pulse_begin_time = Get time from index... 'pulse_begin_index'
pulse_end_time = Get time from index... 'pulse_end_index'

# Select & iterate one pulse
#select Sound 'soundname$'
#Extract part... 'pulse_begin_time' 'pulse_end_time' Hanning 1 no
#Rename... 'milliseconds'ms_onepulse
editor
Select... 'pulse_begin_time' 'pulse_end_time'
Extract selection
endeditor
Rename... 'milliseconds'ms_onepulse

Copy...
duration = Get total duration
num_copies = 0
while duration < 0.06
        plus Sound 'milliseconds'ms_onepulse
        Concatenate
        duration = Get total duration
        num_copies = num_copies + 1
endwhile
Rename... 'milliseconds'ms_pulses

# Save an analysis window
select Sound 'milliseconds'ms_pulses
Edit
editor Sound 'milliseconds'ms_pulses
        new_cursor = Get cursor
        sel_start = new_cursor-0.015
        sel_end = new_cursor+0.015
        Select... sel_start sel_end
        Extract windowed selection... slice Hamming 1.0 1
        Close
endeditor
Rename... FFT_'milliseconds'ms_window

# Make the Spectrum object from the new Sound
To Spectrum (fft)
Rename... FFT_'milliseconds'ms_window
Edit
editor Spectrum FFT_'milliseconds'ms_window
        # zoom the spectrum to a comfortable frequency view...
        Zoom... 0 5000
endeditor