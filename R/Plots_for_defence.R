### For plot
#install.packages("cowplot")
library(ggplot2)
library(cowplot)
setwd("Z:/Work/NorfabShare/Defence")

#=======#
# VICE2 #
#=======#
VICE2 = read.table(file = "VICE2-vicine.txt", sep = '\t', header = TRUE)
VICE2_DF <- as.data.frame(VICE2)
positions=c("Flower","Stem","Leaf Young","Leaf Mature","Pods Expansion","Pods Filling","Seeds Expansion","Seeds Filling")
Pl_VICE2 <- ggplot(VICE2_DF, aes(x=Tissue, y=TMM)) + 
  geom_bar(color="black", fill="#00A087B2", alpha=0.9, stat = "identity", lwd = 0.75) + labs(y = "Expression in TMM") + 
  scale_x_discrete(limits = positions) + ggtitle("Expression of VICE1") + 
  theme(plot.title = element_text(hjust = 0.5, size = 24)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 15, face = "bold")) +
  theme(title = element_text(size = 18)) + 
  theme(axis.text.y  = element_text(size = 14)) +
  geom_errorbar( aes(x=Tissue, ymin=TMM-sd, ymax=TMM+sd), width=0.4, color="black", alpha=0.9, size=0.75)
Pl_VICE2
ggsave("Pl_VICE1_article.pdf", plot = Pl_VICE2, width = 25, height = 20, unit = "cm")                                                    


#========#
# Vicine #
#========#
Vicine = read.table(file = "Vicine-VICE2.txt", sep = '\t', header = TRUE)
Vicine_DF <- as.data.frame(Vicine)
positions=c("Flower","Stem","Leaf Young","Leaf Mature","Pods Expansion","Pods Filling","Seeds Expansion","Seeds Filling")
Pl_Vicine <- ggplot(Vicine_DF, aes(x=Tissue, y=TMM)) + 
  geom_bar(color="black", fill="#4DBBD5B2", stat = "identity", lwd = 0.75) + 
  labs(y = "Quantitative mass spectrometry") + 
  scale_x_discrete(limits = positions) + ggtitle("Levels of Vicine & Convicine") + 
  theme(plot.title = element_text(hjust = 0.5, size = 24)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 15, face = "bold")) +
  theme(title = element_text(size = 18)) + 
  theme(axis.text.y  = element_text(size = 14)) +
  geom_errorbar( aes(x=Tissue, ymin=TMM-sd, ymax=TMM+sd), width=0.4, color="black", alpha=0.9, size=0.75)
Pl_Vicine
ggsave("Pl_Vicine_article.pdf", plot = Pl_Vicine, width = 25, height = 20, unit = "cm")    


#=====================#
# VICE2 in Core/Testa #
#=====================#
# Other file is: VICE2CoreTesta.txt
VICE2CoreTesta = read.table(file = "evgLocus_1250615CoreTesta.txt", sep = '\t', header = TRUE)
VICE2CoreTesta_DF <- as.data.frame(VICE2CoreTesta)
positions=c("Core & Low","Core & Low","Core & Low","Core & Low","Core & Low","Core & Low*","Core & High","Core & High",
            "Core & High","Core & High","Core & High","Core & High*","Testa & Low","Testa & Low","Testa & Low",
            "Testa & Low","Testa & Low*","Testa & High","Testa & High","Testa & High","Testa & High*")
LevelOfVicine <- ifelse(VICE2CoreTesta_DF$Catogory == 0, "#00b9f2", "#f15a22")
Pl_VICE2CoreTesta <- ggplot(VICE2CoreTesta_DF, aes(x=Tissue, y=TMM)) + 
  geom_bar(color="black", fill="#32bcad", alpha=0.4, stat = "identity", lwd = 0.75) + 
  labs(y = "Expression in TMM") + 
  scale_x_discrete(labels = positions) + ggtitle("VICE1 in Core & Testa of high & low v/cv accessions") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 18)) +
  theme(axis.text.x = element_text(angle = 90, vjust=0.2, size = 15, face = "bold", colour = LevelOfVicine)) +
  theme(title = element_text(size = 16))
Pl_VICE2CoreTesta
ggsave("evgLocus_1250615_CorTes_article.pdf", plot = Pl_VICE2CoreTesta, width = 25, height = 20, unit = "cm")    


#=============#
# VICE2_Roots #
#=============#
VICE2_Roots = read.table(file = "VICE2Roots.txt", sep = '\t', header = TRUE)
VICE2_Roots_DF <- as.data.frame(VICE2_Roots)
positions=c("Flower","Stem","Leaf Young","Leaf Mature","Pods Expansion","Pods Filling","Seeds Expansion",
            "Seeds Filling","Roots", "Mixture")
