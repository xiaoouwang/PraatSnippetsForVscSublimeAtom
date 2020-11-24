# check nasality begin point
form Extract_textgrid_info
	comment Dossier contenant les .wav
	text txtgrid_folder /Users/rosingle/blog/piezo/yongxinPiezo/YongxinTry/
	comment Expression reguliere pour recuperer que les .textgrid (* = any string)
	text regexp *point.TextGrid
	comment File separator (\ on Windows, / on MacOS X and Unix)
	word filesep /
	comment Ou se trouve la tier phoneme?
	positive phonemes_tier 1
endform

# effacer les informations de la fenêtre windows
# clearinfo

# donne la liste des fichiers textgrid contenu dans le dossier
Create Strings as file list... filelist 'txtgrid_folder$''filesep$''regexp$'

ntxt = Get number of strings

# boucle sur tous les fichiers .TextGrid
for itxt to ntxt
select Strings filelist
	txt$ = Get string... itxt
	# printline Processing file 'txt$'...
	Read from file... 'txtgrid_folder$''filesep$''txt$'
    Rename... current_tg
	ntiers = Get number of tiers

# printline 'txt$'
	
# ouvre le son rms piezo correspondant	 without naming this object	
sndpiezo$ = txt$ - ".TextGrid" + "_piezo_rms.wav"

### Piezo_name
Read from file... 'txtgrid_folder$''filesep$''sndpiezo$'
Rename... current_piezo

# Extract info from every non-empty interval
select TextGrid current_tg
ninterv = Get number of intervals... 'phonemes_tier'
# Loop every interval on reference tier
	for iinterv from 1 to ninterv
		select TextGrid current_tg
		label$ = Get label of interval... 'phonemes_tier' 'iinterv'
		# Do something only if the interval label is not empty
		if label$ = "a"
			select TextGrid current_tg
			start_time = Get start point... 'phonemes_tier' 'iinterv'
			end_time = Get end point... 'phonemes_tier' 'iinterv'
			duration = end_time - start_time
			## Get max here
			select Sound current_piezo
			max_nasality = Get maximum: start_time, end_time, "None"
			#appendInfoLine: max_nasality
		endif
		if label$ <> "" and label$ <> "p" and label$ <> "u"
			select TextGrid current_tg
			#appendInfoLine:label$
			start_timebis = Get start point... 'phonemes_tier' 'iinterv'
			#appendInfoLine:start_timebis
			end_timebis = Get end point... 'phonemes_tier' 'iinterv'
			#appendInfoLine:end_timebis
			durationbis = end_timebis - start_timebis
			# select TextGrid current_tg
			# nb_pas = 0.01
			nb_pas = 0.01
			iii = start_timebis
	#		iiii = 0
			#appendInfoLine: iiii
			hhhh = 0
			while iii <= end_timebis
				#appendInfoLine:label$
				fen = iii + nb_pas;
				select Sound current_piezo
				rms_value = Get root-mean-square... 'iii' 'fen'
				if rms_value > max_nasality
					nasality_begin_marker = (fen+iii)/2
					select TextGrid current_tg
					Insert point: 2, 'nasality_begin_marker', ""
					if hhhh = 0
						Insert boundary: 3, 'nasality_begin_marker'
						interval_number = Get interval at time: 3, 'nasality_begin_marker'
						Set interval text: 3, interval_number, "nasal"
						Set interval text: 3, interval_number-1, "oral"
						hhhh = 1
					endif
			#		appendInfoLine : "hahaha"
					# hhhh = iiii + 1
				endif
				iii = iii + nb_pas
				# if hhhh > 1
				# 	iii = end_timebis+1
				# endif
			endwhile
			# fen = 0
		endif
	endfor
	# select TextGrid current_tg
	# plus Sound current_piezo
	# Remove	
endfor
