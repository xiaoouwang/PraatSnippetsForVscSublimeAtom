form Taylor Power series for cosine.
   comment cos x = 1 - x^2 / 2! + x^4 / 4! - x^6 / 6! +  ...
   integer Number_of_terms 10
   real Scale_factor_for_x 1
endform


n = number_of_terms
s = scale_factor_for_x

# Initialize cosine.
Create Sound from formula... cosine Mono -(n-1)/'s' (n-1)/'s' 1000 0
Erase all
Select inner viewport: 0.5, 5.5, 0.5, 2.5

fact = 1
sgn = -1
for i to n
   pwr = 2*(i-1)
   sgn = -sgn
   Formula... self+(('sgn')*('s'*x)^'pwr')/'fact'

   Draw... 0 0 -2 2 yes Curve
   One mark left... 1 yes yes yes 
   One mark left... -1 yes yes yes 
   pause

   if i < n
      Erase all
   endif

   fact = fact * 2 * i * (pwr+1)
endfor

t = pi/s
One mark bottom... 0 yes yes yes 
One mark bottom... 't:2' yes yes yes 
One mark bottom... -'t:2' yes yes yes 
