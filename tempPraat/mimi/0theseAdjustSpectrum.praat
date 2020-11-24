tgName$ = selected$("TextGrid")
editor: "TextGrid 'tgName$'"
info$ = Editor info
# appendInfoLine: info$
time = extractNumber(info$,"Spectrogram window length:")
# appendInfoLine: time
if time = 0.005
Spectrogram settings: 0, 5000, 0.01, 70
elsif time = 0.01
Spectrogram settings: 0, 5000, 0.02, 70
elif time = 0.02
Spectrogram settings: 0, 5000, 0.005, 70
# elsif time = 0.01
# Spectrogram settings: 0, 5000, 0.02, 70
endif
# Create Strings as tokens: "info$", ""

# appendInfoLine: "done! -.-"