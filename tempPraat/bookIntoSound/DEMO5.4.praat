# Addition of sine and cosine with different amplitudes and angles.

label START

Erase all
Black
Line width... 1
Times
Select outer viewport... 0 6 0 5.5
Draw inner box
Axes... -1.1 1.1 -1.1 1.1
r1 = 1
r2 = 0.45
phi = pi/5

# Draw sine vector.
Green
Dashed line
Draw line... 0 -1.1 0 1
Draw line... -1.1 0 1 0
One mark left... 0 no yes no 0
One mark bottom... 0 no yes no 0
Draw circle... 0 0 'r1'
Draw line... -1.1 'r1' 0 'r1'
One mark left... 'r1' no yes no %A1
Solid line
Draw arrow... 0 0 'r1'*cos('phi') 'r1'*sin('phi')
Dotted line
Draw line...  'r1'*cos('phi') 'r1'*sin('phi') 'r1'*cos('phi') 0
Draw line...  'r1'*cos('phi') 'r1'*sin('phi') 0 'r1'*sin('phi')
Line width... 4
Solid line
Draw arrow...  0 0 0 'r1'*sin('phi')
Line width... 1

Dashed line
Draw line... -1.1 'r1'*sin('phi') 0 'r1'*sin('phi')
One mark left... sin('phi') no yes no %A1.sin(%\fi)

# Place angle variable.
hor = 0.5*'r2'*cos('phi')
vert = 0.25*'r2'*sin('phi')
Text special... 'hor' centre 'vert' half Times 10 0 %\fi

beginPause ("")
   comment ("The radius = A1")
   comment ("The BOLD GREEN arrow is A1 x sin(phi)...")
clicked = endPause ("Stop", "Next", 2, 1)

if clicked = 1
   exit
endif

# Draw cosine vector.
Red
Line width... 1
Dashed line
Draw circle... 0 0 'r2'
Draw line... -1.1 'r2' 0 'r2'
One mark left... 'r2' no yes no %A2
Solid line
Draw arrow... 0 0 'r2'*cos('phi') 'r2'*sin('phi')
Dotted line
Draw line...  'r2'*cos('phi') 'r2'*sin('phi') 'r2'*cos('phi') 0
Draw line...  'r2'*cos('phi') 'r2'*sin('phi') 0 'r2'*sin('phi')
Line width... 4
Solid line
Draw arrow...  0 0 'r2'*cos('phi') 0
Line width... 1
Dashed line
Draw line... 'r2'*cos('phi') -1.1 'r2'*cos('phi') 0
One mark bottom... 'r2'*cos('phi') no yes no %A2.cos(%\fi)

beginPause ("")
   comment ("The radius = A2")
   comment ("the BOLD RED arrow is A2 x cos(phi)...")
clicked = endPause ("Stop", "Next", 2, 1)

if clicked = 1
   exit
endif

Black
Dotted line
Draw line...  'r2'*cos('phi') 'r1'*sin('phi') 'r2'*cos('phi') 0
Solid line
Line width... 4
Draw arrow... 0 0 'r2'*cos('phi') 'r1'*sin('phi')
Line width... 1
Black

# Place angle variable.
hor = 0.5*'r2'*cos('phi')
vert = 0.75*'r2'*sin('phi')
Text special... 'hor' centre 'vert' half Times 10 0 %\de

beginPause ("")
   comment ("The radius = sqrt(A1^2 + A2^2)")
   comment ("BOLD BLACK is their sum which has a different angle
   ... and length: sqrt(A1^2 + A2^2)sin(phi+delta).")
clicked = endPause ("Stop", "Again", 2, 1)

if clicked = 2
   goto START
endif
