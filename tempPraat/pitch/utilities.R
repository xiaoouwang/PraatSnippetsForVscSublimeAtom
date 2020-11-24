#! sessions

save.image(file = "maeda.Rdata")

# ! save
save.image(file = "my_work_space.RData")
saveRDS(i.resonances, file = "maeda.rds")
my_data <- readRDS("maeda.rds")
save(i.resonances, file = "maeda.RData")
load("maeda.Rdata")

# ! dataframe

i.resonances[nrow(i.resonances) + 1, ] <- c(tempResonIdFirst, tempResonFirst)

mutate(cavity = ifelse(
  startsWith(substring(resonance, 2), "1"),
  "1", "2"
))