# Library
library(fmsb)
library(data.table)
df <- fread ("/Volumes/ATUL_6TB/Work/Projects/CSF_Metabolomics/Analyses_2/All_Combined/Radar_Plot_Data.txt")
df <- data.frame(df, row.names = 1)
create_beautiful_radarchart <- function(data, color = c("#E7B800", "#FC4E07"), 
                                        vlabels = colnames(df), vlcex = 0.7,
                                        caxislabels = NULL, title = NULL, ...){
  radarchart(
    df, axistype = 1,
    # Customize the polygon
    pcol = color, pfcol = scales::alpha(color, 0.5), plwd = 2, plty = 1,
    # Customize the grid
    cglcol = "grey", cglty = 1, cglwd = 0.8,
    # Customize the axis
    axislabcol = "grey", 
    # Variable labels
    vlcex = vlcex, vlabels = vlabels,
    caxislabels = caxislabels, title = title, ...
  )
}
create_beautiful_radarchart(df, caxislabels = c(0, 5, 10, 15, 20))

legend(
  x = "bottom", legend = rownames(df[-c(1,2),]), horiz = TRUE,
  bty = "n", pch = 20 , col = c("#E7B800", "#FC4E07"),
  text.col = "black", cex = 1, pt.cex = 1.5
)
