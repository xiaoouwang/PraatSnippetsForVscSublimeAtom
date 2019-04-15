### file and directory operations
# remove a file
remove
Remove
# play a sound
play
Play
# play a pitch
playPitch
Hum
# create directory
createDirectory
createDirectory: $1:directoryPath
# delete file
deleteFile
deleteFile: $1:filePath
# check file existence and readability
checkFile
fileReadable ($1)
$0
# write line to file
writeLineToFile
writeFileLine: "$1:filePath", $2:content
$0
# append line to file, no need to have the file prexisting
appendLine
appendFileLine: "$1:filePath", $2:content
$0
#
