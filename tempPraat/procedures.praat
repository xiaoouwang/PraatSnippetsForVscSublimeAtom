# A framework of praat. The main advantage is a list of predefined variables.
# new ideas welcome at https://github.com/xiaoouwang/Praat_R_Scripts_for_Phonetics_XiaoouWANG
# Copyright Xiaoou WANG 2019-09-07-Sat

# which folder and which extension ?
writeInfoLine: "starting..."

@doF: "/Users/rosingle/Documents/theseEcriture/donneesThese/wanda", ".wav"
# do what ?
outputPath$ = "/Users/rosingle/Documents/theseEcriture/donneesThese/wanda/wandaResults.csv"
if fileReadable(outputPath$)
else
  appendFileLine: outputPath$, "subj,file,phoneme,word,start,mid,end,duration,f15mean,f25mean,f35mean,f45mean,f15median,f25median,f35median,f45median,f11mean,f12mean,f13mean,f14mean,f15mean,f16mean,f17mean,f18mean,f19mean,f21mean,f22mean,f23mean,f24mean,f25mean,f26mean,f27mean,f28mean,f29mean,f31mean,f32mean,f33mean,f34mean,f35mean,f36mean,f37mean,f38mean,f39mean,f41mean,f42mean,f43mean,f44mean,f45mean,f46mean,f47mean,f48mean,f49mean,f11median,f12median,f13median,f14median,f15median,f16median,f17median,f18median,f19median,f21median,f22median,f23median,f24median,f25median,f26median,f27median,f28median,f29median,f31median,f32median,f33median,f34median,f35median,f36median,f37median,f38median,f39median,f41median,f42median,f43median,f44median,f45median,f46median,f47median,f48median,f49median"
endif

