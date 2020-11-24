form The output files will be in the results folder created in the Dossier
	word regexp *.TextGrid
	word seperator /
	integer tiernb 1
endform



textgrid_dir$ = chooseDirectory$: "Where are the textgrids and sounds"
path_resultats$ = textgrid_dir$ + "/results/"
type$=regexp$
createDirectory: path_resultats$ 
textgrid$ =  textgrid_dir$+seperator$+type$
string_files = Create Strings as file list: "list", textgrid$
num_files = Get number of strings

for i from 1 to num_files
	select 'string_files'
	file$ = Get string... i
	file_path$ = textgrid_dir$ + seperator$+file$
	sound$ = file$ - "TextGrid" + "wav"
	sound_path$ = textgrid_dir$ + seperator$+ sound$
	textgrid = Read from file: file_path$
	intervalnumber = Get number of intervals: tiernb
	total_phonemes = Get number of intervals... tiernb 
	sound_file = Read from file: sound_path$	
	select 'textgrid'
	plus 'sound_file'
	View & Edit
	editor: textgrid
	Select: 1, 2
	Zoom to selection
	Zoom out
	Zoom out
	Zoom out
	pauseScript: "present file ", file$, " file remaining : ", num_files-i
	endeditor
	select 'textgrid'
	Write to text file... 'outputfile$'
	selectObject: textgrid
	plusObject: sound_file
	Remove
endfor

appendInfoLine: "Today is ", date$(), ". Great script by the wang(way)"



##-----------------------------------------------    
# fin de la conversion du i-�me fichier, on enregistre
# on peut effacer eventuellement et passer au suivant

