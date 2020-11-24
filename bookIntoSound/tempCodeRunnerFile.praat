f0 = 150
pcols = 45000/f0

Create Sound from formula... pulse Mono 0 0.5 45000 0
Formula... if col mod 'pcols' >0 and col mod 'pcols' <3 then 1 else 0 fi
To Spectrum (dft)