# DEMO26.1.

Create Sound from formula: "fade", 1, 0, 0.5, 44100, "1"
Multiply by window: "Gaussian3"
Extract part: 0, 0.25, "rectangular", 1, "no"
Rename: "fade_in"
Create Sound from formula: "mid", 1, 0, 1, 44100, "1"
selectObject: "Sound fade"
Extract part: 0.25, 0.5, "rectangular", 1, "no"
Rename: "fade_out"
plus Sound fade_in
plus Sound mid
Concatenate
Rename... envelope

# Init. Sound result.
Create Sound from formula: "result", 1, 0, 16, 1, "0"

# Setup demo screen.
demo Erase all
demo Axes: 0, 100, 0, 100
demo 24
demo Text: 50, "centre", 95, "half", "Frequency selectivity check"
demo 14
demo Text: 50, "centre", 80, "half", "You will hear 48 sounds consisting of two short tones each."
demo Text: 50, "centre", 75, "half", "One of the two tones has some vibration, the other is steady."
demo Text: 50, "centre", 70, "half", "After each tone pair you should select which of the two
... tones had some vibration"
demo Text: 50, "centre", 65, "half", "by selecting FIRST, SECOND or DON'T KNOW."
demo Text: 50, "centre", 55, "half", "Choose the frequency of the tones:"
demo Text: 50, "centre", 25, "half", "(Make sure that playing of sound in Windows is functioning
... and the volume is comfortable.)"
demo Paint rounded rectangle: "Lime", 24, 40, 10, 20, 5
demo Text: 32, "centre", 15, "half", "Continue"
demo Paint rounded rectangle: "Lime", 60, 76, 10, 20, 5
demo Text: 68, "centre", 15, "half", "Exit"

f1$ = "200Hz"
f2$ = "500Hz"
f3$ = "1000Hz"
f4$ = "2000Hz"
choice = 3
call set choice

label SET
while demoWaitForInput( )
  if demoClicked( )
    if demoClickedIn (31, 39, 35, 45)
      choice = 1
      call set 1
      goto SET
    elsif demoClickedIn (41, 49, 35, 45)
      choice = 2
      call set 2
      goto SET
    elsif demoClickedIn (51, 59, 35, 45)
      choice = 3
      call set 3
      goto SET
    elsif demoClickedIn (61, 69, 35, 45)
      choice = 4
      call set 4
      goto SET
    elsif demoClickedIn (24, 40, 10, 20)
      goto START
    elsif demoClickedIn (60, 76, 10, 20)
      demo Erase all
      exit
    else
      goto SET
    endif
  endif
endwhile

label START
# Generate steady part of stimulus.
if choice = 1
  f = 200
elsif choice = 2
  f = 500
elsif choice = 4
  f = 2000
else
  f = 1000
endif
Create Sound from formula: "steady", 1, 0, 1.5, 44100, "1/2 * sin(2*pi*f*x)"
Formula... self * Sound_envelope[]

# Setup different mod. depths percentages, exponentially distributed.
for i to 16
  if f = 200
    p'i' = 10^((i+14)/10)/250.5
  else
    p'i' = 10^((i+7)/10)/250.5
  endif
endfor

# Triplicate indices in array.
for i to 16
  c2 = i+16
  c3 = i+32
  index'i' = i
  index'c2' = i
  index'c3' = i
endfor

# Randomize index array.
for i to 48
  buf_index = index'i'
  i_random = randomInteger(i,48)
  index'i' = index'i_random'
  index'i_random' = buf_index
endfor

# Setup demo screen.
demo Erase all
demo 24
demo Text: 50, "centre", 95, "half", "Frequency selectivity check"
demo 14
demo Text: 50, "centre", 69, "half", "Which part is not steady?"
demo Paint rounded rectangle: "{0.2,0.9,0.9}", 32, 48, 50, 60, 3
demo Text: 40, "centre", 55, "half", "First"
demo Paint rounded rectangle: "{0.2,0.9,0.9}", 52, 68, 50, 60, 3
demo Text: 60, "centre", 55, "half", "Second"
demo Paint rounded rectangle: "{0.2,0.9,0.9}", 42, 58, 35, 45, 3
demo Text: 50, "centre", 40, "half", "Don't know"
demo Paint rounded rectangle: "{0.6,0.9,0.9}", 26, 38, 10, 20, 2
demo Text: 32, "centre", 15, "half", "Play again"
demo Paint rounded rectangle: "{0.93,0.15,0.15}", 62, 74, 10, 20, 2
demo Text: 68, "centre", 15, "half", "Exit"

