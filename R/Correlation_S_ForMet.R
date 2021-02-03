setwd("Z:/Work/NorfabShare/Articles/Vicine_paper/Correlations/")
getwd()
library("data.table")
S_ForMet_cor = read.table(file = "RNA_T1_AI.txt", sep = '')
Df_S_ForMet_cor = as.data.frame(S_ForMet_cor)
#Df_S_ForMet_cor$SD <- apply(Df_S_ForMet_cor, 1, sd)
#hist(Df_S_ForMet_cor$SD)
#Df_S_ForMet_cor <- subset(Df_S_ForMet_cor, SD >= 5)
#hist(Df_S_ForMet_cor$SD)
#Df_S_ForMet_cor <- subset(Df_S_ForMet_cor, select = -c(SD))
Df_S_ForMet_cor <- as.data.frame(t(Df_S_ForMet_cor))


Ta_metabolites_d1 = read.table(file = "Positive_Negative_Met.txt", sep = '', header = TRUE)
Df_metabolites_d1 = as.data.frame(t(Ta_metabolites_d1))
colnames(Df_metabolites_d1) = as.character(unlist(Df_metabolites_d1[1, ]))
Df_metabolites_d1 = Df_metabolites_d1[-1, ]
Df_metabolites_d1[] <- lapply(Df_metabolites_d1, function(x) {
  if(is.factor(x)) as.numeric(as.character(x)) else x
})
sapply(Df_metabolites_d1, class)

Cor_T1_meta <- cor(Df_S_ForMet_cor, Df_metabolites_d1)

hist(Cor_T1_meta, breaks = 100)
write.table(Cor_T1_meta, "Z:/Work/NorfabShare/Articles/Vicine_paper/Correlations/Cor_PosNEGMet_T1AI_full", sep="\t")
