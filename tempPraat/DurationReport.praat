# add i1 i2 to textgrid and add i~ = 0 if no i~ found 

chemin$ = "/Users/rosingle/Desktop/RFP/EmreAnalysis/"

# creer la liste des fichiers wav dans un repertoire

liste_fichiers = Create Strings as file list: "list", chemin$ + "*.TextGrid"
nombreDeFichiers = Get number of strings

# Create a header row for the result file: (remember to edit this if you add or change the analyses!)
tableau = Create Table with column names: "monTableau", 0, "Fichier	Label	Duration"

# Open each sound file in the directory:
for ifichier from 1 to nombreDeFichiers
	selectObject: liste_fichiers
	nomDuFichier$ = Get string: ifichier
	textgrid_filename$ = chemin$ + nomDuFichier$
	if fileReadable (textgrid_filename$)
    	tg = Read from file: chemin$ + nomDuFichier$
    	selectObject: tg
		numberOfIntervals = Get number of intervals... 1
		# Pass through all intervals in the designated tier, and if they have a label, do the analysis:
		for interval to numberOfIntervals
			label$ = Get label of interval... 1 interval
			if label$ <> "" and label$ <> "SIL" and label$ <> "p" and label$ <> "n" and label$ <> "t"
				# duration:
				start = Get starting point... 1 interval
				end = Get end point... 1 interval
				duration = (end-start) * 1000
				duration$ = fixed$(duration,0)
				interval2 = Get interval at time: 2, start+0.01
				#appendInfoLine : interval2
				label3$ = Get label of interval... 1 interval+1
				label4$ = Get label of interval... 2 interval2
				#appendInfoLine : label4$
				start = Get starting point... 2 interval2
				end = Get end point... 2 interval2
				duration4 = (end-start) * 1000
				duration4$ = fixed$(duration4,0)
				selectObject(tableau)
  				Append row
  				current_row = Get number of rows
  				# On insère les valeurs dans le tableau
  				Set string value: current_row, "Fichier", nomDuFichier$ - ".Textgrid"
  				Set string value: current_row, "Label", label$
  				Set string value: current_row, "Duration", duration$
				Append row
				current_row = Get number of rows
				Set string value: current_row, "Fichier", nomDuFichier$ - ".Textgrid"
  				Set string value: current_row, "Label", label$+"percentage"
  				Set string value: current_row, "Duration", fixed$((duration/duration4)*100,0)+"%"
				if label3$ = "n" and (label$ = "a1" or label$ = "i1" or label$ = "u1" or label$ = "o1" or label$ = "a2" or label$ = "i2" or label$ = "u2" or label$ = "o2" or label$ = "a3" or label$ = "i3" or label$ = "u3" or label$ = "o3" or label$ = "a4" or label$ = "i4" or label$ = "u4" or label$ = "o4")
					nolabel$ = label$ + "~"
					duration2 = 0
					duration2$ = "0"
					Append row
					current_row = Get number of rows
					Set string value: current_row, "Fichier", nomDuFichier$ - ".Textgrid"
					Set string value: current_row, "Label", nolabel$
					Set string value: current_row, "Duration", duration2$
					Append row
					current_row = Get number of rows
					Set string value: current_row, "Fichier", nomDuFichier$ - ".Textgrid"
					Set string value: current_row, "Label", nolabel$+"percentage"
					Set string value: current_row, "Duration", fixed$((duration2/duration4)*100,0)+"%"
					lastLabel$ = Get value: current_row, "Label"
				endif
				lastLabel$ = Get value: current_row, "Label"
				if lastLabel$ = "a1~percentage" or lastLabel$ = "i1~percentage" or lastLabel$ = "o1~percentage" or lastLabel$ = "u1~percentage" or lastLabel$ = "a2~percentage" or lastLabel$ = "i2~percentage" or lastLabel$ = "o2~percentage" or lastLabel$ = "u2~percentage" or lastLabel$ = "a3~percentage" or lastLabel$ = "i3~percentage" or lastLabel$ = "o3~percentage" or lastLabel$ = "u3~percentage" or lastLabel$ = "a4~percentage" or lastLabel$ = "i4~percentage" or lastLabel$ = "o4~percentage" or lastLabel$ = "u4~percentage"
					Append row
					current_row = Get number of rows
					Set string value: current_row, "Fichier", nomDuFichier$ - ".Textgrid"
					Set string value: current_row, "Label", label4$
					Set string value: current_row, "Duration", duration4$
				endif				

				# appendInfoLine: lastLabel$
				# if lastLabel$ = "a~" or lastLabel$ = "i~" or lastLabel$ = "u~" or lastLabel$ = "o~" 
	
				# endif
						# select the TextGrid so we can iterate to the next interval:
        		selectObject: tg
			endif
		endfor
		Remove
	endif
	# and go on with the next sound file!
endfor
selectObject: tableau
Save as tab-separated file: chemin$ + "tableau.txt"