# Xiaoou WANG, Lpp, 2020
# Ce script permet de sauvegarder le spectre dans le centre acoustique d'une voyelle avec une courbe
fft_log_complete$ = "FFT_log_complete_frfr.csv"
band_cepstrum = 600
# get ids of all the existing objects
@ids
parent_folder$ = "/Users/xiaoou/Desktop/doneFrenchMimi/stelladone/stellaresampled" + "/"
oral_position = 20
nasal_position = 5
# initial formant number and formant ceiling
initial_formant_number = 5
upper_freq = 5500
# sampling frequency (important to calculate the dft window!)
samp_freq = 11000
oneside_time_window256 = 450/samp_freq/2
initialSelections$ = ids.ids$
editor
left_start = Get start of selection
total_len = Get selection length
mid = left_start + total_len/2
Move cursor to: mid
cursor = Get cursor
label$ = Get label of interval
endeditor
start_time = cursor - oneside_time_window256
end_time = cursor + oneside_time_window256
# period = end_time - start_time
editor
Select... 'start_time' 'end_time'
# extract sound object
Extract selection
endeditor
Rename... 'label$'middle
select Sound 'label$'middle
select Sound 'label$'middle
Multiply by window: "Gaussian2"
To Spectrum: "no"
Rename... DFT_'label$'middle
@draw_all

procedure draw_all
        selectObject: "Spectrum DFT_'label$'middle"
        Select outer viewport: 0, 6, 0, 4
        clicked = 1
        if left$(label$,1) = "p"
            Solid line
            Erase all
            18
            Red
            # print pVp label
            Text: 4600, "centre", oral_position, "Half", label$
            # confirm
            # if clicked = 1 adjust formant number and recreate the formant object
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
                # adjust formant number according to choice
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
                    # median is more reliable in this specific case
                    f1 = Get quantile: 1, 0, 0, "hertz", 0.5
                    f2 = Get quantile: 2, 0, 0, "hertz", 0.5
                    f3 = Get quantile: 3, 0, 0, "hertz", 0.5
                    Remove
                endif
            endwhile
            Magenta
            10
            f1_mark = f1 + 183
            f2_mark = f2 + 146
            f2_mark_bottom = f2_mark+200
            f3_mark = f3 + 30
            # mark f1, f2 and f3 from lpc (burg)
            One mark top: 'f1_mark', "no", "yes", "yes", "F1"
            One mark bottom: 'f1_mark', "no", "no", "no", "'f1:0' Hz"
            One mark top: 'f2_mark', "no", "yes", "yes", "F2"
            One mark bottom: 'f2_mark_bottom', "no", "no", "no", "'f2:0' Hz"
            One mark top: 'f3_mark', "no", "yes", "yes", "F3"
            One mark bottom: 'f3_mark', "no", "no", "no", "'f3:0' Hz"
        else
        # print nasal label
            Black
            18
            Text: 4600, "centre", nasal_position , "Half", label$
            Dashed line
        endif
        14
        if left$(label$,1) = "p"
            Red
        endif
        # draw dft spectrum
        selectObject: "Spectrum DFT_'label$'middle"
        Draw: 0, upper_freq , -20, 46, "yes"
        Marks bottom every: 1, 1000, "yes", "yes", "yes"
        Marks bottom every: 1, 500, "no", "yes", "yes"
        # draw cepstrum (this overrides the dft object, caution here)
        selectObject: "Spectrum DFT_'label$'middle"
        Cepstral smoothing: band_cepstrum
        # Cepstral smoothing: 300
        Draw: 0, upper_freq, 0, 0, "no"
        if left$(label$,1) <> "p"
            Save as 300-dpi PNG file: "'parent_folder$''label$'middle.png"
        endif
        # log formant
        if left$(label$,1) = "p"
            appendFileLine: fft_log_complete$, "'label$','f1:0','f2:0','f3:0'"
        endif
endproc

@ids.final

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
