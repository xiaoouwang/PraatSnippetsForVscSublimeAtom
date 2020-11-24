# select all
# Remove
# p1's range
lowp1 = 850
highp1 = 1050

# Any H1 (F0) value above the below number will be considered to be an error
crazyhighh1 = 300
# Any H1 (F0) value below the below number will be considered to be an error
crazylowh1 = 80
# If Vowels are unlabeled, set the below to 0, otherwise 1
vowellab = 1
# If Words are unlabeled, set the below to 0, otherwise 1
wordlab = 1
# Look for formants up to this value in Hz
formrange = 5500
# Length of window over which spectrogram is calculated:
length = 0.005
# How High can P0 be?
hip0 = 400

# Interpret Vowel Labels to tweak formant finding?  Change to 1 to do so.
usevowels = 0

# Some settings for modal vowel processing, first low vowels
# What's the highest sane F1?
lovhif1 = 1100
# ... and the lowest sane F1?
lovlof1 = 500
# How many formants should we look for?
lovformnum = 5

# and settings for high vowels
hivhif1 = 500
hivlof1 = 200
hivformnum = 5

# and generic settings for when vowels are not specified
genvhif1 = 1100
genvlof1 = 200
genvformnum = 5
voweltier = 1
wordtier = 2
file_type$ = ".wav"
p1search = 950
tpnum = 5
iterate = 1
scoot = 0.000
flag$ = "None"
directory$ = "/Users/xiaoou/Documents/languages/todo" + "/"
resultfile$ = "'directory$'"+"_nasalitylogv5.csv"
Create Strings as file list... list 'directory$'*'file_type$'
number_files = Get number of strings
# Set up log file:
if fileReadable (resultfile$)
	fillerLine$ = "this is some new measures, pay attention"
	pheader_row$ = "'fillerLine$'" + newline$
	fileappend "'resultfile$'" 'pheader_row$'
else
	header_row$ = "filename" + "," + "word" + "," + "vowel" + "," + "freq_f1" + "," + "amp_f1" +  ","  + "freq_h1" + "," + "amp_h1" + "," + "freq_h2" + "," + "amp_h2" + "," + "amp_h3" + "," + "amp_p0" + "," + "freq_p0" + "," + "p0prominence" + "," + "a1p0_h1" + "," + "a1p0_h2"  + "," + "a1p0_h3" + "," + "a1p0" + "," + "a1p0_compensated" + "," + "freq_p1" + "," + "amp_p1" + "," + "a1p1" + "," + "a1p1_compensated" + "," + "vwl_duration" + "," + "timepoint" + "," + "point_time" + "," + "point_vwlpct"
	pheader_row$ = "'header_row$'" + newline$
	fileappend "'resultfile$'" 'pheader_row$'
endif
# analysis starts here
manual = 1
call Individual_Pass

