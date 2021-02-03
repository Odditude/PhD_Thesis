setwd("\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/Fernando-TQ")
getwd()
library("data.table", lib.loc="\\\\uni.au.dk/Users/AU338462/Documents/R/win-library/3.4")
Ta_T1_for_cor = read.table(file = "T1_noMix_for_cor.txt", sep = '' )
Df_T1_for_cor = as.data.frame(Ta_T1_for_cor)
Df_T1_for_cor$SD <- apply(Df_T1_for_cor, 1, sd)
hist(Df_T1_for_cor$SD)
Df_T1_for_cor <- subset(Df_T1_for_cor, SD >= 5)
hist(Df_T1_for_cor$SD)
Df_T1_for_cor <- subset(Df_T1_for_cor, select = -c(SD))
Df_T1_for_cor <- as.data.frame(t(Df_T1_for_cor))


Ta_metabolites_d1 = read.table(file = "Fernndo_metabolites_draft_1_means_zero_vicine.txt", sep = '', header = TRUE)
Df_metabolites_d1 = as.data.frame(t(Ta_metabolites_d1), header = TRUE)
colnames(Df_metabolites_d1) = Df_metabolites_d1[1, ]
Df_metabolites_d1 = Df_metabolites_d1[-1, ]

Cor_T1_meta <- cor(Df_T1_for_cor, Df_metabolites_d1)
#fwrite(as.data.frame(Cor_T1_meta), "Cor_T1_meta.csv", sep = "\t", row.names = TRUE)

hist(Cor_T1_meta, breaks = 100)
write.table(Cor_T1_meta, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/Fernando-TQ/Cor_total_meta_zero_vicine.txt", sep="\t")

#####

#Ta_metabolites_d1 = read.table(file = "Fernndo_metabolites_draft_1_means_zero_vicine.txt", sep = '', header = TRUE)
#Df_metabolites_d1 = as.data.frame(t(Ta_metabolites_d1), header = TRUE)
#colnames(Df_metabolites_d1) = Df_metabolites_d1[1, ]
#Df_metabolites_d1 = Df_metabolites_d1[-1, ]
