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
library("RColorBrewer")
library(ggrepel)


Ta_TMM_All_assemblies = read.table(file = 
                                     "C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/New_Article/salmon.isoform.TMM.EXPR.matrix", 
                                   sep = '' )
Df_TMM_All_assemblies = as.data.frame(Ta_TMM_All_assemblies)
colnames(Df_TMM_All_assemblies)



Df_TMM_All_assemblies$Total <- 
  paste(Df_TMM_All_assemblies$X159b_Flower_rep1 + Df_TMM_All_assemblies$X159b_Flower_rep2 + Df_TMM_All_assemblies$X159b_Flower_rep3 + 
          Df_TMM_All_assemblies$X159b_Leaf_rep1 + Df_TMM_All_assemblies$X159b_Leaf_rep2 + Df_TMM_All_assemblies$X159b_Leaf_rep3 + 
          Df_TMM_All_assemblies$X159b_Pods_rep1 + Df_TMM_All_assemblies$X159b_Pods_rep2 + Df_TMM_All_assemblies$X159b_Pods_rep3 + 
          Df_TMM_All_assemblies$X159b_Seeds_rep1 + Df_TMM_All_assemblies$X159b_Seeds_rep2 + Df_TMM_All_assemblies$X159b_Seeds_rep3 + 
          Df_TMM_All_assemblies$X2378_Flower_rep1 + Df_TMM_All_assemblies$X2378_Flower_rep2 + Df_TMM_All_assemblies$X2378_Flower_rep3 + 
          Df_TMM_All_assemblies$X2378_Leaf_rep1 + Df_TMM_All_assemblies$X2378_Leaf_rep2 + Df_TMM_All_assemblies$X2378_Leaf_rep3 + 
          Df_TMM_All_assemblies$X2378_Pods_rep1 + Df_TMM_All_assemblies$X2378_Pods_rep2 + Df_TMM_All_assemblies$X2378_Pods_rep3 +
          Df_TMM_All_assemblies$X2378_Seeds_rep1 + Df_TMM_All_assemblies$X2378_Seeds_rep2 + Df_TMM_All_assemblies$X2378_Seeds_rep3 +
          Df_TMM_All_assemblies$hiverna_Flower_rep1 + Df_TMM_All_assemblies$hiverna_Flower_rep2 + Df_TMM_All_assemblies$hiverna_Flower_rep3 +
          Df_TMM_All_assemblies$hiverna_Leaf_rep1 + Df_TMM_All_assemblies$hiverna_Leaf_rep2 + Df_TMM_All_assemblies$hiverna_Leaf_rep3 +
          Df_TMM_All_assemblies$hiverna_Pods_rep1 + Df_TMM_All_assemblies$hiverna_Pods_rep2 + Df_TMM_All_assemblies$hiverna_Pods_rep3 +
          Df_TMM_All_assemblies$hiverna_Seeds_rep1 + Df_TMM_All_assemblies$hiverna_Seeds_rep2 + Df_TMM_All_assemblies$hiverna_Seeds_rep3 +
          Df_TMM_All_assemblies$hedin_ExpansionPods_rep1 + Df_TMM_All_assemblies$hedin_ExpansionPods_rep2 + Df_TMM_All_assemblies$hedin_ExpansionPods_rep3 +
          Df_TMM_All_assemblies$hedin_ExpansionSeeds_rep1 + Df_TMM_All_assemblies$hedin_ExpansionSeeds_rep2 + Df_TMM_All_assemblies$hedin_ExpansionSeeds_rep3 +
          Df_TMM_All_assemblies$hedin_FillingPods_rep1 + Df_TMM_All_assemblies$hedin_FillingPods_rep2 + Df_TMM_All_assemblies$hedin_FillingPods_rep3 +
          Df_TMM_All_assemblies$hedin_FillingSeeds_rep1 + Df_TMM_All_assemblies$hedin_FillingSeeds_rep2 + Df_TMM_All_assemblies$hedin_FillingSeeds_rep3 +
          Df_TMM_All_assemblies$hedin_Flower_rep1 + Df_TMM_All_assemblies$hedin_Flower_rep2 + Df_TMM_All_assemblies$hedin_Flower_rep3 +
          Df_TMM_All_assemblies$hedin_MatureLeaf_rep1 + Df_TMM_All_assemblies$hedin_MatureLeaf_rep2 + Df_TMM_All_assemblies$hedin_MatureLeaf_rep3 +
          Df_TMM_All_assemblies$hedin_MixWhole_rep1 + Df_TMM_All_assemblies$hedin_MixWhole_rep2 +
          Df_TMM_All_assemblies$hedin_Roots_rep1 + Df_TMM_All_assemblies$hedin_Roots_rep2 + Df_TMM_All_assemblies$hedin_Roots_rep3 +
          Df_TMM_All_assemblies$hedin_Stem_rep1 + Df_TMM_All_assemblies$hedin_Stem_rep2 + Df_TMM_All_assemblies$hedin_Stem_rep3 +
          Df_TMM_All_assemblies$hedin_YoungLeaf_rep1 + Df_TMM_All_assemblies$hedin_YoungLeaf_rep2 + Df_TMM_All_assemblies$hedin_YoungLeaf_rep3)

