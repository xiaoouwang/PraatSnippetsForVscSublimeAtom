dir$ = "/Users/xiaoou/Desktop/oooooo"
fList = Create Strings as file list: "list", dir$
nbOfFiles = Get number of strings
for i to nbOfFiles
  selectObject: fList
  fname$ = Get string: i
  appendInfoLine: fname$

  # Read from file: dir$ + "/" + fname$
  # do

endfor

appendInfoLine: "done! -.-"