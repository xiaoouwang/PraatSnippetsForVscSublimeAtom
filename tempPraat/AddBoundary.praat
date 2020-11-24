# Add boundaries if left is a consonant or right is n or m
nombreInterval = Get number of intervals: 1
for number from 1 to nombreInterval
	label$ = Get label of interval: 1, number
	if label$ = "t" or label$ = "p" or label$ = "k" or label$ = "s" or label$="l" or label$="m" or label$="n" 
		intervalEnd = Get end time of interval: 1, number 
		intervalStart = Get start time of interval: 1, number
		Insert boundary: 2, intervalStart
		Insert boundary: 2, intervalEnd
	endif
endfor
