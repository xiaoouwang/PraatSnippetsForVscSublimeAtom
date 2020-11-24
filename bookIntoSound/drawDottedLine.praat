# DrawDottedLine.

form DottedLine
   positive dpi 1
   real x1 0
   real y1 0
   real x2 0
   real y2 0
endform

if (x1-x2)=0 and (y1-y2)=0
  exit No line traject possible.
endif

call dottedLine dpi x1 y1 x2 y2

procedure dottedLine .dpi .x1 .y1 .x2 .y2

# Collect data from Picture info.
   .pic$ = Picture info
   .vpx1 = extractNumber(.pic$, "Inner viewport left: ")
   .vpx2 = extractNumber(.pic$, "Inner viewport right: ")
   .vpy1 = extractNumber(.pic$, "Inner viewport top: ")
   .vpy2 = extractNumber(.pic$, "Inner viewport bottom: ")
   .ax1 = extractNumber(.pic$, "Axis left: ")
   .ax2 = extractNumber(.pic$, "Axis right: ")
   .ay1 = extractNumber(.pic$, "Axis top: ")
   .ay2 = extractNumber(.pic$, "Axis bottom: ")

   # Estimate drawing area.
   .xDist = .vpx2-.vpx1
   .yDist = .vpy2-.vpy1

   # Estimate scale factors.
   .scaleX = (.ax2-.ax1)/.xDist
   .scaleY = -(.ay2-.ay1)/.yDist

   # Estimate line length.
   .length = sqrt(((.x2-.x1)/.scaleX)^2+((.y2-.y1)/.scaleY)^2)

   .steps = .dpi*.length
   .xStep = (.x2-.x1)/.steps
   .yStep = (.y2-.y1)/.steps
   if .xStep<0
      .xSign = 1
   else
      .xSign = 0
   endif
   if .yStep<0
      .ySign = 1
   else
      .ySign = 0
   endif

   .x1Dot = .x1
   .y1Dot = .y1
   for .i to .steps+1
      .x1Dot = .x1 + (.i-1)*.xStep
      .x2Dot = .x1Dot + .xStep/2
      if .xSign = 0
         if .x2Dot > .x2
            .x2Dot = .x2
         endif
      else
         if .x2Dot < .x2
            .x2Dot = .x2
         endif
      endif

      .y1Dot = .y1 + (.i-1)*.yStep
      .y2Dot = .y1Dot + .yStep/2
      if .ySign = 0
         if .y2Dot > .y2
            .y2Dot = .y2
         endif
      else
         if .y2Dot < .y2
            .y2Dot = .y2
         endif
      endif

      Draw line... '.x1Dot' '.y1Dot' '.x2Dot' '.y2Dot'
   endfor

endproc
