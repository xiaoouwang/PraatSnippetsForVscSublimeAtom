writeInfoLine: "script"
compression = 1
number_of_channels = 2
worth = 3
# for i to 5
    beginPause: "Hi"
       comment: "Type a lot of nonsense below."
       natural: "Number of people", 10
       real: "Worth", worth + 1
       positive: "Sampling frequency (Hz)", "44100.0 (= CD quality)"
       word: "hi", "hhh"
       sentence: "lo", "two words"
       text: "shortText", "some one-line text here"
       boolean: "You like it?", 1
       if worth < 6
          choice: "Compression", compression
             option: "lossless (FLAC)"
             option: "MP3"
             option: "Ogg"
       endif
       optionMenu: "Number of channels", number_of_channels
          option: "mono"
          option: "stereo"
          option: "quadro"
       comment: "Then click Stop or one of the continuation buttons."
    clicked = endPause: "adjust", "ok", 2
    appendInfoLine: " ", clicked
    # appendInfoL ne: "Compression: ", compression, " (", compression$, ")"
    # appendInfoLine: "Number of channels: ", number_of_channels$
    # appendInfoLine: "Short text: ", shortText$
    # appendInfoLine: "Long text: ", longText$
# endfor

appendInfoLine: "end"