bandwidth_file$ = "bandwidthLogBackA.csv"
writeFileLine: bandwidth_file$, "limit,pitch,b1,b2"
# writeFileLine: bandwidth_file$, "timepoint,pitch,timepoint,b1,b2"
# create 5 different back a
pitch = 90
f1 = 700
f2 = 1000
b1 = 60
b2 = 80
# for i from 1 to 10
    limit = 5600
    timepoint = 0.2
    duration = 0.325
    # pitch = pitch+10
    Create KlattGrid: "backa", 0, duration, 5, 1, 1, 0, 0, 0, 0
    Add pitch point: 0.15, pitch
    Add open phase point: 0.1, 0.5
    Add voicing amplitude point: 0.1, 90
    Add oral formant frequency point: 1, 0.1, f1
    Add oral formant bandwidth point: 1, 0.1, b1
    Add oral formant frequency point: 2, 0.1, f2
    Add oral formant bandwidth point: 2, 0.1, b2
    To Sound
    for j from 1 to 5
      limit = limit - 100
      To Formant (burg): 0, 5, limit, 0.025, 50
      b1 = Get bandwidth at time: 1, timepoint, "hertz", "Linear"
      b2 = Get bandwidth at time: 2, timepoint, "hertz", "Linear"
      appendFileLine: bandwidth_file$, "'limit','pitch','b1:0','b2:0'"
      selectObject: "Sound backa"
    endfor
    selectObject: "Sound backa"
    Remove
    for j from 1 to 9
      timepoint = timepoint + 0.03
      timepoint = 'timepoint:2'
      b1 = Get bandwidth at time: 1, timepoint, "hertz", "Linear"
      b2 = Get bandwidth at time: 2, timepoint, "hertz", "Linear"
      appendFileLine: bandwidth_file$, "'timepoint','pitch','b1:0','b2:0'"
      # appendFileLine: bandwidth_file$, "'limit','pitch','timepoint','b1','b2'"
    endfor
# endfor




