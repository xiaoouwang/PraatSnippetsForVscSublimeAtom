form The output files will be in the results folder created in the Dossier
word regexp *.TextGrid
comment where are the textgrids ? 
text Dossier /Users/rosingle/Documents/these/cleanaccent/testScriptAPI2/
comment which tier
integer no_tier 3
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
	file_pinyin$ = path$ + line$ - ".TextGrid" + "_pinyin.txt"
	writeInfoLine: file_pinyin$
	table_row = 1
	Read from file... 'file$'
	textgrid = selected("TextGrid")
	Read Table from tab-separated file: file_pinyin$
	table = selected("Table")
	select 'textgrid'
	total_phonemes = Get number of intervals... no_tier    
	for x from 1 to total_phonemes
	    #current_syllable = syllable'l'	    
	    
		if x mod 2 = 0
		    label1$ = Get label of interval... no_tier x
			select 'table'
			label_pinyin$ = Get value: table_row, "Pinyin"
			select 'textgrid'
			Set interval text: no_tier-1,x,label_pinyin$	
			table_row = table_row+1
		endif
		
	endfor
outputfile$ = path_resultats$ + line$ - ".TextGrid" + "withpinyin.TextGrid" 
select 'textgrid'
Write to text file... 'outputfile$'
endfor

writeInfoLine: "completed"


##-----------------------------------------------    
# fin de la conversion du i-�me fichier, on enregistre
# on peut effacer eventuellement et passer au suivant

