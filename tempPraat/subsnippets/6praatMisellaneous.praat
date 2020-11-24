### others beginning
# mac
mac
macintosh
# windows
windows
windows
# unix
unix
unix
# unix
linux
unix
# tab character
tab
tab$
# newline character
newLine
newline$
# select a variable
select
selectObject: $0
# minus a variable
minus
minusObject: $0
# plus a variable
plusObject
plusObject: $0
# select a spectrum
selectSpectrum
selectObject: "Spectrum $0"
# minus a spectrum
minusSpectrum
minusObject: "Spectrum $0"
# plus a spectrum
plusSpectrum
plusObject: "Spectrum $0"
# select a TextGrid
selectTextGrid
selectObject: "TextGrid $0"
# minus a spectrum
minusTextGrid
minusObject: "TextGrid $0"
# plus a spectrum
plusTextGrid
plusObject: "TextGrid $0"
# select an object
selectSound
selectObject: "Sound $0"
# minus an object
minusSound
minusObject: "Sound $0"
# plus an object
plusSound
plusObject: "Sound $0"
### conditions and loop
# for loop
for
for i from 1 to $1
  $0:doSomething
endfor
# while loop
while
while $1
  $2
endwhile
$0
# if
if
if $1
  $0
endif
# if else
ifelse
if $1
  $2
elsif $3
  $4
endif
$0
# if exist
ifexist
if $1 <> ""
  $0
endif
# tokens
crTokens
Create Strings as tokens: $1, "$0:space"
# exist2
exist2
$0 <> ""
# safe remove end
safeRemoveEnd
@ids.final
# safe remove start
safeRemoveStart
@ids
initialSelections$ = ids.ids$
# safe remove proc
safeRemoveProc
procedure ids.final
@ids
finalSelections$ = ids.ids$
wangIds = Create Strings as tokens: finalSelections$ , "$0:space"
nbOfStr = Get number of strings
for i from 1 to nbOfStr
  select wangIds
  id = Get string: i
  if index (initialSelections$ , string$ (id) ) = 0
    selectObject: id
    Remove
  endif
endfor
removeObject: wangIds
endproc

procedure ids
  endeditor
  select all
  textgrids# = selected# ("TextGrid")
  .ids$ = ""
  for i from 1 to size (textgrids#)
    selectObject: textgrids# [i]
    .id = selected ("TextGrid")
    .ids$ = .ids$ +  "$0: '.id'"
  endfor
  select all
  sounds# = selected# ("Sound")
  for i from 1 to size (sounds#)
    selectObject: sounds# [i]
    .id = selected ("Sound")
    .ids$ = .ids$ + "$0: '.id'"
  endfor
endproc
