#! /Library/Frameworks/R.framework/Versions/4.2/Resources/bin/Rscript
library(data.table)
library (ggplot2)
library(tidytext)
library(tidyverse)
library(ggrepel)
library(ggpubr)

cbbPalette <- c("#999999", "#F0E442", "#E69F00", "#009E73", "#CC79A7", "#0072B2", "#D55E00", "#56B4E9", "#000000")
cbbPalette1 <- c("#E69F00", "#009E73", "#CC79A7", "#0072B2", "#D55E00", "#56B4E9", "#000000")

#### APOE region
df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Work/Projects/mQTL_pQTL/mQTL_pQTL_plot.txt")

p1 <- ggplot (data = df, aes (x = X_Cor, y = T_STAT, col = Type, label = Label)) + geom_point (size = 3, alpha = .5) + geom_text_repel(max.overlaps = Inf, show.legend  = F)

p1 <- p1 + theme_bw()
p1 <- p1 + scale_x_continuous (breaks=seq(1, 22, 1), labels=c("Chr1", "Chr2", "Chr3", "Chr4", "Chr5", "Chr6", "Chr7", "Chr8", "Chr9", "Chr10", "Chr11", "Chr12", "Chr13", "Chr14", "Chr15", "Chr16",
                                                              "Chr17", "Chr18", "Chr19", "Chr20", "Chr21", "Chr22"))
p1 <- p1 + scale_y_continuous (breaks=seq(-60, 40, 10))

p1 <- p1 + xlab ("Chromosome Position") + labs (color = "Type of QTL") + ylab ("T-Statistics")
p1 <- p1 +
  theme(legend.position="right",
        plot.title = element_text(family = "serif", size=14, face = "bold", hjust = 0.5),
        axis.title.x = element_text(family = "serif", size=12),
        axis.title.y = element_text(family = "serif", size=12),
        axis.text.x = element_text(family = "serif", size=12, angle = 30),
        axis.text.y = element_text(family = "serif", size=12),
        legend.title = element_text(family = "serif", size=12),
        legend.text = element_text(family = "serif", size=12),
        panel.background = element_blank())

p1
