# le second script pour superposer les courbes rms avec le signal acoustique

form Extract_textgrid_info
	comment Expression reguliere pour recuperer que les .txt (* = any string)
	text regexp *piezo.txt
	comment File separator (\ on Windows, / on MacOS X and Unix)
	word filesep /
endform

# effacer les informations de la fenêtre windows
clearinfo
txt_folder$ = chooseDirectory$ ("Choose the directory containing txt files")
# donne la liste des fichiers wav contenu dans le dossier
Create Strings as file list... filelist 'txt_folder$''filesep$''regexp$'
ntxt = Get number of strings

# boucle sur tous les fichiers .wav
for itxt to ntxt
	select Strings filelist
	txt$ = Get string... itxt
	Read Matrix from raw text file... 'txt_folder$''filesep$''txt$'
	matrix = selected("Matrix")
	Transpose
	matrix2 = selected("Matrix")
	To Sound (slice)... 1


	############### A CHANGER EN FONCTION DE LA FREQUENCE D ECHANTILLONNAGE
	Override sample rate... 100
	sound_temp = selected("Sound")


	############### PERMET DE DECALER LE SON D UNE DEMI SECONDE .............
	longueur_totale = Get finishing time
	Extract part... 0.5 'longueur_totale' Rectangular 1 no
	new_sound = selected("Sound")

	# maintenant on enregistre le fichier son

	sv_name$ = txt_folder$+filesep$+txt$ - ".txt"

	sv_name_rms$ = sv_name$ + "_rms"  + ".wav"

	Save as WAV file... 'sv_name_rms$'

endfor

select all
# Remove

printline 'c'est fini !!!'

