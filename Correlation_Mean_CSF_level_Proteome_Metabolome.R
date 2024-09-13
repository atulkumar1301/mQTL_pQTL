library(data.table)
library(ggplot2)
library(ggrepel)
library(ggpubr)
library (Hmisc)
library(corrplot)
df <- fread ("/Volumes/ATUL_6TB/Work/Projects/mQTL_pQTL/Proetin_Vs_Metabolite_Dynamics.txt")
p <- ggscatter(df, x = "mean_standardized_protein_level", y = "mean_standardized_metabolomic_level", color = "red",
                       size = 2, alpha = 0.6, ggtheme = theme_bw(), add = "reg.line", conf.int = TRUE, 
               cor.method = "spearman", add.params = list(color = "black", fill = "lightgray")) +
  stat_cor(method = "spearman", r.accuracy = 0.1)
p <- p + labs(title=expression("Correlation between Mean CSF level of Proteome and Metabolome"), 
                              x=expression("Mean Standardized Proteome Level"), y=expression("Mean Standardized Metabolome Level"))
p <- p + scale_x_continuous(breaks = round(seq(-1, 3, by = 0.5),1))
p <- p + scale_y_continuous(breaks = round (seq (-1, 5, by = 0.5), 1))
p <- p +
  theme(plot.title = element_text(family = "serif", size=18, face = "bold"),
        axis.title.x = element_text(family = "serif", size=16),
        axis.title.y = element_text(family = "serif", size=16),
        axis.text.x = element_text(family = "serif", size=12),
        axis.text.y = element_text(family = "serif", size=12),
        panel.background = element_blank())

p