procedure Individual_Pass
	for j from 1 to number_files
		select Strings list
		filename$ = Get string... 'j'
		Read from file... 'directory$''filename$'
		soundname$ = selected$ ("Sound")
		noprobname$ = "'soundname$'"
		wordcomplete = 0
		if wordcomplete = 0
			gridfile$ = "'directory$''soundname$'.TextGrid"
			if fileReadable (gridfile$)
				Read from file... 'gridfile$'
				select TextGrid 'soundname$'
				number_intervals = Get number of intervals... 'voweltier'
				# Now we check *every* interval on the vowel tier.
				for k from 1 to number_intervals
					select TextGrid 'soundname$'
					# If the vowels are unlabeled (set above at the start of the script), then set the vowel text to "V", and use generic high and low F1 values.
					# Get the vowel's label.
					vowel_label$ = Get label of interval... 'voweltier' 'k'
					#checks if interval has a labeled vowel
					if vowel_label$ <> ""
						# If we didn't want to use vowels to label, override with generic settings
						hif1 = genvhif1
						lof1 = genvlof1
						formnum = genvformnum
						origformnum = genvformnum

						# Calculate some temporal stuff
						select TextGrid 'soundname$'
						vowel_start = Get starting point... 'voweltier' 'k'
						vowel_end = Get end point... 'voweltier' 'k'
						midpoint = vowel_start + ((vowel_end - vowel_start) / 2)
						duration = (vowel_end - vowel_start) * 1000
						durationms = (vowel_end - vowel_start)

						# Get the time of the end of the word, for later
						finishing_time = Get finishing time
						# Round the duration for display
						rndduration = round('duration')

						# If the words are labeled...
						if wordlab = 1
							## Word label extraction courtesy R. Scarborough
							wordint = Get interval at time... 'wordtier' 'midpoint'
							word_label$ = Get label of interval... 'wordtier' 'wordint'
						else
							word_label$ = "Unlabeled"
						endif

						# if word_label$ <> "Supercalifragilisticexpialidocious"
							# Extract half a second to either side of the vowel so there's some word context
							prevowel = vowel_start - 0.5
							postvowel = vowel_end + 0.5
							select Sound 'soundname$'
							Extract part...  'prevowel' 'postvowel' Rectangular 1 yes
							Rename... 'soundname$'_word
							select Sound 'soundname$'_word
							# Determine the span covered by each bin (the duration/number of timepoints-1)
							size = durationms / (tpnum-1)
							# Iterate through the timepoints
							for point from 1 to tpnum
								reampcount = 0
								noprobname$ = "'soundname$'_'point'_'k'"
								appendInfoLine: noprobname$
								hasit = 0
								if hasit = 0
									select Sound 'soundname$'_word
									rmsamp = Get root-mean-square... 0 0
									select Sound 'soundname$'_word
									# Create a formant object
									counter = 0
									# If it's the first or last timepoint, scoot in
									if point = 1
										timepoint = 'vowel_start' + 'scoot'
									elsif point = tpnum
										timepoint = 'vowel_end' - 'scoot'
									else
										timepoint = vowel_start + (size * (point-1))
									endif
									# Save the timepoint label for output
									tpname = 'point'
									vwlpct = ((timepoint-vowel_start)/durationms)*100
									# If you want start-mid-end, three timepoint measures, we have to tweak a bit
									if tpnum = 3
										# Oh Praat, why can't I nest if statements without defining some junk variable?
										junkvariable = 0
										if point = 2
											timepoint = 'midpoint'
										elsif point = 3
											timepoint = 'vowel_end' - 'scoot'
										endif
									endif
									# If you just want one point, you want the midpoint
									if tpnum = 1
										timepoint = 'midpoint'
									endif

									# This part of the script works on a sound called 'soundname$'
									if iterate
									    select Sound 'soundname$'_word
										# Make a point process to get pulse info
										noprogress do ("To PointProcess (periodic, cc)...", 75, 600)
										# Choose the pulse
									    if point = 'tpnum'
										# if it's the last point, grab the end of the pulse, go to the start
									        pulse_end_index = Get high index... 'timepoint'
									        pulse_begin_index = pulse_end_index-1
										else
										# Otherwise, grab the start of the pulse, go to the end of the next one
											pulse_begin_index = Get low index... 'timepoint'
											pulse_end_index = pulse_begin_index + 1
									    endif
										#### confirm pulse length to avoid some crashes
										if pulse_begin_index = 0
											pulse_begin_index = 1
											pulse_end_index = 2
											uhoh = 1
											flag$ = "Crash-PulseBegin"
										endif
										if pulse_begin_index = -1
											pulse_begin_index = 1
											pulse_end_index = 2
											uhoh = 1
											flag$ = "Crash-PulseEnd"
										endif
									    pulse_begin_time = Get time from index... 'pulse_begin_index'
									    pulse_end_time = Get time from index... 'pulse_end_index'

										# Catch some more crashes
										if pulse_begin_time = undefined
											pulse_begin_time = 1
											uhoh = 1
											flag$ = "Crash-BegPulseUndef"
										endif
										if pulse_end_time = undefined
											pulse_end_time = pulse_begin_time + 1
											uhoh = 1
											flag$ = "Crash-EndPulseUndef"
										endif

										# Now, finally extract the pulse
										select Sound 'soundname$'_word
										Extract part... 'pulse_begin_time' 'pulse_end_time' Rectangular 1 no
										Rename... 'soundname$'_onepulse

										# and iterate it until it's half a second long, for good F0 resolution
										select Sound 'soundname$'_onepulse
										Copy...
										chunk_duration = Get total duration
										#### In V.3, chunk duration was enlarged to 0.5 to allow better F0 resolution
										while chunk_duration < 0.5
											plus Sound 'soundname$'_onepulse
											Concatenate
											chunk_duration = Get total duration
										endwhile
										Rename... 'soundname$'_pulses
										# Set the timepoint of the measurement to 0.25, which is the middle of the chunk created above
										mtimepoint = 0.25
									endif
									# Reset some stuff
									erroradj$ = "None"
									uhoh = 0
									itercount = 1
									status = 1
									formiter = 0

									##### A1-P0 PREP
									label formantmeasures
								    select Sound 'soundname$'_pulses
								    # Here's where we grab formants using the formnum settings earlier
									noprogress To Formant (burg)... 0 formnum formrange 0.025 50
								    select Formant 'soundname$'_pulses

									# First, get MeanF1, so we can fall back to it.
									meanf1 = Get mean... 1 vowel_start vowel_end Hertz

									# Get F1 from the LPC
									f1_lpc = Get value at time... 1 'mtimepoint' Hertz Linear
									# if f1_lpc is undefined, Praat crashes without this code
									if f1_lpc = undefined
										flag$ = "MeanF1"
										# Uh oh.  Can we just use F1's mean instead?
										if meanf1 = undefined
										# If not, it's crash time.
											meanf1 = 1337
											uhoh = 1
											flag$ = "Crash-MeanF1"
										endif
										# if it's undefined, just use the mean, and the quantile (meanish) of bandwidth.
										f1_lpc = meanf1
										f1b_lpc = Get quantile of bandwidth: 1, 0, 0, "Hertz", 0.5
									else
									# If F1's cool, get the bandwidth
										f1b_lpc = Get bandwidth at time... 1 'mtimepoint' Hertz Linear
									endif

									# Whoa.  This looks like the code for F1.  See comments above :)
									meanf2 = Get mean... 2 vowel_start vowel_end Hertz
									f2_lpc = Get value at time... 2 'mtimepoint' Hertz Linear
									if f2_lpc = undefined
										flag$ = "MeanF2"
										if meanf2 = undefined
											meanf2 = 1337
											uhoh = 1
											flag$ = "Crash-MeanF2"
										endif
										f2_lpc = meanf2
										f2b_lpc = Get quantile of bandwidth: 2, 0, 0, "Hertz", 0.5
									else
										f2b_lpc = Get bandwidth at time... 2 'mtimepoint' Hertz Linear
									endif

									# Collect F3, same method.
									meanf3 = Get mean... 3 vowel_start vowel_end Hertz
									f3_lpc = Get value at time... 3 'mtimepoint' Hertz Linear
									if f3_lpc = undefined
										flag$ = "MeanF3"
										if meanf3 = undefined
											meanf3 = 1337
											uhoh = 1
											flag$ = "Crash-MeanF3"
										endif
										f3_lpc = meanf3
										f3b_lpc = Get quantile of bandwidth: 3, 0, 0, "Hertz", 0.5
									else
										f3b_lpc = Get bandwidth at time... 3 'mtimepoint' Hertz Linear
									endif

									if f1_lpc < lof1
									# So if F1 is that low, it's likely grabbed an additional "formant" down low.  The fix is to look for fewer formants.  Now, it tries this automatically, then checks for undefined items again to make it more crash-resistant.
										# Only correct and check once, then just report the failure
										if formiter = 0
										# Reduce the number of formants
											formnum = formnum - 1
											formiter = 1
											erroradj$ = "LowF1Corrected"
											# So if it screws up, it jumps to the start of the section.
											goto formantmeasures
										else
										# If the correction didn't work, flag as "LowF1" or "HighF1"
											if f1_lpc < lof1
												status = 2
												erroradj$ = "LowF1Corrected"
												flag$ = "LowF1"
											endif
											if f1_lpc > hif1
												status = 2
												erroradj$ = "LowF1Corrected"
												flag$ = "HighF1"
											endif
										endif
									endif


									if f1_lpc > hif1
									# Again, whoa, this looks like the above.  See above comments.
										if formiter = 0
											formnum = formnum + 1
											formiter = 1
											erroradj$ = "HighF1Corrected"
											goto formantmeasures
										else
											if f1_lpc < lof1
												status = 2
												erroradj$ = "HighF1Corrected"
												flag$ = "LowF1"
											endif
											if f1_lpc > hif1
												status = 2
												erroradj$ = "HighF1Corrected"
												flag$ = "HighF1"
											endif
										endif
									endif

									# Reset the formant number for the next word
									formnum = origformnum

									# Now we move to pitch.
								    select Sound 'soundname$'_pulses
									# Make a pitch object, using the defined highest H1 as the top of the range.
									noprogress To Pitch... 0 60 'crazyhighh1'
									select Pitch 'soundname$'_pulses
									# Get mean pitch
									meanf0 = Get mean... 0 0 Hertz
									# If that fails, then get the mean pitch for the whole word, not just the vowel.  This just adds crash resistance, because this is very unlikely to fail.
									if meanf0 = undefined
								    	select Sound 'soundname$'_word
										noprogress To Pitch... 0 60 'crazyhighh1'
										select Pitch 'soundname$'_word
										meanf0 = Get mean... 0 0 Hertz
									endif
									# Get the pitch at the timepoint
									f0_lpc = Get value at time... 'mtimepoint' Hertz Linear
									# If this fails, use the mean.  This is OK, because we find the exact frequencies from harmonics, which aren't affected by Praat's pitch tracker.
									if f0_lpc = undefined
										f0_lpc = meanf0
									endif
									# If the mean is still undefined, we give these both a pre-defined, junk value, and then flag this as a bad measurement.  This is why you shouldn't use flagged measures, because they're bad.
									if meanf0 = undefined
										f0_lpc = 120
										meanf0 = 120
										flag$ = "Crash-MeanF0"
									endif
									# Now, we take a chunk of the "pulses" file generated by iteration
								    select Sound 'soundname$'_pulses
									tpslicelow = 'mtimepoint' - 0.015
									tpslicehigh = 'mtimepoint' + 0.015
									# Extract part... 'tpslicelow' 'tpslicehigh' Hamming 1 no
									Extract part: tpslicelow, tpslicehigh, "Gaussian2", 1, "no"
									Rename... slice

									#### A1-P0 Calc
								    select Sound slice
									# First make a spectrum, then an LTAS (which is the only way to find harmonic heights in Praat for some reason)
								    noprogress To Spectrum: "no"
								    Rename... 'soundname$'
								    noprogress To Ltas (1-to-1)
								    Rename... 'soundname$'

								    ## Identifies the peak on the spectrum most likely to be F1, that is, the peak
								    ## closest to the LPC F1 value that is within the range of one harmonic.
									select Ltas 'soundname$'
								    f1_spec = Get frequency of maximum... 'f1_lpc'-150 'f1_lpc'+150 None
									# Then get the amplitude
								    a1_spec = Get value at frequency... 'f1_spec' Nearest

									# Get amplitude of F2
								    f2_spec = Get frequency of maximum... 'f2_lpc'-150 'f2_lpc'+150 None
								    f2amp = Get value at frequency... 'f2_spec' Nearest

									# Get amplitude of F3
								    f3_spec = Get frequency of maximum... 'f3_lpc'-150 'f3_lpc'+150 None
								    f3amp = Get value at frequency... 'f3_spec' Nearest
								    f3freq = f3_lpc

									# Rename Bandwidths for printing
									f1width = f1b_lpc
									f2width = f2b_lpc
									f3width = f3b_lpc

								    ## Identifies the peaks most likely to be H1, H2, and H3 using an arbitrary
								    ## search window that has been, in practice, almost always sufficient.  Then get amplitudes

								    h1 = Get frequency of maximum... 'f0_lpc'-('f0_lpc'/2) 'f0_lpc'+('f0_lpc'/2) None
								    h2 = Get frequency of maximum... (2*'f0_lpc')-('f0_lpc'/2) (2*'f0_lpc')+('f0_lpc'/2) None
									h3 = Get frequency of maximum... (3*'f0_lpc')-('f0_lpc'/2) (3*'f0_lpc')+('f0_lpc'/2) None
								    h1_amp = Get value at frequency... 'h1' Nearest
								    h2_amp = Get value at frequency... 'h2' Nearest
									h3amp = Get value at frequency... 'h3' Nearest

									# Get P1 one the basis of
									p1freq = Get frequency of maximum... 'lowp1' 'highp1' None

								    p1amp = Get value at frequency... 'p1freq' Nearest

									# This controls the "remeasure" section.  Basically, if you're tried 5 remeasures, just fail.  It's not gonna happen.
									label reamp
									if reampcount < 5
										reampcount = reampcount + 1
									else
										goto newpoint
									endif
									# Clean up and get some amplitudes

									# Get P0Prominence.  First figure out which of h1/h2 is P0
									if h1_amp > h2_amp
										tempp0 = h1
									else
										tempp0 = h2
									endif
									# This needs to be calculated differently if H1 is P0 vs. otherwise
									select Ltas 'soundname$'
									if tempp0 = h1
									# If H1 is P0, just grab H2 and use that
										hP0upFreq = Get frequency of maximum... (h1+('f0_lpc'/2)) (h1+('f0_lpc'*1.5)) None
										hP0up = Get value at frequency... 'hP0upFreq' Nearest
										p0Prom = h1_amp - hP0up
									else
									# If H2 is P0, grab H1 and H3
										hP0upFreq = Get frequency of maximum... (h2+('f0_lpc'/2)) (h2+('f0_lpc'*1.5)) None
										hP0up = Get value at frequency... 'hP0upFreq' Nearest
										hP0down = h1_amp
										p0Prom = h2_amp - ((hP0up+hP0down)/2)
									endif


									### Checks and Balances

									# This resets the flag each time.

									# If any of the flags are found, the measurement will need to be hand verified.

									# First, we check to make sure the found H1 isn't below 85hz.  Given the bin-width limits, this won't be particularly often.
									select Ltas 'soundname$'
									if 'h1' < 'crazylowh1'
										status = 2
										flag$ = "LoPitch"
										h1 = meanf0
										if counter < 2
											goto reamp
										endif
									endif

									# Then, we check to make sure the found H1 isn't above 300hz.
									if 'h1' > 'crazyhighh1'
										status = 2
										flag$ = "HiPitch"
										h1 = meanf0
										if counter < 2
											goto reamp
										endif
									endif

									# Is H1 more than twice the average F0?
									if 'h1' > (2 * meanf0)
										h1 = meanf0
										status = 2
										flag$ = "PitchVary"
										if counter < 2
											goto reamp
										endif
									endif

									#Here, we check harmonic deviation.  This is the measure of how much H2 differs from H1*2.
									doubleh1 = 'h1' * 2
									harmdev = abs('h2' - 'doubleh1')
									if harmdev > ('h1' / 2)
										status = 2
										flag$ = "HarmDev"
									endif

									# This should trip if the valley between h1 and h2 doesn't exist or is very shallow
									valleyfreq = Get frequency of minimum... 'h1' 'h2' None
									vamp = Get value at frequency... 'valleyfreq' Nearest
									h1valleydiff = abs('h1_amp' - 'vamp')

									# By default, it checks for a valley at least 5 dB deep.  Feel free to edit, but know that this will strongly affect the number of verifications or flags
									if h1valleydiff < 5
										status = 2
										flag$ = "Shallow"
									endif

									# Now let's make sure F1 isn't less than F0 (which happens when the LPC mis-predicts F1 for some higher pitched speakers)
									if f1_spec < h1
										status = 2
										flag$ = "F1BelowH1"
									endif

									label newpoint
									# This is the meat of the three-mode running
									if manual = 1
									# If it's full manual, then display everything regardless, verify, and then log
										call display_for_human
										call Verify_A1_P0
										call Log_output
										# Now write that that point is confirmed in the list
										noprobname$ = "'soundname$'_'point'_'k'" + newline$
										fileappend "'progressfile$'" 'noprobname$'
									endif
							        #remove temporary objects
							  	  	select TextGrid 'soundname$'
							  	  	Copy... junk
									select all
									minus Strings list
									# minus Strings tempfile
									# minus WordList nasprogress
									# minus WordList highvowels
									minus Sound 'soundname$'_pulses
									minus Sound 'soundname$'
									minus TextGrid 'soundname$'
									minus Sound 'soundname$'_word
									minus Ltas 'soundname$'
									Remove
								endif
							endfor
						# endif
					endif
				endfor

				# get rid of more temporary objects
				if autorun != 2
					noprobname$ = "'soundname$'" + newline$
					fileappend "'progressfile$'" 'noprobname$'
				endif
			else
				select Sound 'soundname$'
			endif
	        select all
	        minus Strings list
	        minus Strings tempfile
	        minus WordList highvowels
	        Remove
		endif
	endfor
