### file and directory operations beginning
# create file list
readFiles
Create Strings as file list: "list", "*.wav"
# read a file
readFile
Read from file: $1
# read long file
readLongFile
Open long sound file: $1
# save wav file
saveWav
Save as WAV file: $1
# save txt file (textgrid too)
saveTxt
Save as text file: $1
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
crFolder
createDirectory: "$0:directoryPath"
# create directory
crDirectory
createDirectory: "$0:directoryPath"
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
# allow user to choose directory
chooseDirectory
chooseDirectory$: "$1:chooseTheDirectoryContainingSound"
# allow user to choose file to open
chooseFile
chooseReadFile$: "$1:open a file"