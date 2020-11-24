form Dessin
word Titre_du_dessin
choice Etiquetage 1
	button oui
	button non
choice Voulez_vous_obtenir 1
	button Fo
	button spectrogramme
	button les_deux
endform



#---------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------

if etiquetage = 1

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------

textgrid = selected("TextGrid")
sound = selected("Sound")
start_sel = Get begin of selection
end_sel = Get end of selection


#Extract windowed selection... Rectangular 1 no
Extract sound selection (time from 0)
 
endeditor
sound = selected ("Sound")
select 'textgrid'
Extract part... 'start_sel' 'end_sel' no
textgrid = selected ("TextGrid")
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------

select 'sound'

# Prepare the Picture window and draw a chart grid for formant analysis:

	Erase all

Font size... 10
Viewport... 0 6 0 2
Viewport text... Centre Top 0 'titre_du_dessin$'
select 'sound'

Draw... 0 0 -1 1 no
#Draw... 0 0 0 0 no

Draw inner box
Marks left... 2 yes yes no


select 'textgrid'
nb = Get number of tiers
	if nb = 1
call dessin0
	elsif nb = 2
call dessin1
	elsif nb = 3
call dessin2
	endif


procedure dessin1

if voulez_vous_obtenir = 1

select 'sound'
To Pitch... 0.01 75 600
pitch = selected("Pitch")
select 'pitch'	

#--------------------------------------------------------------------------------------------------------------------------------
max = Get maximum... 0 0 Hertz Parabolic
max = (ceiling (max/100))/10
max = max*1000
#--------------------------------------------------------------------------------------------------------------------------------

Viewport... 0 6 1.5 2.92
Draw... 0 0 0 'max' no
Marks left... 3 yes yes no
Viewport... 0 6 0 4
select 'textgrid'
Draw... 0 0 no yes yes



elsif voulez_vous_obtenir = 2

select 'sound'
To Spectrogram... 0.005 6000 0.002 20 Gaussian
spectrogram = selected("Spectrogram")
select 'spectrogram'	

Viewport... 0 6 1.35 3.5
#Paint... 0 0 0 0 50 6 0 no
Paint... 0 0 0 0 100 yes 50 6 0 no
Draw inner box
Marks left... 3 yes yes no
Viewport... 0 6 0 5
select 'textgrid'
Draw... 0 0 no yes yes

			


elsif voulez_vous_obtenir = 3

select 'sound'
To Pitch... 0.01 75 600
pitch = selected("Pitch")
select 'pitch'	

#--------------------------------------------------------------------------------------------------------------------------------
max = Get maximum... 0 0 Hertz Parabolic
max = (ceiling (max/100))/10
max = max*1000
#--------------------------------------------------------------------------------------------------------------------------------

Viewport... 0 6 1.5 2.92
Draw... 0 0 0 'max' no
Marks left... 3 yes yes no
Viewport... 0 6 0 4
Draw inner box



select 'sound'
To Spectrogram... 0.005 6000 0.002 20 Gaussian
Draw inner box
# Marks left... 2 yes yes no
Viewport... 0 6 2.5 4.5
#Paint... 0 0 0 0 50 6 0 no
Paint... 0 0 0 0 100 yes 50 6 0 no
spectrogram = selected("Spectrogram")
select 'spectrogram'	

#Paint... 0 0 0 0 50 6 0 no
Paint... 0 0 0 0 100 yes 50 6 0 no
Marks left... 3 yes yes no
Viewport... 0 6 0 6.5

select 'textgrid'
Draw... 0 0 no yes yes

endif

endproc


procedure dessin2

if voulez_vous_obtenir = 1

select 'sound'
To Pitch... 0.01 75 600
pitch = selected("Pitch")
select 'pitch'	

#--------------------------------------------------------------------------------------------------------------------------------
max = Get maximum... 0 0 Hertz Parabolic
max = (ceiling (max/100))/10
max = max*1000
#--------------------------------------------------------------------------------------------------------------------------------

