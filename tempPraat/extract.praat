clearinfo
# This script saves each interval in the selected IntervalTier of a TextGrid to a separate WAV sound file.
# The source sound must be a Sound object, and both the TextGrid and
# the Sound must have identical names and they have to be selected
# before running the script.
# Files are named with the corresponding interval labels (plus a running index number when necessary).
#
# NOTE: You have to take care yourself that the interval labels do not contain forbidden characters!!!!
#
# This script is distributed under the GNU General Public License.
# Copyright 8.3.2002 Mietta Lennes
#
# exclude_empty_labels = 1

exclude_empty_labels = 1
exclude_intervals_labeled_as_xxx = 1
exclude_intervals_starting_with_dot = 1
start_from = 1
end_at = 0
tier = 2
margin = 0.01
prefix$ = ""
suffix$ = ""

dir$ = "/Users/xiaoou/Documents/theseGit/stereoXingyuWithScript/nasal/chinese/fast/"
folder$ = dir$ + "out/"
createDirectory: folder$
fList = Create Strings as file list: "list", dir$ + "/*.wav"
nbOfFiles = Get number of strings





for i from 1 to nbOfFiles
  selectObject: fList
  fName$ = Get string: i
  # appendInfoLine: fName$
  fPath$ = Read from file: dir$ + fName$
  temp$ = fName$ - ".wav"
  appendInfoLine: temp$
  # do
  tgPath$ = Read from file: dir$ + temp$ + ".TextGrid"
  appendInfoLine: fPath$, tgPath$
  # appendInfoLine: tgPath
  # selectObject: fPath
  # plusObject: fPath
  selectObject: "Sound 'temp$'"
  plusObject: "TextGrid 'temp$'"
  @extract
  # selectObject: "Sound 'temp$'"
  # plusObject: "TextGrid 'temp$'"
  # Remove
endfor




procedure extract
  gridname$ = selected$ ("TextGrid", 1)
  soundname$ = selected$ ("Sound", 1)
  select TextGrid 'gridname$'
  numberOfIntervals = Get number of intervals... tier
  if start_from > numberOfIntervals
  	exit There are not that many intervals in the IntervalTier!
  endif
  end_at = numberOfIntervals
  endif

  # Default values for variables
  files = 0
  intervalstart = 0
  intervalend = 0
  interval = 1
  intname$ = ""
  intervalfile$ = ""
  endoffile = Get finishing time

  # ask if the user wants to go through with saving all the files:
  for interval from start_from to end_at
  	xxx$ = Get label of interval... tier interval
  	check = 0
  	if xxx$ = "xxx" and exclude_intervals_labeled_as_xxx = 1
  		check = 1
  	endif
  	if xxx$ = "" and exclude_empty_labels = 1
  		check = 1
  	endif
  	if left$ (xxx$,1) = "." and exclude_intervals_starting_with_dot = 1
  		check = 1
  	endif
  	if check = 0
  	   files = files + 1
  	endif
  endfor
  interval = 1
  pause 'files' sound files will be saved. Continue?
  # appendInfoLine: "check ", check
  # Loop through all intervals in the selected tier of the TextGrid
  for interval from start_from to end_at
  	select TextGrid 'gridname$'
  	intname$ = ""
  	intname$ = Get label of interval... tier interval
  	check = 0
  	if intname$ = "xxx" and exclude_intervals_labeled_as_xxx = 1
  		check = 1
  	endif
  	if intname$ = "" and exclude_empty_labels = 1
  		check = 1
  	endif
  	if left$ (intname$,1) = "." and exclude_intervals_starting_with_dot = 1
  		check = 1
  	endif
    # appendInfoLine: check
  	if check = 0
  		intervalstart = Get starting point... tier interval
  			if intervalstart > margin
  				intervalstart = intervalstart - margin
  			else
  				intervalstart = 0
  			endif

  		intervalend = Get end point... tier interval
  			if intervalend < endoffile - margin
  				intervalend = intervalend + margin
  			else
  				intervalend = endoffile
  			endif
      # save textgrid too
      selectObject: "TextGrid 'gridname$'"
      Extract part: intervalstart, intervalend, "no"
  		filename$ = intname$
  		tgfile$ = "'folder$'" + "'prefix$'" + "'filename$'" + "'suffix$'" + ".TextGrid"
      appendInfoLine: tgfile$
      # Save as text file: tgfile$
      Save as text file: tgfile$
  		select Sound 'soundname$'
      Extract part: intervalstart, intervalend, "rectangular", 1, "no"
  		intervalfile$ = "'folder$'" + "'prefix$'" + "'filename$'" + "'suffix$'" + ".wav"
  		# indexnumber = 0
  		# while fileReadable (intervalfile$)
  		# 	indexnumber = indexnumber + 1
  		# 	intervalfile$ = "'folder$'" + "'prefix$'" + "'filename$'" + "'suffix$''indexnumber'" + ".wav"
  		# endwhile
  		Write to WAV file... 'intervalfile$'
  		# Remove
  	endif
  endfor
endproc

select all
Remove
appendInfoLine: "done :)"