### information beginning
# write (overwrite)
print
writeInfoLine: $0
# write (overwrite)
write
writeInfoLine: $0
# write (new line)
println
appendInfoLine: $0
# write (new line)
append
appendInfoLine: $0
# clear information
clear
clearinfo
# output the info window
printInfoWindow
appendFile: "$1:outputFilePath", info$()
$0
# create a form
crForm
form $1
  $0
endform
# convert to string
toString
string$($0)
# convert to number
toNumber
number($0)
# check file exists
exist1
fileReadable: ($0)
# get object type
getType
type$ = extractWord$ ($1:fullname, "$0")
# get object name
getName
name$ = extractLine$ ($1:fullname, "$0:space")
# get object numbers sound or others
getNumberSelected
nb = numberOfSelected("Sound")
# home
home
homeDirectory$
# undefined
und
undefined
# exit
exit
exit $0:message
# replace interval
replaceInterval
Replace interval texts: 1, 1, 0, "a", "sound", "Literals" # 1,0 = all the intervals
# concatenate
concat
Concatenate
# select all
selectAll
select all
# get start of selection
getStartSelec
Get start of selection