Viewport... 0 6 1.5 2.92
Draw... 0 0 0 'max' no
Marks left... 3 yes yes no
Viewport... 0 6 0 5
select 'textgrid'
Draw... 0 0 no yes yes



elsif voulez_vous_obtenir = 2

select 'sound'
To Spectrogram... 0.005 6000 0.002 20 Gaussian
spectrogram = selected("Spectrogram")
select 'spectrogram'	

Viewport... 0 6 1.5 3.5
#Paint... 0 0 0 0 50 6 0 no
Paint... 0 0 0 0 100 yes 50 6 0 no
Marks left... 3 yes yes no
# Draw inner box
Viewport... 0 6 0 6
select 'textgrid'
Draw... 0 0 no yes yes

			


elsif voulez_vous_obtenir = 3

select 'sound'
To Pitch... 0.01 75 600
pitch = selected("Pitch")
select 'pitch'	

#--------------------------------------------------------------------------------------------------------------------------------
max = Get maximum... 0 0 Hertz Parabolic
max = (ceiling (max/100))/10
max = max*1000
#--------------------------------------------------------------------------------------------------------------------------------

Viewport... 0 6 1.5 2.92
Draw... 0 0 0 'max' no
Marks left... 3 yes yes no
Viewport... 0 6 0 4
Draw inner box



select 'sound'
To Spectrogram... 0.005 6000 0.002 20 Gaussian


Viewport... 0 6 2.5 4.5
#Paint... 0 0 0 0 50 6 0 no
Paint... 0 0 0 0 100 yes 50 6 0 no
spectrogram = selected("Spectrogram")
select 'spectrogram'	

#Paint... 0 0 0 0 50 6 0 no
Paint... 0 0 0 0 100 yes 50 6 0 no
Marks left... 3 yes yes no
Draw inner box
Viewport... 0 6 0 7.25

select 'textgrid'
# j'ai change le premier choix booleen en "yes" pour visualiser les boundaries
Draw... 0 0 no yes yes

endif

endproc




procedure dessin0

if voulez_vous_obtenir = 1

select 'sound'
To Pitch... 0.01 75 600
pitch = selected("Pitch")
select 'pitch'	

#--------------------------------------------------------------------------------------------------------------------------------
max = Get maximum... 0 0 Hertz Parabolic
max = (ceiling (max/100))/10
max = max*1000
#--------------------------------------------------------------------------------------------------------------------------------


Viewport... 0 6 1.45 2.92

#Draw... 0 0 75 222 no
Draw... 0 0 0 'max' no
Marks left... 3 yes yes no
Viewport... 0 6 0 3.46
select 'textgrid'
Draw... 0 0 no yes yes



elsif voulez_vous_obtenir = 2

select 'sound'
To Spectrogram... 0.005 6000 0.002 20 Gaussian
spectrogram = selected("Spectrogram")
select 'spectrogram'	

Viewport... 0 6 1.35 3.5
#Paint... 0 0 0 0 50 6 0 no
Paint... 0 0 0 0 100 yes 50 6 0 no
Draw inner box
Marks left... 3 yes yes no
Viewport... 0 6 0 4.2
select 'textgrid'
Draw... 0 0 no yes yes

			


elsif voulez_vous_obtenir = 3

select 'sound'
To Pitch... 0.01 75 600
pitch = selected("Pitch")
select 'pitch'	

#--------------------------------------------------------------------------------------------------------------------------------
max = Get maximum... 0 0 Hertz Parabolic
max = (ceiling (max/100))/10
max = max*1000
#--------------------------------------------------------------------------------------------------------------------------------

Viewport... 0 6 1.5 2.92
#Draw... 0 0 75 222 no
Draw... 0 0 0 'max' no
Marks left... 3 yes yes no
Viewport... 0 6 0 4
Draw inner box



