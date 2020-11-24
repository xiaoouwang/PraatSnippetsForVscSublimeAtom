options(vsc.dev.args = list(width = 800, height = 600))
library(tidyverse)
pitchCncn <- read.csv("pitchLogCncn.txt")
pitchFrfr <- read.csv("pitchLogFrfr.txt")
pitchCnfr <- read.csv("pitchLogCnfr.txt")
pitchAll <- rbind(pitchCncn, pitchCnfr, pitchFrfr)

range(pitchAll$min)
range(pitchAll$mean)
pitchAll %>% filter(max==401)
diffPitchMeasure <- data.frame(pitchAll$mean - pitchAll$median)
diffPitchMeasure <- diffPitchMeasure %>% rename(pitchdf = 1)
range(diffPitchMeasure$pitchdf)
ggplot(pitchAll, aes(x = mean, y = median)) +
  geom_point() +
  geom_smooth() +
  labs(title = "Main title", x = "X axis label", y = "Y axis label") +
  theme(plot.title = element_text(hjust = 0.5))
library(ggpubr)
ggscatter(pitchAll,
  x = "mean", y = "median",
  add = "reg.line",
  conf.int = TRUE,
  add.params = list(
    color = "blue",
    fill = "lightgray"
  ),
  title = "pitch mean vs median",
  xlab = "mean (Hz)", ylab = "median (Hz)"
) +
  stat_cor(method = "pearson", label.x = 3, label.y = 30) +
  theme(plot.title = element_text(hjust = 0.5)) # Add correlation coefficient
pitchAll %>%
  filter(phoneme != "global") %>%
  ggboxplot(., x = "phoneme", y = "mean")

ggboxplot(pitchAll, "group", "mean", color = "phoneme")

pitchAllMeans <- aggregate(mean ~  group, pitchAll, mean)

pitchAllMeans <- pitchAllMeans %>% mutate(mean = round(mean,2))

ggboxplot(pitchAll, x = "group", y = "mean", fill = "group") +  stat_summary(fun.y=mean, geom="point", shape=20, size=30, color="white", fill="white") +
geom_text(data = pitchAllMeans, aes(label = paste(mean,"Hz"), y = mean + 0.08))


# ggboxplot(pitchAll, x = "group", y = "mean", group = "group") + facet_grid(group ~ phoneme)

# ggtitle("mean vs median of pitch")
# diffPitchMeasure  %>% ggplot(aes(x = "", y = x))+ geom_boxplot()
# ggplot(data, aes(x = phoneme, y = )) +
#   geom_segment(aes(x = x, xend = x, y = 0, yend = y), color = "skyblue") +
#   geom_point(color = "blue", size = 4, alpha = 0.6) +
#   theme_light() +
#   coord_flip() +
#   theme(
#     panel.grid.major.y = element_blank(),
#     panel.border = element_blank(),
#     axis.ticks.y = element_blank()
#   )