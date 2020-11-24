# theseReviseTextgrids by Xiaoou WANG
clearinfo
interval_tiers$ = ""
point_tiers$ = ""
if_TextGrid_already_exists = 3
sound_file_extension$ = ".wav"

directory$ = "/Users/xiaoou/Documents/theseGit/stereoXingyuWithScript/nasal/chinese/fast"
fileEnd$ = right$ (directory$, 4)
# must end in trio
if fileEnd$ <> "trio"
  beginPause: "please annotate in the trio folder"
    text: "problem", "warning, please annotate in the trio folder"
  clicked = endPause: "continue malgre l'avertissement", 1
endif
@getFiles: directory$, sound_file_extension$

tiers$ = interval_tiers$ + " " + point_tiers$
# extract the person info from the directory path
lenDir = length(directory$)
slashIndex = rindex (directory$, "/")
person$ = right$ (directory$, lenDir - slashIndex)
for i to getFiles.length
    soundfile = Read from file: getFiles.files$ [i]
    hahaname$ = selected$("Sound")
    @getTextGrid: getFiles.files$ [i]
    haha$ = getTextGrid.path$
    if !fileReadable (getTextGrid.path$) or if_TextGrid_already_exists > 1
        selectObject: soundfile, getTextGrid.textgrid
        hehe = getTextGrid.textgrid
        View & Edit

        beginPause: "Annotation"
            comment: "listIntervals to check!!!"
            comment: "Press OK when done to save."
            comment: "the person is 'person$' the file is 'hahaname$'"
        endPause: "OK", 0
        # appendInfoLine: "test"
        endeditor
        selectObject: hehe
        Save as text file: haha$

        removeObject: hehe

    endif

    removeObject: soundfile

endfor

procedure getTextGrid: .soundfile$
    .path$ = replace$: .soundfile$, sound_file_extension$, ".TextGrid", 0

    if !fileReadable: .path$
        .textgrid = To TextGrid: tiers$, point_tiers$

    elif if_TextGrid_already_exists == 2
        .textgrid = To TextGrid: tiers$, point_tiers$
        .default$ = mid$: .path$, rindex (.path$, "/") + 1, length (.path$)
        .default$ = replace$: .default$, sound_file_extension$, ".TextGrid", 1

        .path$ = chooseWriteFile$: "TextGrid already exists in this directory.
        ... Choose where to save the new TextGrid.", .default$

    elif if_TextGrid_already_exists == 3
        .textgrid = Read from file: .path$

    endif

endproc

procedure getFiles: .dir$, .ext$
    .obj = Create Strings as file list: "files", .dir$ + "/*" + .ext$
    .length = Get number of strings

    for .i to .length
        .fname$ = Get string: .i
        .files$ [.i] = .dir$ + "/" + .fname$

    endfor

    removeObject: .obj

endproc
appendInfoLine: "done! :)"