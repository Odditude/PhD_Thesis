library(factoextra)
library(ggplot2)
library(reshape2)
library(plyr)
library(data.table)
library(dplyr)
library(viridis)
library(BBmisc)
library(caret)
library(ggfortify)
library(ggpubr) 

Ta_TMM_All_assemblies = read.table(file = "Z:/Work/NorfabShare/Transcriptomics/Carmina/ChocolateSpot_RSEM.isoform.TMM.EXPR.matrix", sep = '' )
Df_TMM_All_assemblies = as.data.frame(Ta_TMM_All_assemblies)
colnames(Df_TMM_All_assemblies)



SubsetTest1 <- Df_TMM_All_assemblies[,c(1:3)]
c <- data.frame(R0_Hedin=rowMeans(SubsetTest1))
total <- c

SubsetTest1 <- Df_TMM_All_assemblies[,c(4:6)]
c <- data.frame(R0_Lynx=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(7:9)]
c <- data.frame(R0_LH=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(10:12)]
c <- data.frame(R0_HH=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(13:15)]
c <- data.frame(R0_LL=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(16:18)]
c <- data.frame(R0_HL=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(19:21)]
c <- data.frame(R24_Hedin=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(22:24)]
c <- data.frame(R24_Lynx=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(25:27)]
c <- data.frame(R24_LH=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(28:30)]
c <- data.frame(R24_HH=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(31:33)]
c <- data.frame(R24_LL=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(34:36)]
c <- data.frame(R24_HL=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(37:39)]
c <- data.frame(R48_Hedin=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(40:42)]
c <- data.frame(R48_Lynx=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(43:45)]
c <- data.frame(R48_LH=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(46:48)]
c <- data.frame(R48_HH=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(49:51)]
c <- data.frame(R48_LL=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(52:54)]
c <- data.frame(R48_HL=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(55:57)]
c <- data.frame(R72_Hedin=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(58:60)]
c <- data.frame(R72_Lynx=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(61:63)]
c <- data.frame(R72_LH=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(64:66)]
c <- data.frame(R72_HH=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(67:69)]
c <- data.frame(R72_LL=rowMeans(SubsetTest1))
total <- cbind(total, c)

SubsetTest1 <- Df_TMM_All_assemblies[,c(70:72)]
c <- data.frame(R72_HL=rowMeans(SubsetTest1))
total <- cbind(total, c)

total$Total <- paste(total$R0_Hedin + total$R0_Lynx + total$R0_LH + total$R0_HH + total$R0_LL + total$R0_HL +
                       total$R24_Hedin + total$R24_Lynx + total$R24_LH + total$R24_HH + total$R24_LL + total$R24_HL +
                       total$R48_Hedin + total$R48_Lynx + total$R48_LH + total$R48_HH + total$R48_LL + total$R48_HL +
                       total$R72_Hedin + total$R72_Lynx + total$R72_LH + total$R72_HH + total$R72_LL + total$R72_HL)



#########
# Extra #
#########
Df_TMM_All_assemblies$Total <- paste(total$R0_Hedin + total$R0_Lynx + total$R0_LH + total$R0_HH + total$R0_LL + total$R0_HL +
                                       total$R24_Hedin + total$R24_Lynx + total$R24_LH + total$R24_HH + total$R24_LL + total$R24_HL +
                                       total$R48_Hedin + total$R48_Lynx + total$R48_LH + total$R48_HH + total$R48_LL + total$R48_HL +
                                       total$R72_Hedin + total$R72_Lynx + total$R72_LH + total$R72_HH + total$R72_LL + total$R72_HL)

#Df_TMM_All_assemblies$Total <- rowSums(Df_TMM_All_assemblies)