select 'sound'

# ici !!!

To Spectrogram... 0.005 5000 0.002 20 Gaussian
Draw inner box
# Marks left... 2 yes yes no
Viewport... 0 6 2.5 4.5

#Paint... 0 0 0 0 50 6 0 no
spectrogram = selected("Spectrogram")
select 'spectrogram'	

#Paint... 0 0 0 0 50 6 0 no
Paint... 0 0 0 0 100 yes 50 6 0 no
Marks left... 3 no yes no
Draw inner box
Viewport... 0 6 0 5.455

select 'textgrid'
Draw... 0 0 no yes yes

endif

endproc

select 'sound'
plus 'textgrid'





#---------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------
elsif etiquetage = 2

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------

sound = selected("Sound")
start_sel = Get begin of selection
end_sel = Get end of selection
Extract selection
endeditor
sound = selected ("Sound")

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------

select 'sound'

# Prepare the Picture window and draw a chart grid for formant analysis:

	Erase all

Font size... 10
Viewport... 0 6 0 2
Viewport text... Centre Top 0 'titre_du_dessin$'
select 'sound'

#Draw... 0 0 0 0 no
Draw... 0 0 -1 1 no


Draw inner box
Marks left... 2 yes yes no


if voulez_vous_obtenir = 1

select 'sound'
To Pitch... 0.01 75 600
pitch = selected("Pitch")
select 'pitch'	

#--------------------------------------------------------------------------------------------------------------------------------
max = Get maximum... 0 0 Hertz Parabolic
max = (ceiling (max/100))/10
max = max*1000
#--------------------------------------------------------------------------------------------------------------------------------

Viewport... 0 6 1.3 2.92
Draw... 0 0 0 'max' no
Marks left... 3 yes yes no
Viewport... 0 6 0 3
#select 'textgrid'
#Draw... 0 0 no yes yes
Draw inner box
Marks bottom... 6 yes yes no




elsif voulez_vous_obtenir = 2

select 'sound'
To Spectrogram... 0.005 6000 0.002 20 Gaussian
spectrogram = selected("Spectrogram")
select 'spectrogram'	

Viewport... 0 6 1.35 3.5
#Paint... 0 0 0 0 50 6 0 no
Paint... 0 0 0 0 100 yes 50 6 0 no
Draw inner box
Marks left... 3 yes yes no
Viewport... 0 6 0 3.5
#select 'textgrid'
#Draw... 0 0 no yes yes
Draw inner box
Marks bottom... 6 yes yes no
			


elsif voulez_vous_obtenir = 3

select 'sound'
To Pitch... 0.01 75 600
pitch = selected("Pitch")
select 'pitch'	

#--------------------------------------------------------------------------------------------------------------------------------
max = Get maximum... 0 0 Hertz Parabolic
max = (ceiling (max/100))/10
max = max*1000
#--------------------------------------------------------------------------------------------------------------------------------

Viewport... 0 6 1.5 2.92
Draw... 0 0 0 'max' no
Marks left... 3 yes yes no

Viewport... 0 6 1.23 3
Draw inner box

#--------------------------------------------------------------------------------------------------------------------------------


select 'sound'
To Spectrogram... 0.005 6000 0.002 20 Gaussian
Draw inner box
# Marks left... 2 yes yes no
Viewport... 0 6 2.25 4.25
#Paint... 0 0 0 0 50 6 0 no
Paint... 0 0 0 0 100 yes 50 6 0 no
spectrogram = selected("Spectrogram")
select 'spectrogram'	

#Paint... 0 0 0 0 50 6 0 no
Paint... 0 0 0 0 100 yes 50 6 0 no
Marks left... 3 yes yes no
Viewport... 0 6 0 4.25
Draw inner box
Marks bottom... 6 yes yes no

#select 'textgrid'
#Draw... 0 0 no yes yes

endif


endif
select 'sound'