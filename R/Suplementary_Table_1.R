setwd("C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/VC1/")
getwd()

library("htmltools")
library("webshot")
library("kableExtra")
library(formattable)

###############
# Formattable #
###############

# This is the one Marcin and Stig liked. 

Supl_table_format = read.table(file = "Suplementary_Table_1_Data.txt", sep = "\t", header = T)
Ft_Supl_table = formattable(Supl_table_format, align = c("l", rep("r", NCOL(Supl_table) - 1)))
htmlwidgets::saveWidget(as.htmlwidget(Ft_Supl_table, width = 275), "Supl_Table01.html", selfcontained = TRUE)

#########
# Kable #
#########

Supl_table_kable = read.table(file = "Suplementary_Table_1_Data_BUSCO.txt", sep = "\t", header = T)
FT = kable(Supl_table) %>%
  kable_styling("striped", full_width = F) %>%
  pack_rows("BUSCO Score", 8, 12)  %>%
  save_kable(file = "Supl_01_kable.html", self_contained = T)
FT
