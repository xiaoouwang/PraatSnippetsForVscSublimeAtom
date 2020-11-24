library(tidyverse)

calHelmholtz <- function(aConstriction, vCavity, lCavity, lConstriction) {
  formantHelmholtz <- (c / (2 * pi)) * sqrt(aConstriction / (vCavity * lCavity * lConstriction))
  return(round(formantHelmholtz, 1))
}

calDemiOnde <- function(n, L) {
  formantDemi <- n * c / (2 * L)
  return(round(formantDemi, 1))
}

calWavLength <- function(freq) {
  return(round(c / 100 / freq, 1))
}


i.a1 <- 12
i.l1 <- 9
i.a2 <- 1
i.l2 <- 5
c <- 35000

i.resonances <- data.frame(matrix(ncol = 2, nrow = 0), stringsAsFactors = FALSE)

for (n in 1:3) {
  tempResonIdFirst <- paste0("r1", n)
  tempResonFirst <- calDemiOnde(n, i.l1)
  cat("the resonances of the first cavity is ->", tempResonIdFirst, tempResonFirst, "Hz\n")
  tempResonDf <- data.frame(tempResonIdFirst, tempResonFirst)
  # i.resonances[nrow(i.resonances)+1,] <- c(tempResonIdFirst,tempResonFirst)
  i.resonances <- rbind(i.resonances, tempResonDf)
}

names(i.resonances) <- c("resonance", "frequency")

for (n in 1:3) {
  tempResonIdSecond <- paste0("r2", n)
  tempResonSecond <- calDemiOnde(n, i.l2)
  cat("the resonances of the second cavity is ->", tempResonIdSecond, tempResonSecond, "Hz\n")
  tempResonDf <- data.frame(tempResonIdSecond, tempResonSecond)
  names(tempResonDf) <- c("resonance", "frequency")
  i.resonances <- rbind(i.resonances, tempResonDf)
}


i.helm <- calHelmholtz(i.a2, i.a1, i.l1, i.l2)

cat("the Helmholtz resonance is", i.helm , "Hz")

i.resonances <- rbind(i.resonances,data.frame(resonance = "rHelmholtz",frequency = i.helm))

i.resonances <- i.resonances %>% arrange(frequency) %>% mutate(formant = paste0("f",1:n())) %>% mutate(cavity = case_when(
startsWith(substring(resonance,2),"1") ~ "Back",
startsWith(substring(resonance,2),"2") ~ "Front",
startsWith(substring(resonance,2),"H") ~ "Helmholtz")) %>% mutate(affiliation = paste(formant,cavity,sep="->"))

i.resonances
# mutate(cavity = ifelse(
  # startsWith(substring(resonance,2),"1")
#  , "1", "2")
# )

i.resonances

knitr::kable(i.resonances, "rst")


save.image(file = "maeda.Rdata")





# cat("the wavelength of 130 Hz is",calWavLength(130),"meters")
# i.rh = c/(2*pi) * sqrt(i.A2/(i.x2*i.A1*i.x1))
# i.r11 = c/(2*i.x1)
# i.r12 = 2*c/(2*i.x1)
# i.r13 = 3*c/(2*i.x1)
# i.r21 = c/(2*i.x2)
# i.r22 = 2*c/(2*i.x2)
# i.r23 = 3*c/(2*i.x2)