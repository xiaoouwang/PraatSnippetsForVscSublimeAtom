options(vsc.dev.args = list(width = 800, height = 600))
library(tidyverse)
library(ggpubr)
bw <- read.csv("bandwidthLogBackA.csv")
view(bw)
# range(bw$realb2)
# plot measured b1 by 3 variables
# limit pitch and timepoint
# by limit
ggboxplot(bw, x = factor(timepoint), y = "measured_b1") + geom_hline(aes(yintercept = 60), colour = "#990000") +
  geom_point(aes(fill = code), size = 5, shape = 21, position = position_jitterdodge()) +
  theme(
    text = element_text(size = 18),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.x = element_blank(),
    legend.position = "none"
  )



p <- ggplot(bw, aes(x = factor(timepoint), y = measured_b1, fill = pitch)) +
  # geom_boxplot(alpha = 0.80) +
  geom_point(aes(fill = pitch), size = 5, shape = 21, position = position_jitterdodge()) +
  theme(
    text = element_text(size = 18),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.x = element_blank(),
    legend.position = "none"
  )

p <- ggplot(bw, aes(x = factor(timepoint), y = measured_b2, fill = pitch)) +
  # geom_boxplot(alpha = 0.80) +
  geom_point(aes(fill = pitch), size = 5, shape = 21, position = position_jitterdodge()) +
  theme(
    text = element_text(size = 18),
    # axis.title.x = element_blank(),
    # axis.title.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.x = element_blank()
  ) + ggtitle("Largeurs de bande mesurées de F2 en variant F0\n et fréquence maximale de formants") + xlab("timepoint") + ylab("largeur de bande (Hz)") + labs(fill = "Fréquence fondamentale (Hz)")
p + geom_hline(aes(yintercept = 80), colour = "#990000") + facet_grid(limit ~ .)
ggsave("bandwid.png")


p2 <- ggplot(bw, aes(x = factor(timepoint), y = measured_b2, fill = pitch)) +
  # geom_boxplot(alpha = 0.80) +
  geom_point(aes(fill = pitch), size = 5, shape = 21, position = position_jitterdodge()) +
  theme(
    text = element_text(size = 18),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.x = element_blank(),
    legend.position = "none"
  )

p2 + geom_hline(aes(yintercept = 80), colour = "#990000")

a = ggplot(bw, aes(x = measured_b1))

a + geom_density(color = "black", fill = "gray") + geom_vline(aes(xintercept=60,color="#FC4E07", linetype="dashed", size=1))

a + geom_density(aes(color = pitch))

a

p
ggboxplot(bw, x = "timepoint", y = "measured_b2")
ggboxplot(bw, x = "limit", y = "measured_b1")
ggboxplot(bw, x = "limit", y = "measured_b1")
ggboxplot(bw, x = "limit", y = "measured_b2", facet.by = "pitch")