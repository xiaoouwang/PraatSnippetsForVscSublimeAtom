form The output files will be in the results folder created in the Dossier
word regexp *.TextGrid
comment where are the textgrids ? 
text Dossier /Users/rosingle/Documents/piezo/fanny/testScriptAPI2/
comment which tier
integer no_tier 5
comment ?
boolean effacer no
endform


path$ = "'dossier$'"
path_resultats$ = path$ + "results/"
type$="'regexp$'"
# writeInfoLine: path_resultats$
createDirectory: path_resultats$ 
Create Strings as file list... liste 'path$''type$'
string = selected("Strings")
noliftt = Get number of strings

for i from 1 to noliftt
	select 'string'
	line$ = Get string... i
	file$ = path$ + line$
	Read from file... 'file$'
	textgrid = selected("TextGrid")
	total_phonemes = Get number of intervals... no_tier
    
	for x from 2 to total_phonemes
	    #current_syllable = syllable'l'
	    
	    select 'textgrid'
		label_left$ = Get label of interval... no_tier x-1
		if x < total_phonemes-10
		
	    label1$ = Get label of interval... no_tier x
		label2$ = Get label of interval... no_tier x+1
		label3$ = Get label of interval... no_tier x+2
		label4$ = Get label of interval... no_tier x+3
		# appendInfoLine: label1$,label2$,label3$,label4$,label5$
		endif
		if label_left$ = "#" 
			if label1$ <> "#" and label2$ <> "#" and label3$ <> "#" and label4$ <> "#"
				lower_time = Get start time of interval: no_tier, x
				lower_time = lower_time + 0.0001
				interval_number = Get interval at time: no_tier-1, lower_time
				label_combined$ = label1$+label2$+label3$+label4$
				Set interval text: no_tier-1,interval_number,label_combined$
			elif label1$ <> "#" and label2$ <> "#" and label3$ <> "#"
				lower_time = Get start time of interval: no_tier, x
				lower_time = lower_time + 0.0001
				interval_number = Get interval at time: no_tier-1, lower_time
				label_combined$ = label1$+label2$+label3$
				Set interval text: no_tier-1,interval_number,label_combined$
			elsif label1$ <> "#" and label2$ <> "#" 
				lower_time = Get start time of interval: no_tier, x
				lower_time = lower_time + 0.0001
				interval_number = Get interval at time: no_tier-1, lower_time
				label_combined$ = label1$+label2$	
				Set interval text: no_tier-1,interval_number,label_combined$
			elsif label1$ <> "#"
				lower_time = Get start time of interval: no_tier, x
				lower_time = lower_time + 0.0001
				interval_number = Get interval at time: no_tier-1, lower_time
				label_combined$ = label1$
				Set interval text: no_tier-1,interval_number,label_combined$
			endif
		endif
	outputfile$ = path_resultats$ + line$
	select 'textgrid'
	Write to text file... 'outputfile$'
	endfor
endfor
writeInfoLine: "completed"


##-----------------------------------------------    
# fin de la conversion du i-�me fichier, on enregistre
# on peut effacer eventuellement et passer au suivant