endproc

procedure confirm_p1
    select Spectrum 'soundname$'
    Edit
    editor Spectrum 'soundname$'
        Zoom... 0 3250
        Move cursor to... 'p1freq'
    endeditor
    beginPause ("Click within 0.75 F0's of P1")
	endPause ("Continue", 1)
	editor Spectrum 'soundname$'
		Move cursor to nearest peak
		cursorp1 = Get cursor
        Close
    endeditor
    select Ltas 'soundname$'
    machinep1 = p1freq
    p1freq = cursorp1
	p1amp = Get value at frequency... 'p1freq' Nearest

endproc

procedure display_for_human
	# display the spectrum and LPC
	Erase all
	select Spectrum 'soundname$'
	Viewport... 0 7 0 4
	Draw... 0 5500 0 0 yes
	Marks bottom every... 1 500 yes no no
	Marks bottom every... 1 250 no yes no
	# One mark bottom... 'f1_spec' no yes yes F1
	# One mark top... 'f1_lpc' no yes yes RealF1
	One mark bottom: h1, "no", "yes", "yes", ""
	One mark bottom: h2, "no", "yes", "yes", ""
	One mark top... 'p1freq' no yes yes P1
	select Sound 'soundname$'_pulses
	To LPC (autocorrelation)... 11 0.025 0.005 50
	To Spectrum (slice)... 0 20 0 50
	Rename... LPC_'soundname$'
	spectrum_lpc = selected("Spectrum")
	select 'spectrum_lpc'
	Line width... 2
	### Edit the fourth number below to control the high end of the dynamic range of the plot.  80 is a good default.
	Draw... 0 5550 0 0 no
	Line width... 1
	# show formant track + spectrogram
	Font size... 14
	display_from = 'vowel_start' - 0.15
	if ('display_from' < 0)
	        display_from = 0
	endif
	display_until = 'vowel_end' + 0.15
	if ('display_until' > 'finishing_time')
	        display_until = 'finishing_time'
	endif
	select Sound 'soundname$'
	To Spectrogram... 'length' 5500 0.002 20 Gaussian
	spectrogram = selected("Spectrogram")
	Viewport... 0 7 4.5 8
	Paint... 'display_from' 'display_until' 0 5500 100 yes 50 6 0 no
	select Sound 'soundname$'
	noprogress To Formant (burg)... 0 formnum formrange 0.025 50
	select Formant 'soundname$'
	Yellow
	Speckle... 'display_from' 'display_until' 4000 30 no
	Marks left every... 1 500 yes yes yes
	Viewport... 0 7 4.5 8
	select TextGrid 'soundname$'
	Black
	Draw... 'display_from' 'display_until' no yes yes
	One mark bottom... 'timepoint' yes yes yes
	#One mark right... 'f1_spec' no yes yes