for i to 48
  rank = index'i'
  m = p'rank'/100*f
  Create Sound from formula: "tone", 1, 0, 1.5, 44100, "0.5*sin(2*pi*f*x+m/2/pi*sin(2*pi*5*x))"
  Formula... self * Sound_envelope()
  demo Paint rectangle: "white", 40, 60, 75, 85

  # Set two sound parts in random sequence.
  seq = randomInteger(1,2)
  if seq = 1
    select Sound steady
    Rename... temp
    Copy... steady
    select Sound temp
    Remove
    select Sound tone
  endif
  plus Sound steady
  Concatenate

  demo 24
  demo Paint rectangle: "white", 48, 52, 78, 82
  demo Text: 50, "centre", 80, "half", "'i'"
  demo 14

  asynchronous Play
  label ASK
  while demoWaitForInput( )
    if demoClicked( )
      if demoClickedIn (32, 48, 50, 60)
        resp'i' = 1
        goto NEXT
      elsif demoClickedIn (52, 68, 50, 60)
        resp'i' = 2
        goto NEXT
      elsif demoClickedIn (42, 58, 35, 45)
        resp'i' = 0
        goto NEXT
      elsif demoClickedIn (26, 38, 10, 20)
        asynchronous Play
      elsif demoClickedIn (62, 74, 10, 20)
        demo Erase all
        exit
      else
        goto ASK
      endif
    endif
  endwhile

  label NEXT
  select Sound result
  if resp'i' = seq
    Formula... if col = 'rank' then self+1 else self fi
  endif

  # Erase sound(s).
  select Sound tone
  plus Sound chain
  Remove
endfor

demo Erase all
demo 24
demo Text: 50, "centre", 95, "half", "Frequency selectivity result"
demo 14
demo Text: 50, "centre", 80, "half", "Center frequency is 'f' Hertz"
demo Select inner viewport: 25, 80, 25, 65
select Sound result
demo Line width: 3
demo Green
demo Draw: 0, 0, 0, 3, "no", "Curve"
demo Black
demo Line width: 1
demo Draw inner box
demo Marks left every: 1, 1, "yes", "yes", "yes"
for s to 16
  v = Get value at sample number: 0, s
  demo Paint circle: "black", s-0.5, v, 0.1
  if f != 200
    dev = 10*p's'
  else
    dev = p's'
  endif
  if dev >= 1
    dev = round(10*dev)/10
  endif
  demo One mark bottom: s-0.5, "no", "yes", "yes", ""
  demo Text special: s-0.5, "centre", -0.2, "half", "Times", 12, "0", "'dev:2'"
endfor
if f != 200
  demo Text special: 8, "centre", -0.5, "half", "Times", 14, "0", "+/- frequency shifts  x 0.1 \% "
else
  demo Text special: 8, "centre", -0.5, "half", "Times", 14, "0", "+/- frequency shifts  x 1 \% "
endif
demo Text special: -1, "centre", 1.5, "half", "Times", 14, "90", "Number of correct responses"


procedure set choice
  # Erase rectangles.
  demo Paint rectangle: "white", 30, 80, 34, 46

  for i to 4
    x1 = i*10-4+25
    x2 = x1+8
    demo Paint rounded rectangle: "{0.8,0.8,0.95}", x1, x2, 35, 45, 3
    if i = choice
      demo Line width: 3
      demo Draw rounded rectangle: x1, x2, 35, 45, 3
      demo Line width: 1
    endif
    demo Text: x1+4, "centre", 40, "half", f'i'$
  endfor
endproc
