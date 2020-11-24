#
# appendInfoLine: "hehe"
clearinfo
sounds# = selected#("Sound")
len = size(sounds#)
for i to len
  selectObject: sounds#[i]
  # clearinfo
  thisSound$ = selected$("Sound")
  if fileReadable: (thisSound$)
    pauseScript: "this file already exists at ",right$ (fn$, 40)
  endif
  Save as WAV file: thisSound$
  # Save as text file: fn$
  appendInfoLine: "'thisSound$' saved"
endfor
