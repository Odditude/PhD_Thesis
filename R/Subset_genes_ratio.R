setwd("Z:/Work/NorfabShare")
getwd()
#library("data.table", lib.loc="\\\\uni.au.dk/Users/AU338462/Documents/R/win-library/3.4")

Ta_TMM_All_assemblies = read.table(file = "All_Assemblies_AI_RSEM.Named.TMM.EXPR.matrix", sep = '' )
Df_TMM_All_assemblies = as.data.frame(Ta_TMM_All_assemblies)
colnames(Df_TMM_All_assemblies)









colnames(Df_TMM_All_assemblies)
# Test_subset1 <- Df_TMM_All_assemblies[c(1:7),]


SubsetTest1 <- Df_TMM_All_assemblies[,c(1:3)]
c <- data.frame(Flower=rowMeans(SubsetTest1))
total <- c

SubsetTest1 <- Df_TMM_All_assemblies[,c(4:6)]
c <- data.frame(Stem=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(7:9)]
c <- data.frame(Leaf_young=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(10:12)]
c <- data.frame(Leaf_mature=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(13:15)]
c <- data.frame(Pods_expansion=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(16:18)]
c <- data.frame(Seeds_expansion=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(19:21)]
c <- data.frame(Pods_filling=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(22:24)]
c <- data.frame(Seeds_filling_embryo=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(25:26)]
c <- data.frame(Mixture_of_all=rowMeans(SubsetTest1))
total <- cbind(total, c)

#total$Ratio_1 <- paste((total$Seeds_expansion)/(total$Seeds_filling_embryo))

#total$Ratio_2 <- paste((total$Seeds_expansion)/
#                         (((total$Flower) + (total$Stem) + (total$Leaf_young) + (total$Leaf_mature) 
#                           + (total$Pods_expansion) + (total$Pods_filling) + (total$Seeds_filling_embryo))/7))

total$Total <- paste(total$Flower + total$Stem + total$Leaf_young + total$Leaf_mature + total$Pods_expansion + 
                       total$Seeds_expansion + total$Pods_filling + total$Seeds_filling_embryo + total$Mixture_of_all)

#Df_TMM_All_assemblies$Total <- rowSums(Df_TMM_All_assemblies)
#Df_TMM_All_assemblies$OldTotal <- paste(rowMeans(SubsetTest1)+)

#write.table(total, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/total.txt", sep="\t")

#R1 <- subset(total, Ratio_1 > 5)
#R1 <- subset(R1, !Ratio_1 == "NaN")
#R1 <- subset(R1, Seeds_expansion > 1)
#R1 <- R1[order(R1$Ratio_1, decreasing = TRUE), ]

#write.table(R1, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/R1.txt", sep="\t")

#R2 <- subset(total, Ratio_2 > 2)
#R2 <- subset(R2, !Ratio_2 == "NaN")
#R2 <- subset(R2, Seeds_expansion > 1)
#R2 <- R2[order(R2$Ratio_2, decreasing = TRUE), ]

#write.table(R2, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/R2.txt", sep="\t")

#==========================#
# Filtered genes for 1 TMM #
#==========================#

T1 <- subset(total, Total >= 1)
T1 <- subset(T1, select = -c(Total))
RNames <- rownames(T1)
write.table(RNames, "Z:/Work/NorfabShare/Articles/Vicine_paper/Correlations/RNames_T1_Ai.txt", sep=" ", row.names = F, col.names = F, quote = F)
write.table(T1, "Z:/Work/NorfabShare/Articles/Vicine_paper/Correlations/T1_Ai.txt", sep="\t")

#==================================#
# Filtered for Metaboliste dataset #
#==================================#

#T1_noMix <- subset(total, select = -c(Mixture_of_all, Total, Ratio_1, Ratio_2))
#T1_noMix$Total <- paste(T1_noMix$Flower + T1_noMix$Stem + T1_noMix$Leaf_young + T1_noMix$Leaf_mature + T1_noMix$Pods_expansion + 
#                       T1_noMix$Seeds_expansion + T1_noMix$Pods_filling + T1_noMix$Seeds_filling_embryo)
#T1_noMix <- subset(T1_noMix, Total >= 1)
#T1_noMix <- subset(T1_noMix, select = -c(Total))
#write.table(T1_noMix, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/T1_noMix.txt", sep="\t")

mydf <- cbind(rownames(Df_TMM_All_assemblies), Df_TMM_All_assemblies)
names(mydf)[names(mydf) == "rownames(Df_TMM_All_assemblies)"] <- "NAMES"
NAMES_list = read.table(file = "Z:/Work/NorfabShare/Articles/Vicine_paper/Correlations/RNames_T1_Ai.txt", sep = '' )
mydf <- mydf %>% filter(mydf$NAMES %in% NAMES_list$V1)
mydf_row <- mydf[,-1]
rownames(mydf_row) <- mydf[,1]

correlation_samples <- c("Flower_01", "Flower_02", "Flower_03", "Stem_01", "Stem_02", "Stem_03", "Leaf_.young._1", 
                         "Leaf_.young._2", "Leaf_.young._3", "Leaf_.mature._1", "Leaf_.mature._3", "Pods_.expansion._1",
                         "Pods_.expansion._2", "Pods_.expansion._3", "Seeds_.expansion._1", "Seeds_.expansion._2",
                         "Seeds_.expansion._3", "Pods_.filling._2", "Pods_.filling._3", "Seeds_.filling.embryo._2",
                         "Seeds_.filling.embryo._3")
mydf_row <- mydf_row[correlation_samples]

SubsetExSeeds <- mydf_row[,c("Seeds_.expansion._1", "Seeds_.expansion._2", "Seeds_.expansion._3")]
c <- data.frame(ExSeeds=rowMeans(SubsetExSeeds))
mydf_row <- cbind(mydf_row, c)

correlation_samples <- c("Flower_01", "Flower_02", "Flower_03", "Stem_01", "Stem_02", "Stem_03", "Leaf_.young._1", 
                         "Leaf_.young._2", "Leaf_.young._3", "Leaf_.mature._1", "Leaf_.mature._3", "Pods_.expansion._1",
                         "Pods_.expansion._2", "Pods_.expansion._3", "ExSeeds", "Pods_.filling._2", "Pods_.filling._3",
                         "Seeds_.filling.embryo._2", "Seeds_.filling.embryo._3")
mydf_row <- mydf_row[correlation_samples]
names(mydf_row) <- c("FL2", "FL3", "FL4", "ST1", "ST2", "ST4", "YL2", "YL3", "YL4", "ML1", "ML4", "EP1", "EP2", "EP4", 
                 "ExSeeds", "FP2", "FP4", "FE2", "FE4")
write.table(mydf_row, "Z:/Work/NorfabShare/Articles/Vicine_paper/Correlations/RNA_T1_AI.txt", sep="\t")
