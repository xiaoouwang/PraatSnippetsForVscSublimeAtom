##################################################
##
## Downsamples specified .wav files  to 22050
##
## Pauline Welby, welby@ling.ohio-state.edu
## July 21, 2002
##
####################################################

form    Input directory name without final slash
        word dirName /Users/rosingle/OneDrive/sounds/signalExplorer/
        comment To overwrite existing files, use same directory for output directory.
        word outDir /Users/rosingle/OneDrive/sounds/signalExplorer/
        comment Specify new sampling rate.
        positive newrate 22050
endform

# Warn the user against overwriting files
if "'dirName$'" == "'outDir$'"
  pause Input and output directories are the same. Files will be OVERWRITTEN. Continue?
endif


# Creates a list of files to be worked on
#Read Strings from raw text file... 'dirName$'\list.txt

Create Strings as file list... list 'dirName$'/*.wav

# loop that goes through all files

numberOfFiles = Get number of strings
for ifile to numberOfFiles
   select Strings list
   fileName$ = Get string... ifile
   baseFile$ = fileName$ - ".wav"

   # Read in the Sound file with that base name

   Read from file... 'dirName$'/'baseFile$'.wav

   #resample
   select Sound 'baseFile$'
   Resample... 'newrate' 50

   # save file
   Write to WAV file... 'outDir$'/'baseFile$'.wav

   # object cleanup
   Remove
   select Sound 'baseFile$'
   Remove

endfor

# complete object cleanup
select Strings list
Remove

### END OF SCRIPT ###