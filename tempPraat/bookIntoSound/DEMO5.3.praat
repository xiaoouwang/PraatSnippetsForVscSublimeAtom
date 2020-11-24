# Demo sin/cos ratio.

Erase all
         
demo 18
demo Select inner viewport... 20 80 70 90
demo Draw inner box
demo Text top... no sine
demo Select inner viewport... 20 80 40 60
demo Draw inner box
demo Text top... no cosine
demo Select inner viewport... 20 80 10 30
demo Draw inner box
demo Text bottom... yes Press key or click mouse to step forward

# Phase step = d.
# Requirement: a1.sin(phi)+a2.cos(phi)=sin(phi+d)
# sin(phi+d)=sin(phi)cos(d)+cos(phi)sin(d), so
# a1.sin(phi)+a2.cos(phi)=sin(phi)cos(d)+cos(phi)sin(d)
# So: a1=cos(d) and a2=sin(d)

steps = 24
for i from 0 to steps
   angle = i/steps*2*pi
   # Avoid many digits in drawing.
   a1= round(100*cos(angle))/100
   a2=round(100*sin(angle))/100
   Create Sound from formula... sin Mono 0 0.02 44100 'a1'*sin(2*pi*200*x)
   Create Sound from formula... cos Mono 0 0.02 44100 'a2'*cos(2*pi*200*x)
   Copy... sincos
   Formula... self+Sound_sin[]

   demo Select inner viewport... 20 80 70 90
   select Sound sin
   demo Draw... 0 0.01 -1 1 no Curve
   demo One mark left... 'a1' yes yes yes
   demo One mark left... 0 yes yes yes

   select Sound cos
   demo Select inner viewport... 20 80 40 60
   demo Draw... 0 0.01 -1 1 no Curve
   demo One mark left... 'a2' yes yes yes
   demo One mark left... 0 yes yes yes

   select Sound sincos
   demo Select inner viewport... 20 80 10 30
   demo Draw... 0 0.01 -1 1 no Curve
   demo One mark left... 0 yes yes yes
   denom = steps/2
   demo Text top... no sum: phase shifted 'i'/'denom' pi radians

   demoWaitForInput()
   for u to 14
      demo Undo
   endfor

   select Sound sin
   plus Sound cos
   plus Sound sincos
   Remove
endfor

demo Erase all
