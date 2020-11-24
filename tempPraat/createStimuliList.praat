# modify this line to specify the stimuli directory with no ending slash and extention
@createStimuliList: "/Users/rosingle/Documents/theseEcriture/donneesThese/wanda", ".wav"

procedure createStimuliList: .directory$, .extension$
    # specify directory path
  # createStimuliList.directory$ = "/Users/rosingle/Documents/theseEcriture/donneesThese/wanda"
  # add "/" on mac or unix and "/" on windows
  if macintosh or unix
    .directory$ = .directory$ + "/"
  elsif windows
    .directory$ = .directory$ + "\"
  endif
  .fileExtension$ = .extension$
  Create Strings as file list: "createStimuliList", .directory$ + "/*" + createStimuliList.fileExtension$
  .numberFiles = Get number of strings

  # add quotes to meet the required praat stimuli list format
  for i from 1 to .numberFiles
    .text$ = Get string: i
    appendInfoLine: """'.text$'"" """""
  endfor
endproc