d1 = data.frame(lapply(Df_TMM_All_assemblies, function(x) as.numeric(as.character(x))),
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
#varName = T10
Tprint <- subset(varName, select = -c(Total))

write.table(Tprint, "Z:/Work/NorfabShare/Transcriptomics/Carmina/ChocolateSpot_T03_bowtie_hedin_NoAverage_07022020.txt", sep="\t")


Tprint <- t(Tprint)
d.pca <- prcomp(Tprint,
                center = TRUE,
                scale. = TRUE)
fviz_eig(d.pca)

faba_groups <- matrix(c("Hedin", 0, "Hedin", 0, "Hedin", 0,
                        "Lynx", 0, "Lynx", 0, "Lynx", 0,
                        "LH", 0, "LH", 0, "LH", 0,
                        "HH", 0, "HH", 0, "HH", 0,
                        "LL", 0, "LL", 0, "LL", 0,
                        "HL", 0, "HL", 0, "HL", 0,
                        "Hedin", 24, "Hedin", 24, "Hedin", 24,
                        "Lynx", 24, "Lynx", 24, "Lynx", 24,
                        "LH", 24, "LH", 24,  "LH", 24,
                        "HH", 24, "HH", 24, "HH", 24,
                        "LL", 24, "LL", 24, "LL", 24,
                        "HL", 24, "HL", 24, "HL", 24,
                        "Hedin", 48, "Hedin", 48, "Hedin", 48,
                        "Lynx", 48, "Lynx", 48, "Lynx", 48,
                        "LH", 48, "LH", 48, "LH", 48, 
                        "HH", 48, "HH", 48, "HH", 48, 
                        "LL", 48, "LL", 48, "LL", 48,
                        "HL", 48, "HL", 48, "HL", 48, 
                        "Hedin", 72, "Hedin", 72, "Hedin", 72,
                        "Lynx", 72, "Lynx", 72, "Lynx", 72, 
                        "LH", 72, "LH", 72, "LH", 72,
                        "HH", 72, "HH", 72, "HH", 72,
                        "LL", 72, "LL", 72, "LL", 72, 
                        "HL", 72, "HL", 72, "HL", 72),ncol=2,byrow=TRUE)
colnames(faba_groups) <- c("Accession", "Time")
rownames(faba_groups) <- row.names(Tprint)
df_fabaGroups <- data.frame(faba_groups)

df_d.pca <- data.frame(d.pca$x, Accession=df_fabaGroups$Accession, Time=df_fabaGroups$Time)
# Create percent variance label for axis 
percentVar <- d.pca$sdev^2 / sum( d.pca$sdev^2 )
percentVar <- round(100 * percentVar)

plot.names <- row.names(Tprint)
plot.names
pcaplot <- ggplot(df_d.pca, aes(PC1, PC2, color = Accession)) +
  coord_fixed() +
  geom_point(size=3, aes(shape=Time)) +
  #must manually apply the percentage variance in this case
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) + 
  #geom_polygon(data = hulls, alpha = 0.5) +
  stat_chull(geom = "polygon", alpha = 0.1, aes(color = Accession, fill = Accession)) +
  #stat_ellipse(geom = "polygon", alpha = 0.2, type = "t", level = 0.95) + #if you want to look at ellipses of t-distibuted data 95%. 
  #stat_conf_ellipse(geom = "polygon", alpha = 0.2, level = 0.95, bary = TRUE) + #if you want to look at ellipses of mean 95%. bary = false is the same as stat_ellipse(type = "euclid", level - 0.95).
  stat_mean(size = 5) +
  theme_bw()


pcaplot

ggsave(
  "T03_PCA_Rep_Lynx.png",
  pcaplot,
  width = 6.25,
  height = 6.25,
  dpi = 1200
)

pcaplot <- ggplot(df_d.pca, aes(PC2, PC3, color = Accession)) +
  coord_fixed() +
  geom_point(size=3, aes(shape=Time)) +
  #must manually apply the percentage variance in this case
  xlab(paste0("PC2: ",percentVar[2],"% variance")) +
  ylab(paste0("PC3: ",percentVar[3],"% variance")) + 
  #geom_polygon(data = hulls, alpha = 0.5) +
  stat_chull(geom = "polygon", alpha = 0.1, aes(color = Accession, fill = Accession)) +
  #stat_ellipse(geom = "polygon", alpha = 0.2, type = "t", level = 0.95) + #if you want to look at ellipses of t-distibuted data 95%. 
  #stat_conf_ellipse(geom = "polygon", alpha = 0.2, level = 0.95, bary = TRUE) + #if you want to look at ellipses of mean 95%. bary = false is the same as stat_ellipse(type = "euclid", level - 0.95).
  stat_mean(size = 5) +
  theme_bw()


