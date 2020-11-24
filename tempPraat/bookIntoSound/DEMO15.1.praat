# Demo15.1. Noise types.

Erase all
Create Sound from formula... base 1 0 3.2 44100 randomGauss(0,0.2)
Extract part... 0.1 3.1 rectangular 1 no
Rename... White
select Sound base
To Spectrum (dft)

calF = 3000

Copy... p
#Formula... if x>50 then (sqrt('calF'))*self/sqrt(x) else self*sqrt('calF'/50) fi
Formula... if x>50 then sqrt(50)*self/sqrt(x) else self fi
To Sound
Extract part... 0.1 3.1 rectangular 1 no
Rename... Pink
rms = Get root-mean-square... 0 0
Multiply... 0.2/'rms'
select Spectrum p
plus Sound p
Remove

select Spectrum base
Copy... br
#Formula... if x>50 then 'calF'*self/x else self*'calF'/50 fi
Formula... if x>50 then 50*self/x else self fi
To Sound
Extract part... 0.1 3.1 rectangular 1 no
Rename... Brownian
rms = Get root-mean-square... 0 0
Multiply... 0.2/'rms'
select Spectrum br
plus Sound br
Remove

select Spectrum base
Copy... bl
#Formula... self*sqrt(x)/sqrt('calF')
Formula... self*sqrt(x)
To Sound
Extract part... 0.1 3.1 rectangular 1 no
Rename... Blue
#Scale peak... 0.99
rms = Get root-mean-square... 0 0
Multiply... 0.2/'rms'
select Spectrum bl
plus Sound bl
Remove

select Spectrum base
Copy... pur
#Formula... self/'calF'*x
Formula... self*x
To Sound
Extract part... 0.1 3.1 rectangular 1 no
Rename... Purper
rms = Get root-mean-square... 0 0
Multiply... 0.2/'rms'
#Scale peak... 0.99
select Spectrum pur
plus Sound pur
Remove

select Spectrum base
Copy... gr
# Make ear compensation filter.
Create Sound from formula: "filter", 1, 0, 22050, 1, "1"
t1 = 1.30516738e-5
t2 = t1
t3 = 7.7263443e-3
t4 = t3
t5 = 1.47841175e-3
t6 = 0.21569737e-3

# 'Low pass' sections (2).
tc = t1
call lowpass

# 'High pass' sections.
for i from 3 to 6
    tc= t'i'
    call highpass
endfor

# Invert filter.
Copy... invFilter
Formula... if x>20 then 1/self else 1 fi

select Spectrum gr
Formula... if x>40 or x<20000 then self*Sound_invFilter() else 1 fi
To Sound

Extract part... 0.1 3.1 rectangular 1 no
Rename... Grey
rms = Get root-mean-square... 0 0
Multiply... 0.2/'rms'

n = 1
label START

beginPause ("Various types of artificially generated noise.")
   choice ("Noise color", n)
   option ("White")
   option ("Pink")
   option ("Brownian")
   option ("Blue")
   option ("Purper")
   option ("Grey")
clicked = endPause ("Stop", "Continue", 2, 1)

if clicked = 2
   select Sound 'noise_color$'
   Play
   goto START
endif


procedure lowpass
    Formula... self/(1+'tc'^2*(2*pi*x)^2)
endproc

procedure highpass
    Formula... self*'tc'*2*pi*x/sqrt(1+'tc'^2*(2*pi*x)^2)
endproc




   

