# Add boundaries to include the whole length of nasal vowels beside n
# Add boundary if not present
# numberTier = Get number of tiers
# if numberTier > 1
# Remove tier: 2
# endif
Insert interval tier: 2, "Mot"
nombreInterval = Get number of intervals: 1
for number from 1 to nombreInterval
	label$ = Get label of interval: 1, number
	if number < nombreInterval
		labelLeft$ = Get label of interval: 1, number+1
    endif
	if number >1
		labelRight$ = Get label of interval: 1, number-1
	endif
	if right$ (label$, 4) = "oral" 
		intervalStart = Get start time of interval: 1, number
		Insert boundary: 2, intervalStart
		if right$ (labelLeft$, 4) <> "asal" 
# and labelLeft$ <> ""
			intervalEndd = Get end time of interval: 1, number
			Insert boundary: 2, intervalEndd
		endif
	elsif right$ (label$, 4) = "asal"	
		intervalEnd = Get end time of interval: 1, number 
		Insert boundary: 2, intervalEnd
		if right$ (labelRight$, 4) <> "oral" and labelRight$ <>"" 
			intervalEndd = Get start time of interval: 1, number
			Insert boundary: 2, intervalEndd
		endif
	endif
endfor

# now here is for adding text, the temp is to indicate the token number (like 11 for first token first speed [slow])
temp = 1
nombreInterval2 = Get number of intervals: 2
for number2 from 1 to nombreInterval2
	if number2 mod 2 = 0	
		lowerIntervalTime = Get start time of interval: 2, number2
		higherIntervalNumber = Get interval at time: 1, lowerIntervalTime
		labelHigher$ = Get label of interval: 1, higherIntervalNumber
		
		if right$ (labelHigher$, 4) = "oral" and temp mod 2 = 1
			labelHigher$ = labelHigher$ - "oral" + "1"
		elsif right$ (labelHigher$, 4) = "oral" and temp mod 2 = 0
			labelHigher$ = labelHigher$ - "oral" + "2" 
		elsif right$ (labelHigher$, 4) = "nasal" and temp mod 2 = 1
			labelHigher$ = labelHigher$ - "nasal"  + "1"
		elsif right$ (labelHigher$, 4) = "nasal" and temp mod 2 = 0
			labelHigher$ = labelHigher$ - "nasal"  + "2"
		endif
		temp = temp + 1
		Set interval text... 2 number2 'labelHigher$'
	endif
endfor


