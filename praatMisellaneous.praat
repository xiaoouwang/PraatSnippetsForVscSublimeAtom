### others
# create a form
form
form $1
$2
endform
$0
# tab character
tab
tab$
# newline character
newLine
newline$
# select an object
selObject
selectObject: $1
$0
# enter edit window
edit
Edit
#
### conditions and loop
# for loop
for
for i from 1 to $1
  $1:doSomething
endfor
$0
# while loop
while
while $1
  $2
endwhile
$0
# if
if
if
  $1
endif
$0
# if else
ifelse
if $1
  $2
elsif $3
  $4
endif
$0
#
