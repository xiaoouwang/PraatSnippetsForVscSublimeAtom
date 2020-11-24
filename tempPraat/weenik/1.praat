f1 = 500
b1 = 50
dT = 1 / 44100
 r = exp (-pi * b1 * dT)
 c = - r^2
 b = 2 * r * cos (2 * pi * f1 * dT)
a = 1 - b - c
y = Create Sound from formula: "y" , "Mono" , 0, 0.1 , 44100 , "0"
Formula: "(if col = 1 then 1 else 0 fi) + b * self[col-1] + c * self[col-2]"

Create Sound as pure tone: "tone" , 1, 0, 0.4 , 44100 , 1000.0 , 1, 0.01 , 0.01
Create Sound as pure tone: "tone" , 1, 0, 0.4 , 44100 , 1000.0 , 0.94, 0.01 , 0.01

Create Sound from formula: "100" , "Mono" , 0, 1, 44100 , "1*sin(2*pi*100*x)"

Create Sound from formula: "s" , 1, 0, 0.5 , 44100 , "0.9*sin(2*pi*800*x)"
# fade in fade out
Create Sound as pure tone: "tone" , 1, 0, 0.5 , 44100 , 800.0 , 0.9 , 0.01 , 0.01
# damped sine
f = 800
b = 80
Create Sound from formula: "f" , 1, 0, 0.1 , 44100 , "exp(-pi*b*x)*sin(2*pi*f*x)"
# less damped sine
f = 800
b = 20
Create Sound from formula: "f" , 1, 0, 0.1 , 44100 , "exp(-pi*b*x)*sin(2*pi*f*x)"
# noise
Create Sound from formula: "g" , 1, 0, 0.5 , 44100 , "randomGauss(0 ,0.2)"
# noise 2 with
Create Sound from formula: "u" , 1, 0, 0.5 , 44100 , "randomUniform(-0.99 ,0.99)"

# Create Sound from formula: "white_noise" , "Mono" , 0, 1, 44100 , "0"
# Formula: "randomGauss(0,1)"
###! pink noise
# Create Sound from formula: "white_noise" , "Mono" , 0, 1, 44100 , "0"
# Formula: "randomGauss(0,1)"
# To Spectrum: "no"
# Formula: "if x > 100 then self*sqrt(100/x) else 0 fi"
# To Sound

Create Sound from formula: "1" , 1, 0, 0.1 , 44100 , " if col=1 then 1 else 0 fi"

Create empty PointProcess: "pp" , 0, 0.1
 Add point: 0.01234567
 To Sound (pulse train): 44100 , 1, 0.05 , 2000

# take derivative

# Down to Matrix
# Formula… (self [col + 1] - self) / dcol

# gamma tone knocking on wood
f = 500
bp = 150
gamma = 4
phase = 0
Create Sound from formula: "gammatone" , 1, 0, 1, 44100 , "x^(gamma - 1) * exp( -2 * pi * bp * x) * sin(2 * pi * f * x + phase)"
Scale peak: 0.99

# pulse
Create Sound from formula: "1" , 1, 0, 0.1 , 44100 , " if col=1 then 1 else 0 fi"
# one pulse low passed
Create empty PointProcess: "pp" , 0, 0.1
Add point: 0.01234567
To Sound (pulse train): 44100 , 1, 0.05 , 2000

# pipeline with do
Create Sound from formula: "s" , 1, 0, 0.5 , 44100 , "0.9*sin(2*pi*800*x)"
meanHalved = 0.5 * do ("Get total duration" )
appendInfoLine: meanHalved
Play
select all
Remove

Create Sound from formula: "gap" , 1, 0, 0.3 , 44100 , "if x > 0.1 and x < 0.2 then 0 else randomGauss (0 ,0.1) fi"
# the same using self
Create Sound from formula: "gap" , 1, 0, 0.3 , 44100 , "randomGauss (0,0.1)"
Formula: "if x > 0.1 and x < 0.2 then 0 else self fi"
# stereo file
Create Sound from formula: "s" , "Stereo" , 0, 2, 44100 , "1/2 * sin(2*pi*500*x) + 1/2 * sin(2*pi*505*x)"
Play
Info
Create Sound from formula: "s" , "Stereo" , 0, 2, 44100 , "if row=1 then 1/2 * sin(2*pi*500*x) else 1/2 * sin(2*pi*505*x) endif"
Create Sound from formula: "s" , "Stereo" , 0, 1, 44100 ,"1/2 * sin(2*pi*(if row=1 then 500 else 505 endif)*x)"

Create Sound from formula: "s" , "Mono" , 0, 0.5 , 44100, "0"
for col to nx
  xt = x1 + (col - 1) * dx
  self[1, col] = sin (2 * pi * 100 * xt)
endfor

Create Sound from formula: " s500" , 1, 0, 1, 44100 , " sin(2*pi*500*x)"
Create Sound from formula: " s500o" , 1, 0, 1, 44100 , " 2*sin(2*pi*500*x)"

Create Sound from formula: "white_noise" , "Mono" , 0, 1, 44100 , " 0"
Formula: "randomGauss(0 ,1)"
To Spectrum: "no"
Formula: "if x > 100 then self*sqrt(100/x) else 0 fi"
To Sound