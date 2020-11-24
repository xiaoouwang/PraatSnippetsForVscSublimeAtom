# Xiaoou WANG, lpp, 2020
fft_a1p0_complete$ = "FFT_a1_p0.csv"
if not fileReadable (fft_a1p0_complete$)
	header_row$ = "label,p0_freq,p0_amp,a1_freq,a1_amp,p1_freq,p1_amp,a1minusp0,a1minusp1"
        appendFileLine: fft_a1p0_complete$, header_row$
endif
band_cepstrum = 600
# get ids of all the existing objects
@ids
parent_folder$ = "/Users/xiaoou/Desktop/alexresampled" + "/"
# specify nasal harmonics critical frequency
a1_position = 549
a2_position = 969
p1_position = 900
p0_position = 207
oral_position = 20
nasal_position = 5
initial_formant_number = 5
upper_freq = 5500
# sampling frequency (important to calculate the dft!)
s_amp = 11000
oneside_time_window256 = 450/s_amp/2
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
editor
Select... 'start_time' 'end_time'
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
        Black
        Erase all
        # draw dft spectrum
        selectObject: "Spectrum DFT_'label$'middle"
        Select outer viewport: 0, 6, 0, 4
        selectObject: "Spectrum DFT_'label$'middle"
        Draw: 0, upper_freq , -20, 46, "yes"
        # draw cepstrum curve
        selectObject: "Spectrum DFT_'label$'middle"
        Copy: "spec_cepstrum_'label$'middle"
        Cepstral smoothing: band_cepstrum
        Draw: 0, upper_freq, 0, 0, "no"
        #### harmonics calculation
        select Spectrum DFT_'label$'middle
        noprogress To Ltas (1-to-1)
        Rename... Ltas_'label$'middle
        a1_freq = Get frequency of maximum... 'a1_position'-150 'a1_position'+150 None
        a1_amp = Get value at frequency... 'a1_freq' Nearest
        p1_freq = Get frequency of maximum... 'p1_position'-150 'p1_position'+150 None
        p1_amp = Get value at frequency... 'p1_freq' Nearest
        p0_freq = Get frequency of maximum... 'p0_position'-50 'p0_position'+300 None
        p0_amp = Get value at frequency... 'p0_freq' Nearest
        Marks bottom every: 1, 1000, "yes", "yes", "yes"
        Marks bottom every: 1, 500, "no", "yes", "yes"
        Black
        One mark top: 'a1_freq:0', "no", "yes", "yes", "a1"
        Red
        One mark top: 'p1_freq:0', "no", "yes", "yes", "p1"
        Magenta
        One mark top: 'p0_freq:0', "no", "yes", "yes", "p0"
        selectObject: "Spectrum DFT_'label$'middle"
        Edit
        editor Spectrum DFT_'label$'middle
            Zoom... 0 3250
            Move cursor to... 'a1_freq'
        endeditor
        # verify automatic measurements
        beginPause: "check a1 p1 p0 value"
               comment: "enter a1freq"
               real: "enter a1freq", round(a1_freq)
               comment: "enter p1freq"
               real: "enter p1freq", round(p1_freq)
               comment: "enter p0freq"
               real: "enter p0freq", round(p0_freq)
               comment: "enter a1ampli"
               real: "enter a1ampli", number(fixed$(a1_amp,1))
               comment: "enter p1ampli"
               real: "enter p1ampli", number(fixed$(p1_amp,1))
               comment: "enter p0ampli"
               real: "enter p0ampli", number(fixed$(p0_amp,1))
        clicked = endPause: "ok", 1
        a1minusp0 = enter_a1ampli - enter_p0ampli
        a1minusp1 = enter_a1ampli - enter_p1ampli
        # log part
        appendFileLine: fft_a1p0_complete$, "'label$','enter_p0freq:0','enter_p0ampli:1','enter_a1freq:0','enter_a1ampli:1','enter_p1freq:0','enter_p1ampli:1','a1minusp0:1','a1minusp1:1'"
endproc


# get rid of all the existing objects
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
    select all
    ltas# = selected# ("Ltas")
    for i from 1 to size (ltas#)
            selectObject: ltas# [i]
            .id = selected ("Ltas")
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