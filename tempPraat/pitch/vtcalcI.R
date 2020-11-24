library(tidyverse)

calHelmholtz <- function(aConstriction, vCavity, lCavity, lConstriction) {
  formantHelmholtz <- (c / (2 * pi)) * sqrt(aConstriction / (vCavity * lCavity * lConstriction))
  return(round(formantHelmholtz, 1))
}

calDemiOnde <- function(n, L) {
  formantDemi <- n * c / (2 * L)
  return(round(formantDemi, 1))
}

calQuartOnde <- function(n, L) {
  formantQuart <- (2*(n-1)+1) * c / (4 * L)
  return(round(formantQuart, 1))
}

calWavLength <- function(freq) {
  return(round(c / 100 / freq, 1))
}

formantsTable <- function(a1, l1, a2, l2, speed, resonNumbers) {
  resonances <- data.frame(matrix(ncol = 2, nrow = 0), stringsAsFactors = FALSE)
  for (n in 1:resonNumbers) {
    tempResonIdFirst <- paste0("r1", n)
    tempResonFirst <- calDemiOnde(n, l1)
    tempResonDf <- data.frame(tempResonIdFirst, tempResonFirst)
    resonances <- rbind(resonances, tempResonDf)
  }
  names(resonances) <- c("resonance", "frequency")
  for (n in 1:resonNumbers) {
    tempResonIdSecond <- paste0("r2", n)
    tempResonSecond <- calDemiOnde(n, l2)
    tempResonDf <- data.frame(tempResonIdSecond, tempResonSecond)
    names(tempResonDf) <- c("resonance", "frequency")
    resonances <- rbind(resonances, tempResonDf)
  }


  helm <- calHelmholtz(a2, a1, l1, l2)

  resonances <- rbind(resonances, data.frame(resonance = "rHelmholtz", frequency = helm))

  resonances <- resonances %>%
    arrange(frequency) %>%
    mutate(formant = paste0("f", 1:n())) %>%
    mutate(cavity = case_when(
      startsWith(substring(resonance, 2), "1") ~ "Back",
      startsWith(substring(resonance, 2), "2") ~ "Front",
      startsWith(substring(resonance, 2), "H") ~ "Helmholtz"
    )) %>%
    mutate(affiliation = paste(formant, cavity, sep = "->"))
  return(resonances)
}

i.a1 <- 12
i.l1 <- 9
i.a2 <- 1
i.l2 <- 5
c <- 35000
resonPerCavity <- 3

i.resonances <- formantsTable(i.a1, i.l1, i.a2, i.l2, c, resonPerCavity)
names(i.resonances)[2] <- "frequency (Hz)"
knitr::kable(i.resonances, "rst")