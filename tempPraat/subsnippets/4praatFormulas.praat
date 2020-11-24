### formulas beginning
# round number to zero
round
round($1:number)
# round number to decimal precision
roundPrecision
number(fixed$($1:number,$2:1precision))
$0
# passband filter
passband
Filter (pass Hann band): $1:from, $0:to , 100