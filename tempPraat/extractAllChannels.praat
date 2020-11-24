folder$ = chooseDirectory$ ("Choose the directory containing sound files")+"/"
# creer la liste des fichiers wav dans un repertoire

liste_fichiers = Create Strings as file list: "list", folder$ + "*stereo.wav"

nombreDeFichiers = Get number of strings

for ifichier from 1 to nombreDeFichiers
	selectObject: liste_fichiers
	nomDuFichier$ = Get string: ifichier   
	son = Read from file: folder$ + nomDuFichier$
	selectObject: son
	son1 = Extract one channel: 1
    nowarn Write to WAV file: folder$ +"/"+ nomDuFichier$ - "stereo.wav"+"ch1.wav" 
	selectObject: son
	son2 = Extract one channel: 2
    nowarn Write to WAV file: folder$ +"/"+ nomDuFichier$ - "stereo.wav"+"ch2.wav" 
	selectObject: son
	son3 = Extract one channel: 3
    nowarn Write to WAV file: folder$ +"/"+ nomDuFichier$ - "stereo.wav"+"ch3.wav" 
# prevent Praat from issuing warning messages
    selectObject: son1
	plusObject: son
    plusObject: son2
    plusObject: son3
    Remove
endfor

