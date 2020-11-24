ssssss
sssssss
form Play a sine wave
    positive Sine_frequency_(Hz) 377
    positive Gain_(0..1) 0.3 (= not too loud)
endform
Create Sound as pure tone: "sine" + string$(sine_frequency), 1, 0, 1, 44100, sine_frequency, gain, 0.01, 0.01
Play