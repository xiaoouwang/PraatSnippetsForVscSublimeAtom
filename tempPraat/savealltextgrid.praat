# directoryName$=chooseDirectory$ ("choose")
directoryName$="/Users/rosingle/Desktop/RFP/xiaoxiao/xiaoxiao1/"
if directoryName$ <> ""
select all
n= numberOfSelected("TextGrid")
for i to n
textGrid'i'=selected("TextGrid",i)
endfor
for i to n
select textGrid'i'
name$=directoryName$+"/"+selected$("TextGrid")+".TextGrid"
Save as text file... 'name$'
endfor
select all 
#Removeyxyoetoe1
