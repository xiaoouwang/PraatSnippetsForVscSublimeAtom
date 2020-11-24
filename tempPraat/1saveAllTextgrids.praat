beginPause: "where to save?"
  text: "save path", "t"
clicked = endPause: "start",1
select all
textgrids# = selected# ("TextGrid")
for i to size(textgrids#)
    selectObject: textgrids#[i]
    name$ = selected$("TextGrid")
    Save as text file: save_path$ + name$ + ".TextGrid"
endfor
