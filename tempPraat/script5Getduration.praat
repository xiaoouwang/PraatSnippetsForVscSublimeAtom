# check nasality begin point


form Extract_textgrid_info
	comment Expression reguliere pour recuperer que les .textgrid (* = any string)
	text regexp *.TextGrid
	comment File separator (\ on Windows, / on MacOS X and Unix)
	word filesep /
	comment Ou se trouve la tier phoneme?
	positive phonemes_tier 3
endform


directory$ = chooseDirectory$ ("Choose the directory containing sound files and textgrids")
file$ = "resultats_log_file4.txt"
outputfile$ = "'directory$'" + "/" + file$


## create if not existent, otherwise just append
if fileReadable (outputfile$)

else
fileappend 'outputfile$' subj'tab$'gender'tab$'vowel'tab$'f1'tab$'f2'tab$'f3'newline$'
endif

# effacer les informations de la fenêtre windows
# clearinfo

# donne la liste des fichiers textgrid contenu dans le dossier

Create Strings as file list... filelist 'directory$''filesep$''regexp$'

ntxt = Get number of strings

# boucle sur tous les fichiers .TextGrid
clearinfo
for itxt to ntxt
select Strings filelist
	txt$ = Get string... itxt
	# printline Processing file 'txt$'...
	Read from file... 'directory$''filesep$''txt$'
    Rename... current_tg
	ntiers = Get number of tiers

# printline 'txt$'
	

# Extract info from every non-empty interval
select TextGrid current_tg
ninterv = Get number of intervals... 'phonemes_tier'
# Loop every interval on reference tier
	for iinterv from 1 to ninterv
		select TextGrid current_tg
		label$ = Get label of interval... 'phonemes_tier' 'iinterv'
		# Do something only if the interval label is not empty
		if label$ = "oral"
			start_time = Get start point... 'phonemes_tier' 'iinterv'
			end_time = Get end point... 'phonemes_tier' 'iinterv'
			duration_oral = round((end_time - start_time)*1000)
			## Tweak to get the interval label
			interval_number = Get interval at time: 1, start_time
			appendInfoLine: interval_number
			interval_label$ = Get label of interval: 1, interval_number
			start_timebis = Get start point... 'phonemes_tier' 'iinterv'+1
			end_timebis = Get end point... 'phonemes_tier' 'iinterv'+1
			duration_nasal = round((end_timebis - start_timebis)*1000)
				fileappend 'outputfile$' 'interval_label$''tab$''duration_oral''tab$''duration_nasal''newline$'
		endif

	endfor
endfor
