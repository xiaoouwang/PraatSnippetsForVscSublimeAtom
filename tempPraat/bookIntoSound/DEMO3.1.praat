# Sine wave generator (fig.3.2)

f0=400

s1 = Create Sound from formula... sine Mono 0 0.6 44100 0.8*sin(2*pi*'f0'*x)
s2 = Extract part... 0 0.018 rectangular 1 no

Erase all
Select outer viewport... 0 6 0 2.5

Solid line
Draw... 0 0.02 -1 1 no Curve
Draw line... 0 -1 0 1
Draw line... 0 -1 0.02 -1
Dotted line
Draw line... 0 0 0.02 0
Draw arrow... 0.0198 0 0.0203 0

One mark left... 0 yes yes no
Text bottom... yes Time (s)
Marks bottom every... 1 0.005 yes yes no

label AGAIN

select s1
Play

# beginPause ("")
#   comment: "If you did not hear anything or you got a Windows error message,"
#   comment: "please check Windows' audio system or the playback volume level."
# clicked = endPause ("Stopppp","Again", 2,1)
# writeInfoLine: clicked

# if clicked = 2
#    goto AGAIN
# endif

select s1
plus s2
# Remove
Solid line
