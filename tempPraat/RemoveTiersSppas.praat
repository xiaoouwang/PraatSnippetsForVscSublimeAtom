# this script is designed to remove tiers in sppas
directory$ = "/Users/rosingle/Documents/sounds/temp"
if not endsWith(directory$,"/")
  directory$ = directory$ + "/"
endif
file_type$ = ".TextGrid"
Create Strings as file list... list 'directory$'*'file_type$'
number_files = Get number of strings

for ifile to number_files
	select Strings list
	textgridPath$ = Get string... ifile
	textGrid = Read from file... 'directory$''textgridPath$'
	# soundPath$ = 'textgrid$' - ".TextGrid" + ".wav"
  # sound = Read from file... 'directory$''soundPath$'
  numberTier = Get number of tiers
  if numberTier > 3
    Remove tier: 1
    Remove tier: 1
    Remove tier: 1
    Remove tier: 3
    Remove tier: 4
    Remove tier: 5
    Save as text file: "'directory$''textgridPath$'"
  endif
endfor
select Strings list
Remove
