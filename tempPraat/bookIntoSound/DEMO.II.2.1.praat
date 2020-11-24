form Taylor Power series for sine.
   comment sin x = x - x^3 / 3! + x^5 / 5! - x^7 / 7! +  ...
   integer Number_of_terms 10
   real Scale_factor_for_x 1
endform

n = number_of_terms
s = scale_factor_for_x

# Initialize sine.
Create Sound from formula... sine Mono -(n-1)/'s' (n-1)/'s' 1000 0
Erase all

Select inner viewport: 0.5, 5.5, 0.5, 2.5


fact = 1
sgn = -1
for i to n
   pwr = 2*(i-1)+1
   sgn = -sgn
   Formula... self+(('sgn')*('s'*x)^'pwr')/'fact'

   Draw... 0 0 -2 2 yes Curve
   One mark left... 1 yes yes yes
   One mark left... -1 yes yes yes
   pause

   if i < n
      Erase all
   endif

   fact = fact * 2 * i * (pwr + 2)
endfor

t = pi/s
One mark bottom... 0 yes yes yes
One mark bottom... 't:2' yes yes yes
One mark bottom... -'t:2' yes yes yes
