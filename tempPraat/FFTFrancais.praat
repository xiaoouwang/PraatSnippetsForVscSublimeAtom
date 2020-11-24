# Xiaoou WANG, Lpp, 2020
# get ids of all the existing objects
band_cepstrum = 600
@ids
parent_folder$ = "/Users/xiaoou/Desktop/doneFrenchMimi/frenchMale" + "/"

# camille vraiment breathy
# aurelie ok
# french male to be done
#
upper_freq = 5000
samp_freq = 11000
# oneside_time_window256 = 512/samp_freq/2
oneside_time_window256 = 450/samp_freq/2
# appendInfoLine: oneside_time_window256
initialSelections$ = ids.ids$
# clearinfo
editor
left_start = Get start of selection
total_len = Get selection length
mid = left_start + total_len/2
Move cursor to: mid
cursor = Get cursor
label$ = Get label of interval
# extract pulses for time calculation
# Show analyses... yes no no yes yes 20.0
# Extract visible pulses
endeditor
start_time = cursor - oneside_time_window256
end_time = cursor + oneside_time_window256
period = end_time - start_time
# appendInfoLine: pulse_start_time
# appendInfoLine: pulse_end_time
# appendInfoLine: period
editor
Select... 'start_time' 'end_time'
# extract sound object
Extract selection
endeditor
Rename... 'label$'middle
select Sound 'label$'middle
Multiply by window: "Gaussian2"
To Spectrum: "no"
Rename... DFT_'label$'middle
# select pen color
# beginPause: "please adjust"
#   choice: "vowel type", 2
#      option: "nasal"
#      option: "oral"
# #   choice: "lpc order", 1
# #      option: "5"
# #      option: "6"
# #      option: "7"
# endPause: "Continue", 1
# appendInfoLine: number(lpc_order$)+1
@draw_all
# beginPause: "satisfait ?"
#   choice: "lpc order", 1
#      option: "13"
#      option: "15"
#      option: "17"
#      option: "30"
# endPause: "Continue", 1

# # draw LPC with cyan pen
# # selectObject: "Sound DFT_'milliseconds'ms_nowindow"
# # To LPC (autocorrelation): 11, 0.025, 0.005, 50
# # To Spectrum (slice): 0, 2, 0, 50
# # Dashed line

# # Cyan
# # Draw: 0, 5500, 0, 0, "no"


procedure draw_all
        selectObject: "Spectrum DFT_'label$'middle"
        Marks bottom every: 1, 500, "yes", "yes", "yes"
        Marks bottom every: 1, 1000, "yes", "yes", "yes"
        Select outer viewport: 0, 6, 0, 4
        # red for oral black for nasal
        if left$(label$,1) = "p"
            Solid line
            18
            Red
            Text: 4500, "centre", 25, "Half", label$
        else
            Black
            18
            Text: 4500, "centre", 15, "Half", label$
            Dashed line
        endif
        14
        Draw: 0, upper_freq , -20, 46, "yes"
        selectObject: "Spectrum DFT_'label$'middle"
        Cepstral smoothing: band_cepstrum
        # Cepstral smoothing: 300
        Draw: 0, upper_freq, 0, 0, "no"
        if left$(label$,1) = "m"
        # if vowel_type = 1
            Save as 300-dpi PNG file: "'parent_folder$''label$'middle.png"
            Erase all
        endif
        # editor
        # To LPC (autocorrelation): 11, 0.025, 0.005, 50
        # To Spectrum (slice): 0, 2, 0, 50
        # Draw: 0, upper_freq, 0, 0, "no"
endproc
# # get rid of all the existing objects
@ids.final

# editor: "TextGrid 2nasalisation"

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
    select all
    spectrums# = selected# ("Spectrum")
    for i from 1 to size (spectrums#)
            selectObject: spectrums# [i]
            .id = selected ("Spectrum")
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
