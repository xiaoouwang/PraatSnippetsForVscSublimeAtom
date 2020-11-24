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
path_resultats$ = path$ + "/results/"
type$="'regexp$'"



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
    
for x from 1 to total_phonemes
    #current_syllable = syllable'l'
    
    select 'textgrid'
    label$ = Get label of interval... no_tier x


##-----------------------------------------------
# si la langue est le fran�ais ...
call francais
##-----------------------------------------------    
# attention n'integrer cette fonction que s'il a trouv� une conversion possible, sinon ne rien faire ....
Set interval text... no_tier x 'new_label$'

endfor

##-----------------------------------------------    
# fin de la conversion du i-�me fichier, on enregistre
# on peut effacer eventuellement et passer au suivant

outputfile$ = path_resultats$ + line$
select 'textgrid'
Write to text file... 'outputfile$'

if effacer = 1
select all
minus 'string'
nocheck Remove
endif 

##-----------------------------------------------    
endfor


##-----------------------------------------------
##-----------------------------------------------
##-----------------------------------------------
##-----------------------------------------------
##-----------------------------------------------
# procedures de conversions 

procedure francais

if (label$ = "S-n") 
    new_label$ = "\swn"
elsif (label$ = "@`")
    new_label$ = "\r."
elsif (label$ = "p_h")
    new_label$ = "p\^h"
elsif (label$ = "t_h")
    new_label$ = "t\^h"
elsif (label$ = "k_h")
    new_label$ = "k\^h"
elsif (label$ = "s`")
    new_label$ = "\s."
elsif (label$ = "z`")
    new_label$ = "\z."
elsif (label$ = "S")
    new_label$ = "\rh"
elsif (label$ = "ss")
    new_label$ = "\cc"
elsif (label$ = "N")
    new_label$ = "\ng"
elsif (label$ = "i_d")
    new_label$ = "z"
elsif (label$ = "i`")
    new_label$ = "\z."
elsif (label$ = "ts")
    new_label$ = "\ts"
elsif (label$ = "tss")
    new_label$ = "t\cc"
elsif (label$ = "ts_h")
    new_label$ = "t\s.^h"
elsif (label$ = "ts`")
    new_label$ = "t\s."
elsif (label$ = "ts_h`")
    new_label$ = "t\cc^h"
elsif (label$ = "ts_hs")
    new_label$ = "t\cc"
else
    new_label$ = label$
endif	

endproc