select all
n= numberOfSelected("TextGrid")
for i to n
textGrid'i'=selected("TextGrid",i)
endfor
select textGrid1
for i to n
plus textGrid'i'
endfor
Remove tier... 2
Remove tier... 2
Remove tier... 2
select all
n= numberOfSelected("TextGrid")
for i to n
textGrid'i'=selected("TextGrid",i)
endfor
for i from 31 to 45
select textGrid'i'
Replace interval text... 1 0 0 9 2 Literals
endfor
for i from 85 to 100
select textGrid'i'
Replace interval text... 1 0 0 2 9 Literals
endfor
n=53
repeat
select textGrid'n'
n=n+2
Replace interval text... 1 0 0 O o Literals
until n=79
m=54
repeat
select textGrid'm'
m=m+2
Replace interval text... 1 0 0 o O Literals
until m=84