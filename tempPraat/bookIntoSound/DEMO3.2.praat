# Chord generator (fig.3.3)

f0=200

f1=2*f0
f2=4*f0
f3=5*f0

s1 = Create Sound from formula: "name", 1, 0, 1, 44100, "1/3*sin(2*pi*'f1'*x)+1/3*sin(2*pi*'f2'*x)+1/3*sin(2*pi*'f3'*x)"
s2 = Extract part... 0 0.018 rectangular 1 no

Erase all
Select outer viewport... 0 6 0 2.5

Solid line
Draw... 0 0.02 -1 1 no Curve
Draw line... 0 -1 0 1
Draw line... 0 -1 0.02 -1
Dotted line
Draw line... 0 0 0.02 0

One mark left... 0 yes yes no
Text bottom... yes Time (s)
Marks bottom every... 1 0.005 yes yes no

label AGAIN
select s1
Play

beginPause ("")
clicked = endPause ("Stop", "Again", 2, 1)
if clicked = 2
   goto AGAIN
endif

select s1
plus s2
Remove
Solid line
