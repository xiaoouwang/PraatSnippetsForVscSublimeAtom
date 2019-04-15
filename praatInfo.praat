### information window
# write information
write
writeInfoLine: $1
$0
# append information
append
appendInfoLine: $1
$0
# clear information
clear
clearinfo
# output the info window
printInfoWindow
appendFile: "$1:outputFilePath", info$ ( )
$0
