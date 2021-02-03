setwd("Z:/Work/NorfabShare/Transcriptomics")
getwd()
#library("data.table", lib.loc="\\\\uni.au.dk/Users/AU338462/Documents/R/win-library/3.4")

Ta_TMM_All_assemblies = read.table(file = "RM_salmon_hedin_08022019.isoform.TMM.EXPR.matrix", sep = '' )
Df_TMM_All_assemblies = as.data.frame(Ta_TMM_All_assemblies)
colnames(Df_TMM_All_assemblies)



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

SubsetTest1 <- Df_TMM_All_assemblies[,c(27:29)]
c <- data.frame(Roots=rowMeans(SubsetTest1))
total <- cbind(total, c)


total$Total <- paste(total$Flower + total$Stem + total$Leaf_young + total$Leaf_mature + total$Pods_expansion + 
                       total$Seeds_expansion + total$Pods_filling + total$Seeds_filling_embryo + total$Mixture_of_all +
                       total$Roots)


#==========================#
# Filtered genes for 1 TMM #
#==========================#
#df2 <- mutate_all(total, function(x) as.numeric(as.character(x)))
d1 = data.frame(lapply(total, function(x) as.numeric(as.character(x))),
                check.names=F, row.names = rownames(total))


T01 <- subset(d1, Total >= 1)
T02 <- subset(d1, Total >= 2)
T03 <- subset(d1, Total >= 3)
T04 <- subset(d1, Total >= 4)
T05 <- subset(d1, Total >= 5)
T10 <- subset(d1, Total >= 10)
T15 <- subset(d1, Total >= 15)
T20 <- subset(d1, Total >= 20)
T25 <- subset(d1, Total >= 25)
T50 <- subset(d1, Total >= 50)

varName = T03

Tprint <- subset(varName, select = -c(Total))
RNames <- rownames(varName)
write.table(RNames, "Z:/Work/NorfabShare/Transcriptomics/RM_RNames_T03_salmon_hedin_08022019.txt", sep=" ", row.names = F, col.names = F, quote = F)
write.table(Tprint, "Z:/Work/NorfabShare/Transcriptomics/RM_T03_salmon_hedin_08022019.txt", sep="\t")

hist(log(as.numeric(T03$Total)), breaks = 60 )


###################
# Only for Python #
###################

Tprint <- subset(T02, select = c(Total))
write.table(Tprint, "Z:/Work/NorfabShare/Transcriptomics/T02_Total_salmon_hedin_08022019.txt", sep="\t")

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
