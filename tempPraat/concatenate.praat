# select all
# Remove
dir$ = "/Users/xiaoou/Documents/theseGit/stereoXingyuWithScript/nasal/chinese/fast/out/"
fList = Create Strings as file list: "list", dir$ + "*.wav"
nbOfFiles = Get number of strings
for i from 1 to nbOfFiles
  selectObject: fList
  fName$ = Get string: i
  fPath$ = Read from file: dir$ + fName$
  # do
endfor
select all
sounds# = selected# ("Sound")
for i to size (sounds#)
    if i = 1
      selectObject: sounds# [i]
    else
      plusObject: sounds#[i]
    endif
endfor
Concatenate
Save as WAV file: dir$ + "long.wav"
select all
Remove


dir$ = "/Users/xiaoou/Documents/theseGit/stereoXingyuWithScript/nasal/chinese/fast/out/"
fList = Create Strings as file list: "list", dir$ + "*.TextGrid"
nbOfFiles = Get number of strings
for i from 1 to nbOfFiles
  selectObject: fList
  fName$ = Get string: i
  fPath$ = Read from file: dir$ + fName$
  # do
endfor
select all
sounds# = selected# ("TextGrid")
for i to size (sounds#)
    if i = 1
      selectObject: sounds# [i]
    else
      plusObject: sounds#[i]
    endif
endfor
Concatenate
Save as text file: dir$ + "long.TextGrid"
# Save as WAV file: dir$ + "long.wav"
select all
Remove
appendInfoLine: "done"