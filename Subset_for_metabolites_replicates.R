setwd("\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/Fernando-TQ/Roots/")
getwd()
library("data.table", lib.loc="\\\\uni.au.dk/Users/AU338462/Documents/R/win-library/3.4")
Ta_TMM_All_assemblies = read.table(file = "Roots_AI_20180809.RSEM.isoform.TMM.EXPR.matrix.txt", sep = '' )
Df_TMM_All_assemblies = as.data.frame(Ta_TMM_All_assemblies)

# Change the name of the samples
colnames(Df_TMM_All_assemblies) <- c("FL2", "FL3", "FL4", "ST1", "ST2", "ST4", "YL2", "YL3", "YL4", 
                                     "ML1", "ML2", "ML4", "EP1", "EP2", "EP4", "Seeds_expansion_1", 
                                     "Seeds_expansion_2", "Seeds_expansion_3", "FP1", "FP2", "FP4", 
                                     "FE1", "FE2", "FE4", "Mix1", "Mix2", "R1", "R2", "R3")

# Subset for Metaboltic studies - replicates


SubsetForMet <- Df_TMM_All_assemblies[,c("FL2", "FL3", "FL4", "ST1", "ST2", "ST4", "YL2", "YL3", 
                                         "YL4", "ML1", "ML4", "EP1", "EP2", "EP4")]

SubsetExpansionSeeds <- Df_TMM_All_assemblies[,c("Seeds_expansion_1", "Seeds_expansion_2", "Seeds_expansion_3")]
c <- data.frame(ExSeeds=rowMeans(SubsetExpansionSeeds))
SubsetForMet <- cbind(SubsetForMet, c)

c <- Df_TMM_All_assemblies[,c("FP2", "FP4", "FE2", "FE4", "R1", "R2", "R3")]
SubsetForMet <- cbind(SubsetForMet, c)



SubsetForMet$Total <- paste(SubsetForMet$FL2 + SubsetForMet$FL3 + SubsetForMet$FL4 + SubsetForMet$ST1
                            + SubsetForMet$ST2 + SubsetForMet$ST4 + SubsetForMet$YL2 + SubsetForMet$YL3
                            + SubsetForMet$YL4 + SubsetForMet$ML1 + SubsetForMet$ML4 + SubsetForMet$EP1
                            + SubsetForMet$EP2 + SubsetForMet$EP4 + SubsetForMet$ExSeeds + SubsetForMet$FP2
                            + SubsetForMet$FP4 + SubsetForMet$FE2 + SubsetForMet$FE4 + SubsetForMet$R1 
                            + SubsetForMet$R2 + SubsetForMet$R3)

#write.table(total, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/total.txt", sep="\t")


#==========================#
# Filtered genes for 1 TMM #
#==========================#

#S_ForMet_TMM1 <- subset(SubsetForMet, Total >= 1)
#RNames <- rownames(T1)
#write.table(RNames, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/RNames.txt", sep=" ", row.names = F, col.names = F, quote = F)
#write.table(T1, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/T1.txt", sep="\t")

#==================================#
# Filtered for Metaboliste dataset #
#==================================#

S_ForMet_noTotal <- subset(SubsetForMet, Total >= 1)
S_ForMet_noTotal <- subset(S_ForMet_noTotal, select = -c(Total))
write.table(S_ForMet_noTotal, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/Fernando-TQ/Roots/Roots_S_ForMet", sep="\t")

