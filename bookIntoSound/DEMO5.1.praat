# sine wave construction animation (fig.5.1)

Erase all

label START
demo Erase all
demo Black
demo Times

demo Select inner viewport... 0 100 0 100
h = demo Horizontal wc to mm: 1
v = demo Vertical wc to mm: 1
vhRatio = v/h
h1 = 5
h2 = h1+48

dVert = 48/vhRatio
v1 = 50-dVert/2
v2 = v1+dVert

#demo Select inner viewport... 5 53 18 82
demo Select inner viewport... 'h1' 'h2' 'v1' 'v2'
#demo Draw inner box

demo Axes... -1 1 -1 1
demo Line width... 1
demo Dashed line
demo Draw circle... 0 0 1.006
demo Draw line... 0 -1.1 0 1.1
demo Draw line... -1.1 0 1.05 0
demo Draw line... 1.2 0 2.8 0

demo Text special... 1.2 centre -0.1 half Times 12 0 0
demo Text special... 2.8 centre 0.1 half Times 12 0 2\pi
demo Draw line... 1.2 0 1.2 -0.04
demo Draw line... 2.8 0 2.8 0.04
demo Text special... 1.4 centre -0.1 half Times 12 0 %\om %t
demo Solid line
demo Draw arrow... 1.47 -0.1 1.62 -0.1

nsteps = 256
for i from 0 to nsteps
   angle = 2*pi/nsteps*i
   demo Black
   demo Solid line
   call position
   demo Line width... 1
   demo Draw circle... 1.2+'i'*1.6/'nsteps' sin('angle') 0.004
   demo Line width... 1

   # Delay.
   accu = 0
   while accu < 0.015
     stopwatch
     accu = accu + stopwatch
   endwhile

   if i < nsteps
      demo White
      call position
   endif
   demo Black
   demo Dashed line
   if i = 1
      demo Draw line... 0 0 1 0
   endif
   if i = nsteps/2
      demo Draw line... -1 0 0 0
   endif
   if i > nsteps/4-1 and i < nsteps/2+1
      demo Draw line... 0 0 0 1
   endif
   if i > 3/4*nsteps-1 and i < nsteps
      demo Draw line... 0 0 0 -1
   endif
endfor

demo Text special... 0.8 centre -1.1 half Times 20 0 Again? Press space bar, else press q

while demoWaitForInput ( )
   if demoKeyPressed ( )
      if demoKey$ ( ) = " "
         goto START
      elsif demoKey$ ( ) = "q"
         demo Erase all
         exit
      endif
   endif
endwhile



procedure position
   demo Solid line
   demo Line width... 1
   demo Draw arrow... 0 0 cos('angle') sin('angle')
   demo Dotted line
   demo Draw line...  cos('angle') sin('angle') cos('angle') 0
   demo Draw line...  cos('angle') sin('angle') 0 sin('angle')
   demo Line width... 4
   demo Solid line
   demo Draw line...  0 sin('angle') 0 0
   demo Draw circle... 0 sin('angle') 0.015
   demo Line width... 1
endproc