for i from 1 to doF.numberFiles
  selectObject: doF.list
  fileName$ = Get string: i
  sound = Read from file: doF.directory$+ fileName$
  # men
  # formant = noprogress To Formant (burg): 0, 5, 5000, 0.025, 50
  formant = noprogress To Formant (burg): 0, 5, 5500, 0.025, 50
  textgrid = Read from file: doF.directory$ + fileName$ - ".wav" + ".TextGrid"
  numberTiers = Get number of tiers
  numberIntervals = Get number of intervals: 1
  for j from 1 to numberIntervals
    label_1tier$ = Get label of interval: 1, j
    if label_1tier$ <> ""
      startTime = Get start point: 1, j
      endTime = Get end point: 1, j
      duration = endTime - startTime
      midPoint = startTime + duration/2
      # 9 steps to get 4 points + midpoint + 4 points
      step = duration/9
      selectObject: formant
      step1 = startTime + 0* step
      step2 = startTime + 1* step
      step3 = startTime + 2* step
      step4 = startTime + 3* step
      step5 = startTime + 4* step
      step6 = startTime + 5* step
      step7 = startTime + 6* step
      step8 = startTime + 7* step
      step9 = startTime + 8* step
      step10 = startTime + 9* step
      f11mean = Get mean: 1, step1, step2,"hertz"
      f12mean = Get mean: 1, step2, step3,"hertz"
      f13mean = Get mean: 1, step3 , step4,"hertz"
      f14mean = Get mean: 1, step4 , step5,"hertz"
      f15mean = Get mean: 1, step5 , step6,"hertz"
      f16mean = Get mean: 1, step6 , step7,"hertz"
      f17mean = Get mean: 1, step7 , step8,"hertz"
      f18mean = Get mean: 1, step8 , step9,"hertz"
      f19mean = Get mean: 1, step9 , step10,"hertz"
      f21mean = Get mean: 2, step1, step2,"hertz"
      f22mean = Get mean: 2, step2, step3,"hertz"
      f23mean = Get mean: 2, step3 , step4,"hertz"
      f24mean = Get mean: 2, step4 , step5,"hertz"
      f25mean = Get mean: 2, step5 , step6,"hertz"
      f26mean = Get mean: 2, step6 , step7,"hertz"
      f27mean = Get mean: 2, step7 , step8,"hertz"
      f28mean = Get mean: 2, step8 , step9,"hertz"
      f29mean = Get mean: 2, step9 , step10,"hertz"
      f31mean = Get mean: 3, step1, step2,"hertz"
      f32mean = Get mean: 3, step2, step3,"hertz"
      f33mean = Get mean: 3, step3 , step4,"hertz"
      f34mean = Get mean: 3, step4 , step5,"hertz"
      f35mean = Get mean: 3, step5 , step6,"hertz"
      f36mean = Get mean: 3, step6 , step7,"hertz"
      f37mean = Get mean: 3, step7 , step8,"hertz"
      f38mean = Get mean: 3, step8 , step9,"hertz"
      f39mean = Get mean: 3, step9 , step10,"hertz"
      f41mean = Get mean: 4, step1, step2,"hertz"
      f42mean = Get mean: 4, step2, step3,"hertz"
      f43mean = Get mean: 4, step3 , step4,"hertz"
      f44mean = Get mean: 4, step4 , step5,"hertz"
      f45mean = Get mean: 4, step5 , step6,"hertz"
      f46mean = Get mean: 4, step6 , step7,"hertz"
      f47mean = Get mean: 4, step7 , step8,"hertz"
      f48mean = Get mean: 4, step8 , step9,"hertz"
      f49mean = Get mean: 4, step9 , step10,"hertz"
      # quantile at 50% = median
      f11median = Get quantile: 1, step1, step2,"hertz",0.5
      f12median = Get quantile: 1, step2, step3,"hertz",0.5
      f13median = Get quantile: 1, step3 , step4,"hertz",0.5
      f14median = Get quantile: 1, step4 , step5,"hertz",0.5
      f15median = Get quantile: 1, step5 , step6,"hertz",0.5
      f16median = Get quantile: 1, step6 , step7,"hertz",0.5
      f17median = Get quantile: 1, step7 , step8,"hertz",0.5
      f18median = Get quantile: 1, step8 , step9,"hertz",0.5
      f19median = Get quantile: 1, step9 , step10,"hertz",0.5
      f21median = Get quantile: 2, step1, step2,"hertz",0.5
      f22median = Get quantile: 2, step2, step3,"hertz",0.5
      f23median = Get quantile: 2, step3 , step4,"hertz",0.5
      f24median = Get quantile: 2, step4 , step5,"hertz",0.5
      f25median = Get quantile: 2, step5 , step6,"hertz",0.5
      f26median = Get quantile: 2, step6 , step7,"hertz",0.5
      f27median = Get quantile: 2, step7 , step8,"hertz",0.5
      f28median = Get quantile: 2, step8 , step9,"hertz",0.5
      f29median = Get quantile: 2, step9 , step10,"hertz",0.5
      f31median = Get quantile: 3, step1, step2,"hertz",0.5
      f32median = Get quantile: 3, step2, step3,"hertz",0.5
      f33median = Get quantile: 3, step3 , step4,"hertz",0.5
      f34median = Get quantile: 3, step4 , step5,"hertz",0.5
      f35median = Get quantile: 3, step5 , step6,"hertz",0.5
      f36median = Get quantile: 3, step6 , step7,"hertz",0.5
      f37median = Get quantile: 3, step7 , step8,"hertz",0.5
      f38median = Get quantile: 3, step8 , step9,"hertz",0.5
      f39median = Get quantile: 3, step9 , step10,"hertz",0.5
      f41median = Get quantile: 4, step1, step2,"hertz",0.5
      f42median = Get quantile: 4, step2, step3,"hertz",0.5
      f43median = Get quantile: 4, step3 , step4,"hertz",0.5
      f44median = Get quantile: 4, step4 , step5,"hertz",0.5
      f45median = Get quantile: 4, step5 , step6,"hertz",0.5
      f46median = Get quantile: 4, step6 , step7,"hertz",0.5
      f47median = Get quantile: 4, step7 , step8,"hertz",0.5
      f48median = Get quantile: 4, step8 , step9,"hertz",0.5
      f49median = Get quantile: 4, step9 , step10,"hertz",0.5
      # f1mid = Get value at time: 1, midpoint,"hertz"
      # f2mid = Get value at time: 2, midpoint,"hertz"
      # f3mid = Get value at time: 3, midpoint,"hertz"
      selectObject: textgrid
      if numberTiers > 1
        interval_2tier = Get interval at time: 2, midPoint
        label_2tier$ = Get label of interval: 2, interval_2tier
      endif
      if numberTiers > 1
          appendFileLine: outputPath$,
                    ..."subj,",
                    ...fileName$,",",
                    ...label_1tier$, ",",
                    ...label_2tier$, ",",
                    ...startTime, ",",
                    ...midPoint, ",",
                    ...endTime, ",",
                    ...duration,",",f15mean, ",",f25mean, ",",f35mean, ",",f45mean, ",",f15median, ",",f25median, ",",f35median, ",",f45median, ",",f11mean, ",",f12mean, ",",f13mean, ",",f14mean, ",",f15mean, ",",f16mean, ",",f17mean, ",",f18mean, ",",f19mean, ",",f21mean, ",",f22mean, ",",f23mean, ",",f24mean, ",",f25mean, ",",f26mean, ",",f27mean, ",",f28mean, ",",f29mean, ",",f31mean, ",",f32mean, ",",f33mean, ",",f34mean, ",",f35mean, ",",f36mean, ",",f37mean, ",",f38mean, ",",f39mean, ",",f41mean, ",",f42mean, ",",f43mean, ",",f44mean, ",",f45mean, ",",f46mean, ",",f47mean, ",",f48mean, ",",f49mean, ",",f11median, ",",f12median, ",",f13median, ",",f14median, ",",f15median, ",",f16median, ",",f17median, ",",f18median, ",",f19median, ",",f21median, ",",f22median, ",",f23median, ",",f24median, ",",f25median, ",",f26median, ",",f27median, ",",f28median, ",",f29median, ",",f31median, ",",f32median, ",",f33median, ",",f34median, ",",f35median, ",",f36median, ",",f37median, ",",f38median, ",",f39median, ",",f41median, ",",f42median, ",",f43median, ",",f44median, ",",f45median, ",",f46median, ",",f47median, ",",f48median, ",",f49median

      else
          appendFileLine: outputPath$,
                    ..."subj,",
                    ...fileName$,",",
                    ...label_1tier$, ",",
                    ..."notier2", ",",
                    ...startTime, ",",
                    ...midPoint, ",",
                    ...endTime,",",duration,",",f15mean, ",",f25mean, ",",f35mean, ",",f45mean, ",",f15median, ",",f25median, ",",f35median, ",",f45median, ",",f11mean, ",",f12mean, ",",f13mean, ",",f14mean, ",",f15mean, ",",f16mean, ",",f17mean, ",",f18mean, ",",f19mean, ",",f21mean, ",",f22mean, ",",f23mean, ",",f24mean, ",",f25mean, ",",f26mean, ",",f27mean, ",",f28mean, ",",f29mean, ",",f31mean, ",",f32mean, ",",f33mean, ",",f34mean, ",",f35mean, ",",f36mean, ",",f37mean, ",",f38mean, ",",f39mean, ",",f41mean, ",",f42mean, ",",f43mean, ",",f44mean, ",",f45mean, ",",f46mean, ",",f47mean, ",",f48mean, ",",f49mean, ",",f11median, ",",f12median, ",",f13median, ",",f14median, ",",f15median, ",",f16median, ",",f17median, ",",f18median, ",",f19median, ",",f21median, ",",f22median, ",",f23median, ",",f24median, ",",f25median, ",",f26median, ",",f27median, ",",f28median, ",",f29median, ",",f31median, ",",f32median, ",",f33median, ",",f34median, ",",f35median, ",",f36median, ",",f37median, ",",f38median, ",",f39median, ",",f41median, ",",f42median, ",",f43median, ",",f44median, ",",f45median, ",",f46median, ",",f47median, ",",f48median, ",",f49median
      endif
    endif
  endfor
  selectObject: sound
  plusObject: textgrid
  Edit
  endeditor
  Remove
endfor
selectObject: doF.list
Remove

appendInfoLine: newline$ + "end, enjoy phonetics."


procedure doF: .directory$, .extension$
    # specify directory path
  # createStimuliList.directory$ = "/Users/rosingle/Documents/theseEcriture/donneesThese/wanda"
  # add "/" on mac or unix and "/" on windows
  if macintosh or unix
    .directory$ = .directory$ + "/"
  elsif windows
    .directory$ = .directory$ + "\"
  endif
  .fileExtension$ = .extension$
  .list = Create Strings as file list: "listDoF", .directory$ + "/*" + .fileExtension$
  .numberFiles = Get number of strings
endproc