endproc


procedure flagcolor
	if flag$ <> "None"
		Red
	endif
endproc

procedure Verify_A1_P0
    select Sound 'soundname$'
    Edit
    editor Sound 'soundname$'
            Select... 'display_from' 'display_until'
            Zoom to selection
            Move cursor to... 'timepoint'
    endeditor
    select Spectrum 'soundname$'
    Edit
    editor Spectrum 'soundname$'
            Zoom... 0 3250
            Move cursor to... 'f1_spec'
    endeditor
    # puts nothing at the bottom of the picture, just to iraise picture to the top
    Text bottom... yes
    beginPause ("If all measurements are valid, click Continue")
		comment ("If manual measurements are required, make them and enter them below")
		comment ("H1 Amplitude")
			real ("manh1amp", 'h1_amp:2')
		comment ("H1 Frequency")
			real ("manh1freq", 'h1:0')
		comment ("H2 Amplitude")
			real ("manh2amp", 'h2_amp:2')
		comment ("H2 Frequency")
			real ("manh2freq", 'h2:0')
		comment ("A1 Amplitude")
			real ("mana1amp", 'a1_spec:2')
		comment ("A1 Frequency")
			real ("mana1freq", 'f1_spec:0')
		comment ("F2 Frequency")
			real ("manf2freq", 'f2_lpc:0')
		comment ("P1 Amplitude")
			real ("manp1amp", 'p1amp:2')
		comment ("P1 Frequency")
			real ("manp1freq", 'p1freq:0')
	  endPause ("Continue", 1)
    editor Sound 'soundname$'
            Close
    endeditor
	  editor Spectrum 'soundname$'
                Close
    endeditor
	a1amp = mana1amp
	f1freq = mana1freq
	h1amp = manh1amp
	h1freq = manh1freq
	h2amp = manh2amp
	h2freq = manh2freq
	f2freq = manf2freq
	p1amp = manp1amp
	p1freq = manp1freq