d1 = data.frame(lapply(Df_TMM_All_assemblies, function(x) as.numeric(as.character(x))),
                check.names=F, row.names = rownames(Df_TMM_All_assemblies))
apply(d1, 2, is.numeric)

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

#FourColorsPalette <- c("#003f5c", "#7a5195", "#ef5675", "#ffa600")
# <- c("#E64B35B2", "#4DBBD5B2", "#00A087B2", "#3C5488B2")
uniqueInitials <- c("E", "X", "N", "G", "F", "L", "M", "I", "P", "R", "S", "T", "Y")
initialShapes <- unlist(lapply(uniqueInitials, utf8ToInt))



Tprint <- t(Tprint)
d.pca <- prcomp(Tprint,
                center = TRUE,
                scale. = TRUE)
fviz_eig(d.pca)

faba_groups <- matrix(c("159b", "Flower", "159b", "Flower", "159b", "Flower",
                        "159b", "Leaf", "159b", "Leaf", "159b", "Leaf",
                        "159b", "Pods", "159b", "Pods", "159b", "Pods",
                        "159b", "Seeds", "159b", "Seeds", "159b", "Seeds",
                        "2378", "Flower", "2378", "Flower", "2378", "Flower",
                        "2378", "Leaf", "2378", "Leaf", "2378", "Leaf",
                        "2378", "Pods", "2378", "Pods", "2378", "Pods",
                        "2378", "Seeds", "2378", "Seeds", "2378", "Seeds",
                        "Hiverna", "Flower", "Hiverna", "Flower", "Hiverna", "Flower",
                        "Hiverna", "Leaf", "Hiverna", "Leaf", "Hiverna", "Leaf",
                        "Hiverna", "Pods", "Hiverna", "Pods", "Hiverna", "Pods",
                        "Hiverna", "Seeds", "Hiverna", "Seeds", "Hiverna", "Seeds",
                        "Hedin", "ExpansionPods", "Hedin", "ExpansionPods", "Hedin", "ExpansionPods",
                        "Hedin", "ExpansionSeeds", "Hedin", "ExpansionSeeds", "Hedin", "ExpansionSeeds",
                        "Hedin", "FillingPods", "Hedin", "FillingPods", "Hedin", "FillingPods", 
                        "Hedin", "FillingSeeds", "Hedin", "FillingSeeds", "Hedin", "FillingSeeds", 
                        "Hedin", "Flower", "Hedin", "Flower", "Hedin", "Flower",
                        "Hedin", "MatureLeaf", "Hedin", "MatureLeaf", "Hedin", "MatureLeaf", 
                        "Hedin", "Mix", "Hedin", "Mix",
                        "Hedin", "Roots", "Hedin", "Roots", "Hedin", "Roots", 
                        "Hedin", "Stem", "Hedin", "Stem", "Hedin", "Stem",
                        "Hedin", "YoungLeaf", "Hedin", "YoungLeaf", "Hedin", "YoungLeaf"),ncol=2,byrow=TRUE)

