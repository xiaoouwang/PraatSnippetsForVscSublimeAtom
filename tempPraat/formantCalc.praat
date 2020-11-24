form formantCalc
  real tractLength 17.5
endform

c= 35000
f1 = 1*c/(4*tractLength)
f2 = 3*c/(4*tractLength)
f3 = 5*c/(4*tractLength)

writeInfoLine: "F1 = ", f1
appendInfoLine: "F2 = ", f2
appendInfoLine: "F3 =", f3

appendInfoLine: "Done !"
appendInfoLine: "Copyright: Xiaoou WANG"
