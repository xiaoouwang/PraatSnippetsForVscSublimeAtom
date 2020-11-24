# Convolution demo pulses / damped sine.

Erase all

lead = Create Sound from formula... null 1 0 0.0075 60000 0
period = 0.012
Create Sound from formula... train 1 0 0.08 60000 if ((col mod 720)=(1 or 2)) then 1 else 0 fi
plus lead
Concatenate
Rename... source
Copy... mult


Create Sound from formula... dsine 1 0 0.04 60000 exp(-100*pi*x)*sin(2*pi*400*x)
Set value at sample number... 0 1 0

Reverse
Shift times by... -0.035

shift = 0.03
dshift = 0.00015
nsteps = 0.005/dshift

demo Axes... 0 100 0 100
demo Text special... 50 centre 98 half Times 14 0 Convolution mechanism (1)

demo Axes... 0 0.035 -1 1
demo Select inner viewport... 5 70 62 87
demo One mark left... 0 yes yes no
demo One mark left... -1 yes yes no 
demo One mark left... 1 yes yes no 

demo Text special... 0.038 left 0.11 half Times 12 0 Reversed damped sine is shifted
demo Text special... 0.038 left -0.11 half Times 12 0 through very short pulses.

demo Select inner viewport... 5 70 32 57
demo One mark left... 0 yes yes no
demo One mark left... -1 yes yes no 
demo One mark left... 1 yes yes no 
demo One mark right... -1 no yes no  -0.001
demo One mark right... 1 no yes no  0.001

demo Text special... 0.038 left 0.22 half Times 12 0 In each shift position the functions
demo Text special... 0.038 left 0 half Times 12 0 are multiplied (the mean is
demo Text special... 0.038 left -0.22 half Times 12 0 amplified for clearness).

demo Select inner viewport... 5 70 2 27
demo Dashed line
demo Draw line... 0 0 0.035 0
demo Solid line
demo One mark left... 0 yes yes no
demo Draw line... 0 -1 0 1
demo One mark left... -1 no yes no -0.001
demo One mark left... 1 no yes no 0.001
demo Text special... 0.038 left 0.22 half Times 12 0 The mean values of the multiplied
demo Text special... 0.038 left 0 half Times 12 0 functions form the convolution
demo Text special... 0.038 left -0.22 half Times 12 0 (amplified for clearness).


# Draw leading zeroes in result.
for step to nsteps
   t = step*dshift
   demo Draw circle... 't' 0 0.0001
endfor

nsteps = shift/dshift
for step to nsteps
   select Sound dsine
   Shift times by... 'dshift'
   t = 0.005+step*dshift
   select Sound mult
   Formula... Sound_source()*Sound_dsine()

   call drawStep
   call drawConv
   call delay

   if step < nsteps
      demo White
      call drawStep
      demo Paint rectangle... White 0.0351 0.037 -0.8 0.8
      demo Black
   endif

endfor


procedure drawStep
   select Sound source
   demo Select inner viewport... 5 70 62 87
   demo Draw... 0 0.035 -1 1 no Curve
   demo Draw line... 0 -1 0 1
   demo Dashed line
   demo Draw line... 0 0 0.035 0
   demo Solid line
   select Sound dsine
   demo Draw... 0 0.035 -1 1 no Curve
   select Sound mult
   demo Select inner viewport... 5 70 32 57
   demo Draw... 0 0.035 -1 1 no Curve
   demo Draw line... 0 -1 0 1
   demo Draw line... 0.035 -1 0.035 1
   demo Dashed line
   demo Draw line... 0 0 0.035 0
   demo Solid line

   mean = Get mean... 0 0 0.035
   v = mean*1000
   demo Dashed line
   demo Draw line... 0 'v' 0.035 'v'
   demo Text... 0.0351 Left 'v' Half mean
   demo Draw line... 0 0 0.035 0
   demo Solid line

endproc


procedure delay
   accu = 0
   while accu < 0.04
     stopwatch
     accu = accu + stopwatch
   endwhile
endproc


procedure drawConv
   demo Axes... 0 0.035 -1 1
   demo Select inner viewport... 5 70 2 27
   demo Draw circle... 't' 'v' 0.0001

endproc
