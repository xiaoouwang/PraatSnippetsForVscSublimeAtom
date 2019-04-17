### information beginning
# write information in new line
writeLine
writeInfoLine: $1:multipleInfoSeperatedByComma
$0
# append information in new line
appendLine
appendInfoLine: $1:multipleInfoSeperatedByComma
$0
# clear information
clear
clearinfo
# output the info window
printInfoWindow
appendFile: "$1:outputFilePath", info$()
$0
### interaction with user
# allow user to choose directory
chooseDirectory
chooseDirectory$: "$1:chooseTheDirectoryContainingSound"
# allow user to choose file to open
chooseFile
chooseReadFile$: "$1:open a file"
# create a form
form
form $1
  $2
endform