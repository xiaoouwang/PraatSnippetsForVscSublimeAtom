# Add boundaries to include the whole length of nasal vowels beside n
# Add boundary if not present
numberTier = Get number of tiers
while numberTier > 1
Remove tier: 2
numberTier = numberTier - 1
endwhile
Insert interval tier: 2, "Mot"
nombreInterval = Get number of intervals: 1
for number from 1 to nombreInterval
	label$ = Get label of interval: 1, number
	if number < nombreInterval
		labelRight$ = Get label of interval: 1, number+1
    endif
	if number >1
		labelLeft$ = Get label of interval: 1, number-1
	endif
	if right$ (label$, 4) = "oral" 
		if right$ (labelLeft$, 1) = "1"
			intervalStart = Get start time of interval: 1, number-1	
			Insert boundary: 2, intervalStart
		else 
			intervalStart = Get start time of interval: 1, number
			Insert boundary: 2, intervalStart
		endif

		if right$ (labelRight$, 4) <> "asal" 
# and labelLeft$ <> ""			
			intervalEndd = Get end time of interval: 1, number
			Insert boundary: 2, intervalEndd
		endif
	elsif right$ (label$, 4) = "asal"	
		intervalEnd = Get end time of interval: 1, number 
		Insert boundary: 2, intervalEnd
		if right$ (labelLeft$, 4) <> "oral" and labelLeft$ <>"" 
			intervalStart = Get start time of interval: 1, number
			Insert boundary: 2, intervalStart
		endif
	endif
endfor

# now here is for adding text, the temp is to indicate the token number (like 11 for first token first speed [slow])
temp = 1
nombreInterval2 = Get number of intervals: 2
for number2 from 1 to nombreInterval2
	if number2 mod 2 = 0	
	## left time for the upper interval
		lowerIntervalTime = Get start time of interval: 2, number2
		higherIntervalNumber = Get interval at time: 1, lowerIntervalTime
		labelHigher$ = Get label of interval: 1, higherIntervalNumber
		labelHigherleft$ = Get label of interval: 1, higherIntervalNumber-1
		labelHigherleftleft$ = Get label of interval: 1, higherIntervalNumber-2
		if right$ (labelHigher$, 4) = "oral" and temp mod 4 = 1
			if right$ (labelHigherleft$, 1) = "1"
				labelHigher$ = labelHigherleftleft$+labelHigher$ - "oral" + "1"	
			else
				labelHigher$ = labelHigherleft$+labelHigher$ - "oral" + "1"	
			endif
		elsif right$ (labelHigher$, 4) = "oral" and temp mod 4 = 2
			if right$ (labelHigherleft$, 1) = "1"
				labelHigher$ = labelHigherleftleft$+labelHigher$ - "oral" + "2"	
			else
				labelHigher$ = labelHigherleft$+labelHigher$ - "oral" + "2"	
			endif
		elsif right$ (labelHigher$, 4) = "oral" and temp mod 4 = 3 
			if right$ (labelHigherleft$, 1) = "1"
				labelHigher$ = labelHigherleftleft$+labelHigher$ - "oral" + "3"	
			else
				labelHigher$ = labelHigherleft$+labelHigher$ - "oral" + "3"	
			endif
		elsif right$ (labelHigher$, 4) = "oral" and temp mod 4 = 0
			if right$ (labelHigherleft$, 1) = "1"
				labelHigher$ = labelHigherleftleft$+labelHigher$ - "oral" + "4"	
			else
				labelHigher$ = labelHigherleft$+labelHigher$ - "oral" + "4"	
			endif

		elsif right$ (labelHigher$, 4) = "asal" and temp mod 4 = 1
			labelHigher$ = labelHigherleft$+labelHigher$ - "nasal"  + "1"
		elsif right$ (labelHigher$, 4) = "asal" and temp mod 4 = 2
			labelHigher$ = labelHigherleft$+labelHigher$ - "nasal"  + "2"
		elsif right$ (labelHigher$, 4) = "asal" and temp mod 4 = 3
			labelHigher$ = labelHigherleft$+labelHigher$ - "nasal"  + "3"
		elsif right$ (labelHigher$, 4) = "asal" and temp mod 4 = 0
			labelHigher$ = labelHigherleft$+labelHigher$ - "nasal"  + "4"
		elsif right$ (labelHigher$, 4) = "sal1" and temp mod 4 = 1
			labelHigher$ = labelHigherleft$+labelHigher$ - "nasal1"  + "1"
		elsif right$ (labelHigher$, 4) = "sal1" and temp mod 4 = 2
			labelHigher$ = labelHigherleft$+labelHigher$ - "nasal1"  + "2"
		elsif right$ (labelHigher$, 4) = "sal1" and temp mod 4 = 3
			labelHigher$ = labelHigherleft$+labelHigher$ - "nasal1"  + "3"
		elsif right$ (labelHigher$, 4) = "sal1" and temp mod 4 = 0
			labelHigher$ = labelHigherleft$+labelHigher$ - "nasal1"  + "4"

		endif
		temp = temp + 1
		Set interval text... 2 number2 'labelHigher$'
	endif
endfor


