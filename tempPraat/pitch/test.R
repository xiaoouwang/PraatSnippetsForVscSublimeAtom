i.A1 = 12
i.x1 = 9
i.A2 = 1
i.x2 = 5
c = 35000
i.rh = (c/(2*pi)) * sqrt(i.A2/(i.x2*i.A1*i.x1))
i.r11 = c/(2*i.x1)
i.r12 = 2*c/(2*i.x1)
i.r13 = 3*c/(2*i.x1)
i.r21 = c/(2*i.x2)
i.r22 = 2*c/(2*i.x2)
i.r23 = 3*c/(2*i.x2)
print(i.rh)