pcaplot

ggsave(
  "T03_PC23_Rep.png",
  pcaplot,
  width = 6.25,
  height = 6.25,
  dpi = 1200
)


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

hist(log(as.numeric(d1$Total)), breaks = 60 )
hist(log(as.numeric(T01$Total)), breaks = 60 )
hist(log(as.numeric(T02$Total)), breaks = 60 )
hist(log(as.numeric(T03$Total)), breaks = 60 )
hist(log(as.numeric(T04$Total)), breaks = 60 )
hist(log(as.numeric(T05$Total)), breaks = 60 )
hist(log(as.numeric(T10$Total)), breaks = 60 )
hist(log(as.numeric(T15$Total)), breaks = 60 )
hist(log(as.numeric(T20$Total)), breaks = 60 )
hist(log(as.numeric(T25$Total)), breaks = 60 )
hist(log(as.numeric(T50$Total)), breaks = 60 )

varName = T03
Tprint <- subset(varName, select = -c(Total))


RNames <- rownames(varName)
write.table(RNames, "Z:/Work/NorfabShare/Transcriptomics/RM_RNames_T03_salmon_hedin_08022019.txt", sep=" ", row.names = F, col.names = F, quote = F)
write.table(Tprint, "Z:/Work/NorfabShare/Transcriptomics/Carmina/ChocolateSpot_T03_bowtie_hedin_23012020.txt", sep="\t")



Tprint <- t(Tprint)
d.pca <- prcomp(Tprint,
                center = TRUE,
                scale. = TRUE)
fviz_eig(d.pca)

faba_groups <- matrix(c("Hedin", 0, "Lynx", 0, "LH", 0, "HH", 0, "LL", 0, "HL", 0, "Hedin", 24, "Lynx", 24, "LH", 24, "HH", 24, 
                        "LL", 24, "HL", 24, "Hedin", 48, "Lynx", 48, "LH", 48, "HH", 48, "LL", 48, "HL", 48, "Hedin", 72, "Lynx", 
                        72, "LH", 72, "HH", 72, "LL", 72, "HL", 72),ncol=2,byrow=TRUE)
colnames(faba_groups) <- c("Accession", "Time")
rownames(faba_groups) <- row.names(Tprint)
df_fabaGroups <- data.frame(faba_groups)

df_d.pca <- data.frame(d.pca$x, Accession=df_fabaGroups$Accession, Time=df_fabaGroups$Time)
# Create percent variance label for axis 
percentVar <- d.pca$sdev^2 / sum( d.pca$sdev^2 )
percentVar <- round(100 * percentVar)

plot.names <- row.names(Tprint)
plot.names
pcaplot <- ggplot(df_d.pca, aes(PC1, PC2, color = Accession)) +
    coord_fixed() +
    geom_point(size=3, aes(shape=Time)) +
    #must manually apply the percentage variance in this case
    xlab(paste0("PC1: ",percentVar[1],"% variance")) +
    ylab(paste0("PC2: ",percentVar[2],"% variance")) + 
    #geom_polygon(data = hulls, alpha = 0.5) +
    stat_chull(geom = "polygon", alpha = 0.1, aes(color = Accession, fill = Accession)) +
    #stat_ellipse(geom = "polygon", alpha = 0.2, type = "t", level = 0.95) + #if you want to look at ellipses of t-distibuted data 95%. 
    #stat_conf_ellipse(geom = "polygon", alpha = 0.2, level = 0.95, bary = TRUE) + #if you want to look at ellipses of mean 95%. bary = false is the same as stat_ellipse(type = "euclid", level - 0.95).
    stat_mean(size = 5) +
    theme_bw()
  

pcaplot

ggsave(
  "T03_PCA_Average.png",
  pcaplot,
  width = 6.25,
  height = 6.25,
  dpi = 1200
)

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