colnames(faba_groups) <- c("Accession", "Tissue")
rownames(faba_groups) <- row.names(Tprint)
df_fabaGroups <- data.frame(faba_groups)

df_d.pca <- data.frame(d.pca$x, Accession=df_fabaGroups$Accession, Tissue=df_fabaGroups$Tissue)
# Create percent variance label for axis 
percentVar <- d.pca$sdev^2 / sum( d.pca$sdev^2 )
percentVar <- round(100 * percentVar)

plot.names <- row.names(Tprint)
plot.names
pcaplot <- ggplot(df_d.pca, aes(PC1, PC2, color = Accession)) +
  coord_fixed() +
  geom_point(size=3, aes(shape=Tissue)) +
  #must manually apply the percentage variance in this case
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) + 
  #geom_polygon(data = hulls, alpha = 0.5) +
  #stat_chull(geom = "polygon", alpha = 0.1, aes(color = Accession, fill = Accession)) +
  #stat_ellipse(geom = "polygon", alpha = 0.2, type = "t", level = 0.95) + #if you want to look at ellipses of t-distibuted data 95%. 
  #stat_conf_ellipse(geom = "polygon", alpha = 0.2, level = 0.95, bary = TRUE) + #if you want to look at ellipses of mean 95%. bary = false is the same as stat_ellipse(type = "euclid", level - 0.95).
  #stat_mean(size = 5) +
  scale_shape_manual(values=seq(0,13)) +
  scale_colour_manual(values=FourColorsPalette) +
  theme_bw()


pcaplot


####
# Log 2

Tprint <- subset(varName, select = -c(Total))

Tprint.log <- log1p(Tprint)
Tprint.log <- t(Tprint.log)
d.pca <- prcomp(Tprint.log,
                center = TRUE,
                scale. = TRUE)
fviz_eig(d.pca)

faba_groups <- matrix(c("159b", "Flower", "159b", "Flower", "159b", "Flower",
                        "159b", "Leaf", "159b", "Leaf", "159b", "Leaf",
                        "159b", "Pods", "159b", "Pods", "159b", "Pods",
                        "159b", "Seeds", "159b", "Seeds", "159b", "Seeds",
                        "2378", "Flower", "2378", "Flower", "2378", "Flower",
                        "2378", "Leaf", "2378", "Leaf", "2378", "Leaf",
                        "2378", "Pods", "2378", "Pods", "2378", "Pods",
                        "2378", "Seeds", "2378", "Seeds", "2378", "Seeds",
                        "Hiverna", "Flower", "Hiverna", "Flower", "Hiverna", "Flower",
                        "Hiverna", "Leaf", "Hiverna", "Leaf", "Hiverna", "Leaf",
                        "Hiverna", "Pods", "Hiverna", "Pods", "Hiverna", "Pods",
                        "Hiverna", "Seeds", "Hiverna", "Seeds", "Hiverna", "Seeds",
                        "Hedin", "ExpansionPods", "Hedin", "ExpansionPods", "Hedin", "ExpansionPods",
                        "Hedin", "ExpansionSeeds", "Hedin", "ExpansionSeeds", "Hedin", "ExpansionSeeds",
                        "Hedin", "FillingPods", "Hedin", "FillingPods", "Hedin", "FillingPods", 
                        "Hedin", "FillingSeeds", "Hedin", "FillingSeeds", "Hedin", "FillingSeeds", 
                        "Hedin", "Flower", "Hedin", "Flower", "Hedin", "Flower",
                        "Hedin", "MatureLeaf", "Hedin", "MatureLeaf", "Hedin", "MatureLeaf", 
                        "Hedin", "Mix", "Hedin", "Mix",
                        "Hedin", "Roots", "Hedin", "Roots", "Hedin", "Roots", 
                        "Hedin", "Stem", "Hedin", "Stem", "Hedin", "Stem",
                        "Hedin", "YoungLeaf", "Hedin", "YoungLeaf", "Hedin", "YoungLeaf"),ncol=2,byrow=TRUE)