endproc

procedure Log_output
	if uhoh = 1
		select Strings tempfile
		a1amp = 0
		f1freq = 0
		h1amp = 0
		h1freq = 0
		h2amp = 0
		h2freq = 0
	endif
	if manual = 1
		stat$ = "Verify"
	endif
	# Calculate all the A1-P0 etc
	a1p0h1 = a1amp - h1amp
	a1p0h2 = a1amp - h2amp
	a1p0h3 = a1amp - h3amp
	if h1amp > h2amp
		a1p0high = a1p0h1
		highp0 = h1freq
		highp0amp = h1amp
		highlabel$ = "H1"
	elsif h2freq > hip0
		a1p0high = a1p0h1
		highp0 = h1freq
		highp0amp = h1amp
		highlabel$ = "H1"
	else
		a1p0high = a1p0h2
		highp0 = h2freq
		highp0amp = h2amp
		highlabel$ = "H2"
	endif
	a1p1 = a1amp - p1amp
	p0amp = highp0amp
	# Compensate data using Chen's formulae to lessen the effects of surrounding formants (see Chen 1995, 1997)
	t1 = ((((0.5 * f1b_lpc) ^ 2) + (f1_lpc) ^ 2) / (((((0.5 * f1b_lpc) ^ 2) + ((f1_lpc - highp0) ^ 2)) * (((0.5 * f1b_lpc) ^ 2) + ((f1_lpc + highp0) ^ 2))) ^ 0.5))
	t2 = ((((0.5 * f2b_lpc) ^ 2) + (f2_lpc) ^ 2) / (((((0.5 * f2b_lpc) ^ 2) + ((f2_lpc - highp0) ^ 2)) * (((0.5 * f2b_lpc) ^ 2) + ((f2_lpc + highp0) ^ 2))) ^ 0.5))
	p1t1 = ((((0.5 * f1b_lpc) ^ 2) + (f1_lpc) ^ 2) / (((((0.5 * f1b_lpc) ^ 2) + ((p1freq - f1_lpc) ^ 2)) * (((0.5 * f1b_lpc) ^ 2) + ((f1_lpc + p1freq) ^ 2))) ^ 0.5))
	p1t2 = ((((0.5 * f2b_lpc) ^ 2) + (f2_lpc) ^ 2) / (((((0.5 * f2b_lpc) ^ 2) + ((f2_lpc - p1freq) ^ 2)) * (((0.5 * f2b_lpc) ^ 2) + ((f2_lpc + p1freq) ^ 2))) ^ 0.5))
	a1p0comp = a1amp - (highp0amp - t1 - t2)
	a1p1comp = a1amp - (p1amp - p1t1 - p1t2)
	a3p0 = f3amp - highp0amp

	# Now, we make sure to mark those tokens where P0 == F1
	if f1freq = highp0
		flag$ = "A1isP0"
	endif
    #save result to text file
		# header_row$ = "filename" + "," + "word" + "," + "vowel" + "," + "freq_f1" + "," + "amp_f1" +  ","  + "freq_h1" + "," + "amp_h1" + "," + "freq_h2" + "," + "amp_h2" + "," + "amp_h3" + "," + "amp_p0" + ",	" + "freq_p0" + "," + "p0prominence" + "," + "a1p0_h1" + "," + "a1p0_h2"  + "," + "a1p0_h3" + "," + "a1p0" + "," + "a1p0_compensated" + "," + "freq_p1" + "," + "amp_p1" + "," + "a1p1" + "," + "a1p1_compensated" + "," + "vwl_duration" + "," + "timepoint" + "," + "point_time" + "," + "point_vwlpct"
  result_row$ = "'soundname$'" + "," + "'word_label$'" + "," + "'vowel_label$'" + "," + "'f1freq:0'" + "," + "'a1amp:1'" + "," + "'f2freq:0'" + "," + "'f2amp:1'"  + "," + "'h1freq:0'" + "," + "'h1amp:1'" + "," + "'h2freq:0'" + "," + "'h2amp:1'" + "," + "'h3amp:1'" + "," + "'highp0amp:1'" + "," + "'highp0:0'" + "," + "'p0Prom:1'" + "," + "'a1p0h1:1'" + "," + "'a1p0h2:1'"  + "," + "'a1p0h3:1'" + "," + "'a1p0high:1'" + "," + "'a1p0comp:1'" + "," + "'p1freq:0'" + "," + "'p1amp:1'" + "," + "'a1p1:1'" + "," + "'a1p1comp:1'" + ","  + "'rndduration'" + "," + "'tpname'" + "," + "'timepoint:1'" + "," + "'vwlpct:1'"
	print_result_row$ = "'result_row$'" + newline$
	appendInfoLine: print_result_row$
  fileappend "'resultfile$'" 'print_result_row$'
endproc