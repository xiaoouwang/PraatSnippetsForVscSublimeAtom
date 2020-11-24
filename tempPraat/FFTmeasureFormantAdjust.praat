# Xiaoou WANG, Lpp, 2020
fft_log_complete$ = "FFT_log_complete_cncn.csv"
band_cepstrum = 600
# get ids of all the existing objects
@ids
parent_folder$ = "/Users/xiaoou/Desktop/doneChineseMimi/amelieDBdone/amelieDBresampled" + "/"

# camille vraiment breathy
# aurelie ok
# french male to be done
#
initial_formant_number = 5
upper_freq = 5500
samp_freq = 11000
oneside_time_window256 = 0.02
initialSelections$ = ids.ids$
editor
# left_start = Get start of selection
# total_len = Get selection length
# mid = left_start + total_len/2
# Move cursor to: mid
cursor = Get cursor
label$ = Get label of interval
endeditor
start_time = cursor
end_time = cursor + oneside_time_window256
period = end_time - start_time
editor
Select... 'start_time' 'end_time'
# extract sound object
Extract selection
endeditor
Rename... 'label$'middle
# select Sound 'label$'middle
# select Sound 'label$'middle
# Multiply by window: "Gaussian2"
# To Spectrum: "no"
# Rename... DFT_'label$'middle
@draw_all



procedure draw_all
        # selectObject: "Spectrum DFT_'label$'middle"
        # Select outer viewport: 0, 6, 0, 4
        # Marks bottom every: 1, 500, "no", "yes", "yes"
        # Marks bottom every: 1, 1000, "yes", "yes", "yes"
        # red for oral black for nasal
        clicked = 1
        if left$(label$,1) <> ""
            # Solid line
            # 18
            # Red
            # Text: 4600, "centre", 25, "Half", label$
            # confirm
            # if click adjust recreate the formant object
            while clicked = 1
                beginPause: "check f1 f2 f3 value"
                    choice: "formant number", 2
                        option: "4"
                        option: "5"
                        option: "6"
                        option: "7"
                        option: "8"
                      #  default clicked is ok = 2
                clicked = endPause: "adjust", "ok", 2
                # selectObject: "Formant formant_'label$'middle"
                # Remove
                if formant_number = 1
                    fm_number = 4
                elsif formant_number = 2
                    fm_number = 5
                elsif formant_number = 3
                    fm_number = 6
                elsif formant_number = 4
                    fm_number = 7
                elsif formant_number = 5
                    fm_number = 8
                endif
                if clicked = 2
                    select Sound 'label$'middle
                    To Formant (burg): 0, fm_number, 5500, 0.025, 50
                    Rename... formant_'label$'middle
                    f1 = Get quantile: 1, 0, 0, "hertz", 0.5
                    # f1 = Get mean: 1, 0, 0, "hertz"
                    f2 = Get quantile: 2, 0, 0, "hertz", 0.5
                    # f2 = Get mean: 2, 0, 0, "hertz"
                    f3 = Get quantile: 3, 0, 0, "hertz", 0.5
                    f4 = Get quantile: 4, 0, 0, "hertz", 0.5
                    # f3 = Get mean: 3, 0, 0, "hertz"
                    Remove
                endif
            endwhile
            Magenta
            10
            f1_mark = f1 + 183
            f2_mark = f2 + 146
            f2_mark_bottom = f2_mark+200
            f3_mark = f3 + 30
            # One mark top: 'f1_mark', "no", "yes", "yes", "F1"
            # One mark bottom: 'f1_mark', "no", "no", "no", "'f1:0' Hz"
            # One mark top: 'f2_mark', "no", "yes", "yes", "F2"
            # One mark bottom: 'f2_mark_bottom', "no", "no", "no", "'f2:0' Hz"
            # One mark top: 'f3_mark', "no", "yes", "yes", "F3"
            # One mark bottom: 'f3_mark', "no", "no", "no", "'f3:0' Hz"
        endif
        # 14
        # if left$(label$,1) = "p"
        #     Red
        # endif
        if left$(label$,1) <> ""
            appendFileLine: fft_log_complete$, "'label$','f1:0','f2:0','f3:0','f4:0'"
        endif
endproc


# # get rid of all the existing objects
# @ids.final

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
