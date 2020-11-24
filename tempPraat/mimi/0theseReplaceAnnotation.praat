# test on one TextGrid
# select all
# textgrids# = selected# ("TextGrid")
# selectObject: textgrids#[1]
clearinfo

dir$ = "/Users/xiaoou/Desktop/ooo0724/fr3/alex1107/done/haha"
fList = Create Strings as file list: "list", dir$ + "/*.TextGrid"
nbOfFiles = Get number of strings
tier = 1
starting_interval = 1
for i to nbOfFiles
	selectObject: fList
	# make textgrid path = tgPath$
	tgName$ = Get string: i
	tgPath$ = dir$ + "/" + tgName$
	# make labelfile path = labelPath$ = without extension + .txt
	tokens = Create Strings as tokens: tgName$, "."
	labelName$ = Get string: 1
	labelPath$ = dir$ + "/" + labelName$ + ".txt"
	tg = Read from file: tgPath$
	# do here for each file
	# make the replacement after testing the two files exist
	selectObject: tg
	nbTiers = Get number of tiers
	if fileReadable (tgPath$) and fileReadable (labelPath$) and nbTiers < 2
		nbOfIntervals = Get number of intervals: tier
		# appendInfoLine: nbOfIntervals
		# createt the dictionary to pattern$
		labelFile = Read Strings from raw text file: labelPath$
		nbLabelsLabel = Get number of strings
		# appendInfoLine: nbLabelsLabel
		# read label file
	  for k to nbLabelsLabel
			selectObject: labelFile
			# take a line
			tokens$ = Get string: k
			# appendInfoLine: tokens$
			hehe = Create Strings as tokens: tokens$, " "
			# take the 3 columns
			nb = Get string: 1
			# appendInfoLine: nb
			temp = nb + k
			nb2$ = Get string: 2
			nb3$ = Get string: 3
			# create the dictionary
			pattern$[temp] = nb2$
			pattern$[temp+300] = nb3$
			# appendInfoLine: k," ", nb, " ", temp, " ", temp + 100, " ", nb2$," ", nb3$
			# appendInfoLine: nb, nb2$
			# appendInfoLine: pattern$[temp], pattern$[temp+100], pattern$[102]
			selectObject: hehe
			Remove
    endfor
		# appendInfoLine: length
		appendInfoLine: "----------------"
		# get total number of labels to be replaced
		totalLabelsTg = 0
		selectObject: tg
		Duplicate tier: 1, 2, "phoneme"
		Duplicate tier: 1, 3, "sequence"
		for ii from 1 to nbOfIntervals
			oldlabel$ = Get label of interval: tier, ii
			# count number intervals in the textgrid
			# if is number
			if number(oldlabel$) <> undefined
				totalLabelsTg = totalLabelsTg + 1
			endif
		endfor
		# find the total labels in the label file
		appendInfoLine: "total labels in the label file 'tgName$' 'nbLabelsLabel'"
		appendInfoLine: "total labels to be replaced in the textgrid 'labelName$'.txt 'totalLabelsTg'"
		if totalLabelsTg <> nbLabelsLabel
		#  and totalLabelsTg <> 0
			beginPause: "CAUTION!!!"
				comment: "total labels in the label file 'tgName$': 'nbLabelsLabel'"
				comment: "total labels to be replaced in the textgrid 'labelName$'.txt: 'totalLabelsTg'"
				comment: "          not the same number of labels, continue ? if not 0 click stop    "
			clicked = endPause: "continue", 1
			# pauseScript: "not the same number of labels, continue?"
		endif
		# replace
		startNewLabel = 1
		for jj to nbOfIntervals
			oldlabel = Get label of interval: tier, jj
			oldlabel$ = Get label of interval: tier, jj
			# change label if it's a number
			# appendInfoLine: number(oldlabel$)
			if number(oldlabel$) <> undefined
				# selectObject: labelFile
				# newlabel$ = pattern[oldlabel]
			  ## refer to line 38
			  indexLabel = oldlabel + startNewLabel
				selectObject: tg
				phonemeLabel$ = pattern$[indexLabel]
				sequenceLabel$ = pattern$[indexLabel+300]
				# appendInfoLine: indexLabel, " ", indexLabel+100, " ", phonemeLabel$, " ", sequenceLabel$
				# appendInfoLine: "hehe"
				# appendInfoLine: indexLabel
				# label the phoneme tier
				Set interval text: tier+1,jj,phonemeLabel$
				# label the sequence tier
				Set interval text: tier+2,jj,sequenceLabel$
				appendInfoLine: "old label: 'oldlabel$' new label : 'phonemeLabel$' new sequence label: 'sequenceLabel$'"
				startNewLabel += 1
			endif
		endfor
		# save interval
		Save as text file: tgPath$
		labelsReplaced = startNewLabel - 1
		appendInfoLine: "total labels replaced 'labelsReplaced'"
	selectObject: labelFile, tg
	Remove
	else
		pauseScript: "already replaced or no label file found for 'tgName$'"
	endif
removeObject: tokens
endfor
removeObject: fList
appendInfoLine: "done! :)"

