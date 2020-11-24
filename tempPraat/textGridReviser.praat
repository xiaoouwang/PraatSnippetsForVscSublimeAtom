# copyright 2019-09-05-Thu Xiaoou WANG
# open a list of files
# define the directory
directory$ = "/Users/rosingle/Documents/theseEcriture/donneesThese/wanda"
# add "/" on mac or unix and "/" on windows
if macintosh or unix
  directory$ = "'directory$'" + "/"
elsif windows
  directory$ = "'directory$'" + "\"
endif
fileExtension$ = ".TextGrid"
Create Strings as file list: "list", directory$ + "/*" + fileExtension$
numberFiles = Get number of strings

for i to numberFiles
	selectObject: "Strings list"
	fileName$ = Get string: i
  filePath$ = directory$+fileName$
  fileNameNoExt$ = fileName$ - ".TextGrid"
	textGrid = Read from file: filePath$
  sound = Read from file: directory$+fileName$ - "TextGrid" + "wav"
	if fileReadable(filePath$)
      selectObject: textGrid
      plusObject: sound
			Edit
			editor: "TextGrid " + fileNameNoExt$
				beginPause ("If finished, click OK.")
					skipstat = endPause("OK", 1)
			endeditor
			selectObject: textGrid
			if skipstat == 1
				Save as text file: directory$ + fileName$
			endif
		endif
		selectObject: textGrid
		plusObject: sound
		Remove
	endif
endfor
selectObject: "Strings list"
Remove