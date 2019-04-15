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
# create a form
form
form $1
$2
endform
$0
# create an option menu
option
optionmenu $1:text $2:defaultvalue(2)
option $3
option $4
# create a comment
comment
comment $1:chosseFro