colnames(faba_groups) <- c("Accession", "Tissue")
rownames(faba_groups) <- row.names(Tprint.log)
df_fabaGroups <- data.frame(faba_groups)

df_d.pca <- data.frame(d.pca$x, Accession=df_fabaGroups$Accession, Tissue=df_fabaGroups$Tissue)
# Create percent variance label for axis 
percentVar <- d.pca$sdev^2 / sum( d.pca$sdev^2 )
percentVar <- round(100 * percentVar)

plot.names <- row.names(Tprint)
plot.names
pcaplotLogPC12 <- ggplot(df_d.pca, aes(PC1, PC2, color = Accession)) +
  coord_fixed() +
  geom_point(size=3, aes(shape=Tissue)) +
  #must manually apply the percentage variance in this case
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) + 
  #geom_polygon(data = hulls, alpha = 0.5) +
  #stat_chull(geom = "polygon", alpha = 0.1, aes(color = Accession, fill = Accession)) +
  #stat_ellipse(geom = "polygon", alpha = 0.2, type = "t", level = 0.95) + #if you want to look at ellipses of t-distibuted data 95%. 
  #stat_conf_ellipse(geom = "polygon", alpha = 0.2, level = 0.95, bary = TRUE) + #if you want to look at ellipses of mean 95%. bary = false is the same as stat_ellipse(type = "euclid", level - 0.95).
  #stat_mean(size = 5) +
  scale_shape_manual(values = initialShapes) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.title.y=element_text(size=12),
        axis.title.x=element_text(size=12)) +
  #scale_colour_manual(values=FourColorsPalette)
  scale_color_brewer(palette="Set2")

pcaplotLogPC12

path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(pcaplotLogPC12,filename="PCA_log_PC1_PC2.png", height=6,width=8.5,units="in", path=path_of_file, dpi=300)



plot.names <- row.names(Tprint)
plot.names
pcaplotLogPC23 <- ggplot(df_d.pca, aes(PC2, PC3, color = Accession)) +
  coord_fixed() +
  geom_point(size=3, aes(shape=Tissue)) +
  #must manually apply the percentage variance in this case
  xlab(paste0("PC2: ",percentVar[2],"% variance")) +
  ylab(paste0("PC3: ",percentVar[3],"% variance")) + 
  #geom_polygon(data = hulls, alpha = 0.5) +
  #stat_chull(geom = "polygon", alpha = 0.1, aes(color = Accession, fill = Accession)) +
  #stat_ellipse(geom = "polygon", alpha = 0.2, type = "t", level = 0.95) + #if you want to look at ellipses of t-distibuted data 95%. 
  #stat_conf_ellipse(geom = "polygon", alpha = 0.2, level = 0.95, bary = TRUE) + #if you want to look at ellipses of mean 95%. bary = false is the same as stat_ellipse(type = "euclid", level - 0.95).
  #stat_mean(size = 5) +
  #scale_shape_manual(values=seq(0,13)) +
  scale_shape_manual(values = initialShapes) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.title.y=element_text(size=12),
        axis.title.x=element_text(size=12)) +
  #scale_colour_manual(values=FourColorsPalette)
  scale_color_brewer(palette="Set2")
  



pcaplotLogPC23

path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(pcaplotLogPC23,filename="PCA_log_PC2_PC3.png", height=6.5,width=8,units="in", path=path_of_file, dpi=300)
