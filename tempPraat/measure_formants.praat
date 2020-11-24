
####################################
## measure_formants.praat
##
## This script measures F1 and F2
## of all labeled intervals on a given tier
## for all sounds in a given directory.
##
## - Measurements taken at end, beginning, and
##   user-specified number of label-internal points.
## - Parameters may need to be set differently for different speakers.
##
## jessamyn.schertz@utoronto.ca
## February 5, 2017
#####################################

beginPause: "User input"
	word: "homedir", "data/"
	positive: "labelTier", 1
	positive: "wordTier", 2
	comment: "Number of measurement points, including beginning and end"
	comment: "(3 = midpoint, 4 = every 1/3, 5 = every 1/4)"
	positive: "numPoints", 3
	comment: "Recommending ceiling is 4500 for male and 5000 for female"
	positive: "formantCeiling", 5000
	positive: "numForm", "5"
	word: "output", "formant_measures.txt"
endPause: "Continue", 1

clearinfo
call makeHeader

## MAIN LOOP ########################

files = Create Strings as file list: "filenames", homedir$+"*.TextGrid"
numFiles = Get number of strings

for file from 1 to numFiles
	select files
	filename$ = Get string: file
	filename$ = filename$ - ".TextGrid"
	sound = Read from file: homedir$+filename$+".wav"
	tg = Read from file: homedir$+filename$+".TextGrid"
	numInt = Get number of intervals: labelTier
	for int from 1 to numInt
		select tg
		label$ = Get label of interval: labelTier, int
		if label$ <> ""
			appendInfoLine: filename$+tab$+label$
			start = Get starting point: labelTier, int
			end = Get end point: labelTier, int
			dur = end-start
			wordInt = Get interval at time: wordTier, start
			word$ = Get label of interval: wordTier, wordInt
			select sound
			formant = To Formant (burg): 0, numForm, formantCeiling, 0.025, 50
			forNum = 1
			call getValues
			f1$ = values$
			forNum = 2
			call getValues
			f2$ = values$
			select formant
			Remove
			call writeToOutput
		endif
	endfor
	select sound
	plus tg
	Remove
endfor


## PROCEDURES ############################

procedure makeHeader
	colsF1$ = ""
	colsF2$ = ""
	for i from 1 to numPoints
		colsF1$ = colsF1$+"f1_"+"'i'"+tab$
		colsF2$ = colsF2$+"f2_"+"'i'"+tab$
	endfor
	header$ = "filename	label	word	"
	header$ = header$ + "startTime	endTime	"
	header$ = header$ + colsF1$+ colsF2$-tab$
	writeFileLine: output$, header$
endproc

procedure writeToOutput
	info$ = filename$+tab$+label$+tab$+word$+tab$
	info$ = info$+"'start'"+tab$+"'end'"+tab$
	info$ = info$+f1$+f2$-tab$
	appendFileLine: output$, info$
endproc

procedure getValues
	values$ = ""
	for i from 0 to numPoints-1
		measureTime = start + i*(dur/(numPoints-1))
		value = Get value at time: forNum, measureTime, "Hertz","Linear"
		values$ = values$+"'value'"+tab$
	endfor
endproc


