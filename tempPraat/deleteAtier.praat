dir$ = "/Users/xiaoou/Desktop/ooo0724/fr3/alex1107/donetrio"
fList = Create Strings as file list: "list", dir$ + "/*.TextGrid"
nbOfFiles = Get number of strings
for i from 1 to nbOfFiles
  selectObject: fList
  fName$ = Get string: i
  f = Read from file: dir$ + "/" + fName$
  # do
  Remove tier: 3
  Save as text file: dir$ + "/" + fName$
endfor