Pl_VICE2_Roots <- ggplot(VICE2_Roots_DF, aes(x=Tissue, y=TMM)) + 
  geom_bar(color="black", fill="#32bcad", alpha=0.4, stat = "identity", lwd = 0.75) + labs(y = "Expression in TMM") + 
  scale_x_discrete(limits = positions) + theme_bw() + ggtitle("Expression of VICE2") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 18)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 15, face = "bold")) +
  theme(title = element_text(size = 16)) +
  geom_errorbar( aes(x=Tissue, ymin=TMM-sd, ymax=TMM+sd), width=0.4, color="black", alpha=0.9, size=0.75)
Pl_VICE2_Roots
ggsave("Pl_VICE2_Roots.pdf", plot = Pl_VICE2_Roots, width = 25, height = 20, unit = "cm")   

#=============#
# VICE1_Roots #
#=============#
VICE1_Roots = read.table(file = "VICE1Roots.txt", sep = '\t', header = TRUE)
VICE1_Roots_DF <- as.data.frame(VICE1_Roots)
positions=c("Flower","Stem","Leaf Young","Leaf Mature","Pods Expansion","Pods Filling","Seeds Expansion",
            "Seeds Filling","Roots", "Mixture")
Pl_VICE1_Roots <- ggplot(VICE1_Roots_DF, aes(x=Tissue, y=TMM)) + 
  geom_bar(color="black", fill="#f122e0", alpha=0.4, stat = "identity", lwd = 0.75) + labs(y = "Expression in TMM") + 
  scale_x_discrete(limits = positions) + theme_bw() + ggtitle("Expression of VICE1") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 18)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 15, face = "bold")) +
  theme(title = element_text(size = 16)) +
  geom_errorbar( aes(x=Tissue, ymin=TMM-sd, ymax=TMM+sd), width=0.4, color="black", alpha=0.9, size=0.75)
Pl_VICE1_Roots
ggsave("Pl_VICE1_Roots.pdf", plot = Pl_VICE1_Roots, width = 25, height = 20, unit = "cm")   

#=================#
# Vicine in roots #
#=================#
Vicine = read.table(file = "VicineRoots.txt", sep = '\t', header = TRUE)
Vicine_DF <- as.data.frame(Vicine)
positions=c("Flower","Stem","Leaf Young","Leaf Mature","Pods Expansion","Pods Filling","Seeds Expansion","Seeds Filling", "Roots")
Pl_Vicine <- ggplot(Vicine_DF, aes(x=Tissue, y=TMM)) + 
  geom_bar(color="black", fill="#ff9000", alpha=0.4, stat = "identity", lwd = 0.75) + 
  labs(y = "Quantitative mass spectrometry") + 
  scale_x_discrete(limits = positions) + theme_bw() + ggtitle("Production of Vicine & Convicine") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 18)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 15, face = "bold")) +
  theme(title = element_text(size = 16)) +
  geom_errorbar( aes(x=Tissue, ymin=TMM-sd, ymax=TMM+sd), width=0.4, color="black", alpha=0.9, size=0.75)
Pl_Vicine
ggsave("Pl_Vicine_Roots.pdf", plot = Pl_Vicine, width = 25, height = 20, unit = "cm")    

#=====================#
# Vicine in Seas coat #
#=====================#
VicineF = read.table(file = "VicineFilling.txt", sep = '\t', header = TRUE)
VicineF_DF <- as.data.frame(VicineF)
positions=c("Seeds Expansion", "Roots", "Seed Coat(filling)")
Pl_VicineF <- ggplot(VicineF_DF, aes(x=Tissue, y=TMM)) + 
  geom_bar(color="black", fill="#ff9000", alpha=0.4, stat = "identity", width=0.4, lwd = 0.75) + 
  labs(y = "Quantitative mass spectrometry") + 
  scale_x_discrete(limits = positions) + theme_bw() + ggtitle("Production of Vicine & Convicine") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 18)) +
  theme(axis.text.x = element_text(size = 15, face = "bold")) +
  theme(title = element_text(size = 16)) +
  geom_errorbar( aes(x=Tissue, ymin=TMM-sd, ymax=TMM+sd), width=0.2, color="black", alpha=0.9, size=0.75)
Pl_VicineF
ggsave("Pl_VicineF.pdf", plot = Pl_VicineF, width = 25, height = 20, unit = "cm")    
