form Extract_textgrid_info
	comment Dossier contenant les .wav
	text txtgrid_folder /Users/aamelot/Documents/DATABASE/speech_data/groupe-didactique/DAVID-22NOV/results
	comment Expression reguliere pour recuperer que les .textgrid (* = any string)
	text regexp *.TextGrid
	comment File separator (\ on Windows, / on MacOS X and Unix)
	word filesep /
	comment Ou se trouve la tier phoneme?
	positive phonemes_tier 1
endform

# effacer les informations de la fenêtre windows
clearinfo

# donne la liste des fichiers textgrid contenu dans le dossier
Create Strings as file list... filelist 'txtgrid_folder$''filesep$''regexp$'

ntxt = Get number of strings

# boucle sur tous les fichiers .TextGrid
for itxt to ntxt
select Strings filelist
	txt$ = Get string... itxt
	printline Processing file 'txt$'...
	Read from file... 'txtgrid_folder$''filesep$''txt$'
    Rename... current_tg
	ntiers = Get number of tiers

printline 'txt$'
	
# ouvre le son rms piezo correspondant		
sndpiezo$ = txt$ - ".TextGrid" + "_piezo_rms" + ".wav"

# ouvre le son rms audio correspondant	
sndaudio$ =  txt$ - ".TextGrid" + "_audio_rms" + ".wav"

results_file$ = txt$ - ".TextGrid" + "results" + ".txt"

# Delete results file if it already exists
filedelete 'results_file$'
# Write the results file header
fileappend 'results_file$' textgrid_file'tab$'label'tab$'start'tab$'end'tab$'duration(s)'tab$'moy_audio_rms'tab$'mid_audio_rms'tab$'deb_audio_rms'tab$'fin_audio_rms'tab$'mean_piezo_rms'tab$'mid_piezo_rms'tab$'deb_piezo_rms'tab$'fin_piezo_rms'newline$'

#printline 'sndpiezo$'

#printline 'sndaudio$'

Read from file... 'txtgrid_folder$''filesep$''sndaudio$'
Rename... current_snd

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
			if length(label$)>0
				select TextGrid current_tg
				start_time = Get start point... 'phonemes_tier' 'iinterv'
				end_time = Get end point... 'phonemes_tier' 'iinterv'
				duration = end_time-start_time
				mid_time = start_time + ((duration*1) / 2)
				deb_time = start_time + ((duration*1) / 5) 
				fin_time = start_time + ((duration*4) / 5)
				#printline 'deb_time'
				#printline 'mid_time'
				#printline 'fin_time'
				# il serait bien aussi de rajouter la mesure rms au début, milieu et fin de phonème à la place du min et du max
				select Sound current_snd
				mean_snd = Get mean... 'start_time' 'end_time'
				mid_snd = Get value at time... 0 mid_time Nearest
				deb_snd = Get value at time... 0 deb_time Nearest
				fin_snd = Get value at time... 0 fin_time Nearest
				select Sound current_piezo
				mean_piezo = Get mean... 'start_time' 'end_time'
				mid_piezo = Get value at time... 0 mid_time Nearest
				deb_piezo = Get value at time... 0 deb_time Nearest
				fin_piezo = Get value at time... 0 fin_time Nearest
				fileappend 'results_file$' 'txt$''tab$''label$''tab$''start_time''tab$''end_time''tab$''duration''tab$''mean_snd''tab$''mid_snd''tab$''deb_snd''tab$''fin_snd''tab$''mean_piezo''tab$''mid_piezo''tab$''deb_piezo''tab$''fin_piezo''newline$'
				endif
		endfor

		select TextGrid current_tg
		plus Sound current_snd
		plus Sound current_piezo
		Remove
		
endfor
