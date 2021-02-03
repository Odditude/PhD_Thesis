library(ggplot2)
library(viridis)
library(hrbrthemes)
library(forcats)
library(ggrepel)
library(dplyr)
library(tidyverse)
library(PtProcess)
library(gtable)
library(grid)
library(gridExtra)
library('unikn')
library(UpSetR)
library(ggpubr)

positionOrders <- rev(c("1. Trinity ExpansionPod", 
                        "2a. DRAP ExpansionPod", "3a. Evigene Hedin", "4a. AllAccessions", 
                        "2b. DRAP ExpansionPod", "3b. Evigene Hedin", "4b. AllAccessions",
                        "2c. DRAP ExpansionPod", "3c. Evigene Hedin", "4c. AllAccessions"))
data = as.data.frame(read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/BUSCO_developtment_reformat_v2.txt", header = TRUE, sep="\t"))


p1 <- ggplot(data, mapping =aes(fill=Condition, y=Value, x=Assembly)) + 
  geom_bar(position= position_fill(reverse = TRUE), stat="identity", alpha=.8, width=.4) +
  scale_fill_viridis(discrete = T) +
  coord_flip() +
  theme(axis.text.y = element_blank(), 
        axis.ticks.y = element_blank(), 
        axis.title.y = element_blank()) +
  scale_x_discrete(limits = positionOrders)
  
data <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/Genes_Per_transcript_v2.txt", header=TRUE, sep="\t")
aframe = as.data.frame(data)
avector <- aframe[['Genes']]
theme_set(theme_bw())

# Draw plot
p2 <- ggplot(data, aes(x=Assembly, y=Genes)) +
  geom_point(size=3) + 
  geom_segment(aes(x=Assembly, 
                   xend=Assembly, 
                   y=0, 
                   yend=Genes)) + 
  #labs(title="Amount of Genes in Each Assembly") + 
  theme() + 
  geom_label_repel(aes(label = avector), box.padding   = 0.35, 
                   point.padding = 0.5, color = 'black', size = 3.5)+
  coord_flip() +
  scale_x_discrete(limits = positionOrders)


p1
gt1 <- ggplotGrob(p1)
gt2 <- ggplotGrob(p2)

newWidth = unit.pmax(gt1$widths[2:3], gt2$widths[2:3])

gt1$widths[2:3] = as.list(newWidth)
gt2$widths[2:3] = as.list(newWidth)

PlotLog <- grid.arrange(gt2, gt1, ncol=2)
PlotLog

path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/"
ggsave(PlotLog,filename="2Grid_BUSCO_lollipop.png", height=4.5,width=7.5,units="in", path=path_of_file, dpi=300)





data <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/BWA_Filtered_M09-Mode05.txt", header=TRUE)


data <- data.frame(mapply(`*`,data,100))

data <- data %>% 
  gather(key="text", value="value") %>%
  mutate(text = gsub("\\.", " ",text)) %>%
  mutate(value = round(as.numeric(value),0))



p <- data %>%
  mutate(text = fct_reorder(text, value)) %>% # Reorder data
  ggplot( aes(x=text, y=value, fill=text, color=text)) +
  geom_violin(width=1, size=0.2) +
  scale_fill_viridis(discrete=TRUE) +
  scale_color_viridis(discrete=TRUE) +
  theme_ipsum() +
  theme(
    legend.position="none"
  ) +
  coord_flip() + # This switch X and Y axis and allows to get the horizontal version
  xlab("") +
  ylab("Remapping (%) - 65 libraries")

p <- p + theme(axis.title.x = element_text(size = 15))   
p <- p + theme(axis.text.x = element_text(size=14),
               axis.text.y = element_text(face="bold", size=14))  
p 



#########################################

data <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/BWA_Mode01-Mode05-ModeSf.txt", header=TRUE, sep="\t")


data <- data.frame(mapply(`*`,data,100))

data <- data %>% 
  gather(key="text", value="value") %>%
  mutate(text = gsub("\\.", " ",text)) %>%
  mutate(value = round(as.numeric(value),0))



p <- data %>%
  mutate(text = fct_reorder(text, value)) %>% # Reorder data
  ggplot( aes(x=text, y=value, fill=text, color=text)) +
  geom_violin(width=1, size=0.2) +
  scale_fill_viridis(discrete=TRUE) +
  scale_color_viridis(discrete=TRUE) +
  theme_ipsum() +
  theme(
    legend.position="none"
  ) +
  coord_flip() + # This switch X and Y axis and allows to get the horizontal version
  xlab("") +
  ylab("Remapping (%) - 65 libraries")

p <- p + theme(axis.title.x = element_text(size = 15))   
p <- p + theme(axis.text.x = element_text(size=14),
               axis.text.y = element_text(face="bold", size=14))  
p 





positionOrders <- rev(c("1. Trinity ExpansionPod", 
                        "2a. DRAP ExpansionPod", "3a. Evigene Hedin", "4a. AllAccessions", 
                        "2b. DRAP ExpansionPod", "3b. Evigene Hedin", "4b. AllAccessions",
                        "2c. DRAP ExpansionPod", "3c. Evigene Hedin", "4c. AllAccessions"))
data = as.data.frame(read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/BUSCO_developtment_reformat_v2.txt", header = TRUE, sep="\t"))


p1 <- ggplot(data, mapping =aes(fill=Condition, y=Value, x=Assembly)) + 
  geom_bar(position= position_fill(reverse = TRUE), stat="identity", alpha=.8, width=.4) +
  scale_fill_manual(values = c("Complete single-copy" = "#35B779",
                               "Duplicated" = "#31688E",
                               "Fragmented" = "#FDE725",
                               "Missing" = "#440154")) +
  coord_flip() +
  theme(axis.text.y = element_blank(), 
        axis.ticks.y = element_blank(), 
        axis.title.y = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  scale_x_discrete(limits = positionOrders)

data <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/Genes_Per_transcript_v2.txt", header=TRUE, sep="\t")
aframe = as.data.frame(data)
avector <- aframe[['Genes']]
theme_set(theme_bw())

# Draw plot
p2 <- ggplot(data, aes(x=Assembly, y=Genes)) +
  geom_point(size=3) + 
  geom_segment(aes(x=Assembly, 
                   xend=Assembly, 
                   y=0, 
                   yend=Genes)) + 
  #labs(title="Amount of Genes in Each Assembly") + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) + 
  geom_label_repel(aes(label = avector), box.padding   = 0.35, 
                   point.padding = 0.5, color = 'black', size = 3.5)+
  coord_flip() +
  scale_x_discrete(limits = positionOrders)


gt1 <- ggplotGrob(p1)
gt2 <- ggplotGrob(p2)

newWidth = unit.pmax(gt1$widths[2:3], gt2$widths[2:3])

gt1$widths[2:3] = as.list(newWidth)
gt2$widths[2:3] = as.list(newWidth)

PlotLog <- grid.arrange(gt2, gt1, ncol=2)
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/"
ggsave(PlotLog,filename="2Grid_BUSCO_lollipop_v3.png", height=4.5,width=7.5,units="in", path=path_of_file, dpi=300)


data <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/BWA_Mode01-Mode05-ModeSf.txt", header=TRUE, sep="\t")


data <- data.frame(mapply(`*`,data,100))

data <- data %>% 
  gather(key="text", value="value") %>%
  mutate(text = gsub("\\.", " ",text)) %>%
  mutate(value = round(as.numeric(value),0))



p <- data %>%
  mutate(text = fct_reorder(text, value)) %>% # Reorder data
  ggplot( aes(x=text, y=value, fill=text, color=text)) +
  geom_violin(width=1, size=0.2) +
  scale_fill_viridis(discrete=TRUE) +
  scale_color_viridis(discrete=TRUE) +
  theme_ipsum() +
  theme(
    legend.position="none"
  ) +
  coord_flip() + # This switch X and Y axis and allows to get the horizontal version
  xlab("") +
  ylab("Remapping (%) - 65 libraries") +
  scale_x_discrete(limits = positionOrders)

p <- p + theme(axis.title.x = element_text(size = 15))   
p <- p + theme(axis.text.x = element_text(size=14),
               axis.text.y = element_text(face="bold", size=14))  
p 

path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/"
ggsave(p,filename="BWA_mapping_Mode01-05-SF_v3.png", height=4.5,width=7.5,units="in", path=path_of_file, dpi=300)



###################################


# Dataset
input <- c(
  "159b" = 52,
  "2378" = 53,
  Hedin = 198,
  Hiverna = 54,
  "159b&2378&Hedin&Hiverna" = 14486,
  "159b&2378" = 387,
  "2378&Hedin" = 531,
  "2378&Hedin&Hiverna" = 791,
  "Hedin&Hiverna" = 648,
  "159b&2378&Hiverna" = 584,
  "159b&Hedin&Hiverna" = 537,
  "159b&2378&Hedin" = 440,
  "159b&Hiverna" = 376,
  "159b&Hedin" = 404,
  "2378&Hiverna" = 506
)

# Plot
upset(fromExpression(input), 
      nintersects = 15, 
      nsets = , 
      order.by = "freq", 
      decreasing = T, 
      mb.ratio = c(0.6, 0.4),
      number.angles = 0, 
      #text.scale = 1.1, 
      point.size = 2.8, 
      line.size = 1,
      mainbar.y.label = "Orthogroup Intersections", 
      sets.x.label = "Orthogroups Per Accession", 
      text.scale = c(1.5, 1.3, 1.2, 1.2, 1.5, 1.3),
      queries = list(list(query = elements, params = list("159b", 
                                                          "2378", "Hiverna", "Hedin"), color = "#4f7ec9", active = T))
)
#8ea0bd #3975d4

input_with_unassigned <- c(
  "159b" = 52+1136,
  "2378" = 53+1148,
  Hedin = 198+2395,
  Hiverna = 54+1467,
  "159b&2378&Hedin&Hiverna" = 14486,
  "159b&2378" = 387,
  "2378&Hedin" = 531,
  "2378&Hedin&Hiverna" = 791,
  "Hedin&Hiverna" = 648,
  "159b&2378&Hiverna" = 584,
  "159b&Hedin&Hiverna" = 537,
  "159b&2378&Hedin" = 440,
  "159b&Hiverna" = 376,
  "159b&Hedin" = 404,
  "2378&Hiverna" = 506
)

# Plot
upset(fromExpression(input_with_unassigned), 
      nintersects = 15, 
      nsets = , 
      order.by = "freq", 
      decreasing = T, 
      mb.ratio = c(0.6, 0.4),
      number.angles = 0, 
      #text.scale = 1.1, 
      point.size = 2.8, 
      line.size = 1,
      mainbar.y.label = "Genre Intersections", 
      sets.x.label = "Movies Per Genre", 
      text.scale = c(1.5, 1.3, 1, 1, 1.5, 1.3)
)



################
# Nice graph 1 #
################

positionOrders <- rev(c("1. Trinity ExpansionPod", 
                        "2a. DRAP ExpansionPod", "3a. Evigene Hedin", "4a. AllAccessions", 
                        "2b. DRAP ExpansionPod", "3b. Evigene Hedin", "4b. AllAccessions",
                        "2c. DRAP ExpansionPod", "3c. Evigene Hedin", "4c. AllAccessions"))
data = as.data.frame(read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/BUSCO_developtment_reformat_v2.txt", header = TRUE, sep="\t"))


p1 <- ggplot(data, mapping =aes(fill=Condition, y=Value, x=Assembly)) + 
  geom_bar(position= position_fill(reverse = TRUE), stat="identity", alpha=.8, width=.4) +
  ylab("BUSCO Score") +
  scale_fill_manual(values = c("Complete single-copy" = "#35B779",
                               "Duplicated" = "#31688E",
                               "Fragmented" = "#FDE725",
                               "Missing" = "#440154")) +
  coord_flip() +
  theme(axis.text.y = element_blank(), 
        axis.ticks.y = element_blank(), 
        axis.title.y = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  scale_x_discrete(limits = positionOrders)

data <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/Genes_Per_transcript_v2.txt", header=TRUE, sep="\t")
aframe = as.data.frame(data)
avector <- aframe[['Genes']]
theme_set(theme_bw())

# Draw plot
p2 <- ggplot(data, aes(x=Assembly, y=Genes)) +
  geom_point(size=3) + 
  geom_segment(aes(x=Assembly, 
                   xend=Assembly, 
                   y=0, 
                   yend=Genes)) + 
  #labs(title="Amount of Genes in Each Assembly") +
  xlab("Assemblies") +
  ylab("Amount of Transcripts") +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) + 
  geom_label_repel(aes(label = avector), box.padding = 0.2,
                   color = 'black', size = 3.5)+ #point.padding = 1,
  #geom_text_repel(aes(label = avector), box.padding = 2,
  #               color = 'black', size = 3.5) +
  coord_flip() +
  scale_x_discrete(limits = positionOrders) + scale_y_continuous(expand = c(0, 0))



gt1 <- ggplotGrob(p1)
gt2 <- ggplotGrob(p2)
gt3 <- ggplotGrob(p3)

newWidth = unit.pmax(gt1$widths[2:3], gt2$widths[2:3])

gt1$widths[2:3] = as.list(newWidth)
gt2$widths[2:3] = as.list(newWidth)

PlotLog <- grid.arrange(gt2, gt1, ncol=2)


################
# nice Graph 1c #

data <- read.table("Z:/Work/NorfabShare/Articles/Vicine_paper/PanTranscriptome/Collected_flags.txt", header=TRUE, sep="\t")

data <- data.frame(mapply(`*`,data,100))

data <- data %>% 
  gather(key="text", value="value") %>%
  mutate(text = gsub("\\.", " ",text)) %>%
  mutate(value = round(as.numeric(value),0))


p3 <- data %>%
  ggplot( aes(x=text, y=value, fill=text, color=text)) +
  geom_violin(width=1, size=0.2) +
  scale_fill_viridis(discrete=TRUE) +
  scale_color_viridis(discrete=TRUE) +
  #scale_x_discrete(limits = positionOrders) +
  theme(
    legend.position="none", panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), axis.ticks.y = element_blank()) +
  coord_flip() + # This switch X and Y axis and allows to get the horizontal version
  xlab("") +
  ylab("Remapping (%) - 65 libraries")

p3 <- p3 + theme(axis.title.x = element_text(size = 15))   
p3 <- p3 + theme(axis.text.y = element_blank())  
p3 

gt1 <- ggplotGrob(p1)
gt2 <- ggplotGrob(p2)
gt3 <- ggplotGrob(p3)

newWidth = unit.pmax(gt1$widths[2:3], gt2$widths[2:3], gt3$widths[2:3])

gt1$widths[2:3] = as.list(newWidth)
gt2$widths[2:3] = as.list(newWidth)
gt3$widths[2:3] = as.list(newWidth)


PlotLog <- grid.arrange(gt2, gt3, gt1, ncol=3)

#
#1. Trinity ExpansionPod,	2a. DRAP ExpansionPod	3a. Evigene Hedin	4a. AllAccessions	2b. DRAP ExpansionPod	3b. Evigene Hedin	4b. AllAccessions	2c. DRAP ExpansionPod	3c. Evigene Hedin	4c. AllAccessions
# j, i, h, g, f, e, d, c, b, a


######
# Graph 3

data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/New_Article/Hedin_contamination_InsectaT.txt", 
  header = TRUE, sep="\t"))
data$Classification <- ordered(data$Cat, levels = c("Insecta", "Bacteria", "Fungi", "Unclassified", "Embryophyta"))



ggplot(data, aes(fill=Classification, y=Value, x=Tissue)) + 
  geom_bar(position="fill", stat="identity") +
  coord_flip() +
  scale_fill_manual(values = c("Insecta" = "#FDE725",
                               "Bacteria" = "#5DC863",
                               "Fungi" = "#21908C",
                               "Unclassified" = "#3B528B",
                               "Embryophyta" = "#440154")) +
  theme_bw() +
  theme(axis.ticks.y = element_blank(), 
        axis.title.y = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  ylab("Percentage of classifications")
  
  


vir_5 <- viridis(n = 5)
seecol(vir_5, col_brd = "white", lwd_brd = 4, 
       title = "Example of a viridis color palette (n = 10)",
       pal_names = paste0("viridis_", 1:10))

####
# New nice graph
devtools::install_github("ibecav/CGPfunctions")

newcancer

library(CGPfunctions)
??newcancer
moredata <- structure(list(Date = structure(c(1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L), 
                                            .Label = c("11-May-18", "18-May-18", "25-May-18"), 
                                            class = "factor"), 
                           Party = structure(c(5L, 3L, 2L, 1L, 4L, 5L, 3L, 2L, 1L, 4L, 5L, 3L, 2L, 1L, 4L), 
                                             .Label = c("Green", "Liberal", "NDP", "Others", "PC"), 
                                             class = "factor"), 
                           Pct = c(42.3, 28.4, 22.1, 5.4, 1.8, 41.9, 29.3, 22.3, 5, 1.4, 41.9, 26.8, 26.8, 5, 1.4)), 
                      class = "data.frame", 
                      row.names = c(NA, -15L))


data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/New_Article/Hedin_flower_before_after.txt", 
  header = TRUE, sep="\t"))


#is.num <- sapply(data, is.numeric)
#data[is.num] <- lapply(data[is.num], round, 2)

data$rPct <- signif(data$Pct, 2)
newggslopegraph(data, Filtering, rPct, Classification, Title = "Softfiltering", SubTitle = "on Hedin Flower Tissue", Caption = NULL)



set.seed(1000)
data <- data.frame(
  x=LETTERS[1:26], 
  y=abs(rnorm(26))
)

testcolors <- c("#F5B041", "#5DADE2")

######################
# ILB938 Melodie vc1 #
######################

data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/ilb938_melodie_vc1.txt", 
  header = TRUE, sep="\t"))

lollipop_melodie<- data %>%
  mutate(Tissue = fct_reorder(Tissue, VC1)) %>%
ggplot(data, mapping = aes(x=Tissue, y=VC1)) +
  geom_segment( aes(x=Tissue, xend=Tissue, y=0, yend=VC1), color="#D0D3D4") +
  geom_point( color=ifelse(data$mycolor %in% c("type1"), "#E04556", "#008080"), size=4) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="none", panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), axis.ticks.y = element_blank(),panel.border = element_blank(),
    plot.title = element_text(hjust = 0.5, size=14, face="bold")) +
  xlab("") + ylab("") + ggtitle('VC1 expression in ILB938 & Melodie (TMM)')
  #ylab("VC1 expression in ILB938 & Melodie (TMM)")

lollipop_melodie
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(lollipop_melodie,filename="lollipop_ilb938_melodie.png", height=4.5,width=6.5,units="in", path=path_of_file, dpi=300)

# orange and blue colors: "#F5B041", "#5DADE2"

#########################
# Feature 522 Mass spec #
#########################

data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/feature522_masspec.txt", 
  header = TRUE, sep="\t"))

bargraph_feature522 <- data %>%
  mutate(Tissue = fct_reorder(Tissue, mean)) %>%
ggplot() +
  geom_bar(aes(x=Tissue, y=mean), stat="identity", fill="#D0D3D4", alpha=0.7) +
  geom_linerange(aes(x=Tissue, ymin=sd_below, ymax=sd_above), colour="#E04556", alpha=0.9, size=1.3) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="none", panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), axis.ticks.y = element_blank(),
    panel.border = element_blank(),
    axis.text.y=element_text(size=12,face="bold"),
    plot.title = element_text(hjust = 0.5, size=16, face="bold")) +
  xlab("") + ylab("") + ggtitle('Quantitative MS of Vicine/Convicine')
  #ylab("Quantative mass spectrometry of Vicine/Convicine")

bargraph_feature522
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(bargraph_feature522,filename="bargraph_feature522.png", height=3.5,width=6.5,units="in", path=path_of_file, dpi=300)


################
# VC1 no roots #
################

data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/vc1_hedin_noroots.txt", 
  header = TRUE, sep="\t"))

bargraph_vc1 <- data %>%
  mutate(Tissue = fct_reorder(Tissue, mean)) %>%
  ggplot() +
  geom_bar(aes(x=Tissue, y=mean), stat="identity", fill="#D0D3D4", alpha=0.7) +
  geom_linerange(aes(x=Tissue, ymin=sd_below, ymax=sd_above), colour="#E04556", alpha=0.9, size=1.3) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="none", panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), axis.ticks.y = element_blank(),
    panel.border = element_blank(),
    axis.text.y=element_text(size=12,face="bold"),
    plot.title = element_text(hjust = 0.5, size=16, face="bold")) +
  xlab("") + ylab("") + ggtitle('VC1 expression in Hedin (TMM)')
  #ylab("VC1 expression in Hedin (TMM)")

bargraph_vc1
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(bargraph_vc1,filename="bargraph_vc1.png", height=3.0,width=5.5,units="in", path=path_of_file, dpi=300)


################
# VC1 no roots #
################

data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/vc1_hedin_roots.txt", 
  header = TRUE, sep="\t"))

bargraph_vc1_roots <- data %>%
  mutate(Tissue = fct_reorder(Tissue, mean)) %>%
  ggplot() +
  geom_bar(aes(x=Tissue, y=mean), stat="identity", fill="#D0D3D4", alpha=0.7) +
  geom_linerange(aes(x=Tissue, ymin=sd_below, ymax=sd_above), colour="#E04556", alpha=0.9, size=1.3) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="none", panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), axis.ticks.y = element_blank(),
    panel.border = element_blank(),
    axis.text.y=element_text(size=12,face="bold"),
    plot.title = element_text(hjust = 0.5, size=16, face="bold")) +
  xlab("") + ylab("") + ggtitle('VC1 expression in Hedin with Roots (TMM)')
  #ylab("VC1 expression in Hedin with Roots (TMM)")

bargraph_vc1_roots
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(bargraph_vc1_roots,filename="bargraph_vc1_roots.png", height=3.0,width=6.5,units="in", path=path_of_file, dpi=300)


################
# VC2 with roots #
################

data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/vc2_hedin_roots.txt", 
  header = TRUE, sep="\t"))

bargraph_vc2_roots <- data %>%
  mutate(Tissue = fct_reorder(Tissue, mean)) %>%
  ggplot() +
  geom_bar(aes(x=Tissue, y=mean), stat="identity", fill="#D0D3D4", alpha=0.7) +
  geom_linerange(aes(x=Tissue, ymin=sd_below, ymax=sd_above), colour="#E04556", alpha=0.9, size=1.3) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="none", panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), axis.ticks.y = element_blank(),
    panel.border = element_blank(),
    axis.text.y=element_text(size=12,face="bold"),
    plot.title = element_text(hjust = 0.5, size=16, face="bold")) +
  xlab("") + ylab("") + ggtitle('VC2 expression in Hedin with Roots (TMM)')
  #ylab("VC2 expression in Hedin with Roots (TMM)")

bargraph_vc2_roots
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(bargraph_vc2_roots,filename="bargraph_vc2_roots.png", height=3.5,width=6.5,units="in", path=path_of_file, dpi=300)


###########################
# Feature 44(+) Mass spec #
###########################

data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/feature44_masspec.txt", 
  header = TRUE, sep="\t"))

bargraph_feature44 <- data %>%
  mutate(Tissue = fct_reorder(Tissue, mean)) %>%
  ggplot() +
  geom_bar(aes(x=Tissue, y=mean), stat="identity", fill="#D0D3D4", alpha=0.7) +
  geom_linerange(aes(x=Tissue, ymin=sd_below, ymax=sd_above), colour="#E04556", alpha=0.9, size=1.3) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="none", panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), axis.ticks.y = element_blank(),
    panel.border = element_blank(),
    axis.text.y=element_text(size=12,face="bold"),
    plot.title = element_text(hjust = 0.5, size=16, face="bold")) +
  xlab("") + ylab("") + ggtitle('Quantitative MS of Vicine/Convicine in Roots')
#ylab("Quantitative mass spectrometry of Vicine/Convicine")

bargraph_feature44
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(bargraph_feature44,filename="bargraph_feature44.png", height=3.0,width=6.5,units="in", path=path_of_file, dpi=300)


#######################
# Seed coat Mass spec #
#######################

data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/seedcoat_masspec.txt", 
  header = TRUE, sep="\t"))

bargraph_seedcoat <- data %>%
  mutate(Tissue = fct_reorder(Tissue, mean)) %>%
  ggplot() +
  geom_bar(aes(x=Tissue, y=mean), stat="identity", fill="#D0D3D4", alpha=0.7) +
  geom_linerange(aes(x=Tissue, ymin=sd_below, ymax=sd_above), colour="#E04556", alpha=0.9, size=1.3) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="none", panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), axis.ticks.y = element_blank(),
    panel.border = element_blank(),
    axis.text.y=element_text(size=12,face="bold"),
    plot.title = element_text(hjust = 0.5, size=16, face="bold")) +
  xlab("") + ylab("") + ggtitle('Quantitative MS of V/Cv in V/Cv containing tissues')
#ylab("Quantative mass spectrometry of Vicine/Convicine")

bargraph_seedcoat
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(bargraph_seedcoat,filename="bargraph_seedcoat.png", height=1.5,width=7.5,units="in", path=path_of_file, dpi=300)



############################
# Orthofinder Final Result #
############################

# Dataset
input <- c(
  "159b" = 52,
  "2378" = 53,
  Hedin = 198,
  Hiverna = 54,
  "159b&2378&Hedin&Hiverna" = 14486,
  "159b&2378" = 387,
  "2378&Hedin" = 531,
  "2378&Hedin&Hiverna" = 791,
  "Hedin&Hiverna" = 648,
  "159b&2378&Hiverna" = 584,
  "159b&Hedin&Hiverna" = 537,
  "159b&2378&Hedin" = 440,
  "159b&Hiverna" = 376,
  "159b&Hedin" = 404,
  "2378&Hiverna" = 506
)

# Plot
UpSet_final <- upset(fromExpression(input), 
      nintersects = 15, 
      nsets = , 
      order.by = "freq", 
      decreasing = T, 
      mb.ratio = c(0.6, 0.4),
      number.angles = 0, 
      #text.scale = 1.1, 
      point.size = 2.8, 
      line.size = 1,
      mainbar.y.label = "Orthogroup Intersections", 
      sets.x.label = "Orthogroups Per Accession", 
      text.scale = c(1.5, 1.3, 1.2, 1.2, 1.5, 1.3),
      queries = list(list(query = elements, params = list("159b", 
                                                          "2378", "Hiverna", "Hedin"), color = "#008080", active = T))
)
UpSet_final


#8ea0bd #3975d4

path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(UpSet_final,filename="UpSet_final.png", height=6.5,width=7.5,units="in", path=path_of_file, dpi=300)

############################
# Orthofinder First Result #
############################

# Dataset
input <- c(
  "159b" = 7,
  "2378" = 13,
  Hedin = 32,
  Hiverna = 6508,
  "159b&2378&Hedin&Hiverna" = 94401,
  "159b&2378" = 1315,
  "2378&Hedin" = 2278,
  "2378&Hiverna" = 6364,
  "2378&Hedin&Hiverna" = 4939,
  "Hedin&Hiverna" = 23588,
  "159b&2378&Hiverna" = 5177,
  "159b&Hedin&Hiverna" = 2077,
  "159b&2378&Hedin" = 1919,
  "159b&Hiverna" = 5689,
  "159b&Hedin" = 1632
)

# Plot
upset(fromExpression(input), 
      nintersects = 15, 
      nsets = , 
      order.by = "freq", 
      decreasing = T, 
      mb.ratio = c(0.6, 0.4),
      number.angles = 0, 
      #text.scale = 1.1, 
      point.size = 2.8, 
      line.size = 1,
      mainbar.y.label = "Orthogroups Intersections", 
      sets.x.label = "Orthologous Transcripts Shared", 
      text.scale = c(1.5, 1.3, 1.2, 1.2, 1.5, 1.3),
      queries = list(list(query = elements, params = list("159b", "2378", "Hiverna", "Hedin"), 
                          color = "#008080", active = T), 
                     list(query = elements, params = list("Hiverna"), 
                          color = "#E04556", active = T))
)
#8ea0bd #3975d4

##################################
# Lollipop Unique Genes in Hedin #
##################################

data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/New_Article/Unique_Genes_Hedin.txt", 
  header = TRUE, sep="\t"))

lollipop_Uniq_Hedin<- data %>%
  mutate(Tissue = fct_reorder(Tissue, Freq)) %>%
  ggplot(data, mapping = aes(x=Tissue, y=Freq)) +
  geom_segment( aes(x=Tissue, xend=Tissue, y=0, yend=Freq), color="#D0D3D4") +
  geom_point( color=ifelse(data$Type %in% c("type1"), "#E04556", "#008080"), size=4) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="none", panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), axis.ticks.y = element_blank(),panel.border = element_blank(),
    plot.title = element_text(hjust = 0.5, size=14, face="bold")) +
  xlab("") + ylab("") + ggtitle('One Cluster Transcripts in each Hedin Tissue')
#ylab("VC1 expression in ILB938 & Melodie (TMM)")

lollipop_Uniq_Hedin
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(lollipop_Uniq_Hedin,filename="lollipop_Uniq_Hedin.png", height=3.5,width=6.5,units="in", path=path_of_file, dpi=300)

#################################
# Lollipop Unique Genes in 159b #
#################################

data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/New_Article/Unique_Genes_159b.txt", 
  header = TRUE, sep="\t"))

lollipop_Uniq_159b<- data %>%
  mutate(Tissue = fct_reorder(Tissue, Freq)) %>%
  ggplot(data, mapping = aes(x=Tissue, y=Freq)) +
  geom_segment( aes(x=Tissue, xend=Tissue, y=0, yend=Freq), color="#D0D3D4") +
  geom_point( color=ifelse(data$Type %in% c("type1"), "#E04556", "#008080"), size=4) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="none", panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), axis.ticks.y = element_blank(),panel.border = element_blank(),
    plot.title = element_text(hjust = 0.5, size=14, face="bold")) +
  xlab("") + ylab("") + ggtitle('One Cluster Transcripts in each 159b Tissue')
#ylab("VC1 expression in ILB938 & Melodie (TMM)")

lollipop_Uniq_159b
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(lollipop_Uniq_159b,filename="lollipop_Uniq_159b.png", height=1.5,width=6.5,units="in", path=path_of_file, dpi=300)

#################################
# Lollipop Unique Genes in 2378 #
#################################

data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/New_Article/Unique_Genes_2378.txt", 
  header = TRUE, sep="\t"))

lollipop_Uniq_2378<- data %>%
  mutate(Tissue = fct_reorder(Tissue, Freq)) %>%
  ggplot(data, mapping = aes(x=Tissue, y=Freq)) +
  geom_segment( aes(x=Tissue, xend=Tissue, y=0, yend=Freq), color="#D0D3D4") +
  geom_point( color=ifelse(data$Type %in% c("type1"), "#E04556", "#008080"), size=4) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="none", panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), axis.ticks.y = element_blank(),panel.border = element_blank(),
    plot.title = element_text(hjust = 0.5, size=14, face="bold")) +
  xlab("") + ylab("") + ggtitle('One Cluster Transcripts in each 2378 Tissue')
#ylab("VC1 expression in ILB938 & Melodie (TMM)")

lollipop_Uniq_2378
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(lollipop_Uniq_2378,filename="lollipop_Uniq_2378.png", height=1.5,width=6.5,units="in", path=path_of_file, dpi=300)

#################################
# Lollipop Unique Genes in Hiverna #
#################################

data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/pan-transcriptomics/New_Article/Unique_Genes_Hiverna.txt", 
  header = TRUE, sep="\t"))

lollipop_Uniq_Hiverna<- data %>%
  mutate(Tissue = fct_reorder(Tissue, Freq)) %>%
  ggplot(data, mapping = aes(x=Tissue, y=Freq)) +
  geom_segment( aes(x=Tissue, xend=Tissue, y=0, yend=Freq), color="#D0D3D4") +
  geom_point( color=ifelse(data$Type %in% c("type1"), "#E04556", "#008080"), size=4) +
  theme_light() +
  coord_flip() +
  theme(
    legend.position="none", panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), axis.ticks.y = element_blank(),panel.border = element_blank(),
    plot.title = element_text(hjust = 0.5, size=14, face="bold")) +
  xlab("") + ylab("") + ggtitle('One Cluster Transcripts in each Hiverna Tissue')
#ylab("VC1 expression in ILB938 & Melodie (TMM)")

lollipop_Uniq_Hiverna
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(lollipop_Uniq_Hiverna,filename="lollipop_Uniq_Hiverna.png", height=1.5,width=6.5,units="in", path=path_of_file, dpi=300)



###########################
# Stacked Bargraph Flower #
###########################


data = as.data.frame(read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/flower_kraken2_filtration.txt", header = TRUE, sep="\t"))


Stacked_Flower <- ggplot(data, mapping =aes(fill=Classification, y=Value, x=reorder(Assembly, desc(Assembly)))) + 
  geom_bar(stat="identity", alpha=.8, width=.4) +
  # ylab("Kraken 2 Classifications") +
  scale_fill_manual(values = c("Embryophyta" = "#003f5c",
                               "Unclassified" = "#58508d",
                               "Insecta" = "#bc5090",
                               "Fungi" = "#ff6361",
                               "Bacteria" = "#ffa600")) +
  coord_flip() +
  theme_light() +
  theme(axis.title.y = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.text.y=element_text(size=12,face="bold"),
        plot.title = element_text(hjust = 0.5, size=14, face="bold")) + 
  ggtitle('Kraken 2 Classifications of Hedin Flower') +
  ylab("")
  
Stacked_Flower

path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(Stacked_Flower,filename="stacked_hedin_flower_kraken2.png", height=2.5,width=6.5,units="in", path=path_of_file, dpi=300)

######################
# BUSCO Other Species#
######################

positionOrdersOther <- rev(c("Pisum", "Medicago", "Lotus", "M09a", "ModeSF"))
data = as.data.frame(read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/other_species_busco.txt", header = TRUE, sep="\t"))


busco_other_species <- ggplot(data, mapping =aes(fill=Condition, y=Value, x=Assembly)) + 
  geom_bar(position= position_fill(reverse = TRUE), stat="identity", alpha=.8, width=.4) +
  ylab("BUSCO Score") +
  scale_fill_manual(values = c("Complete single-copy" = "#35B779",
                               "Duplicated" = "#31688E",
                               "Fragmented" = "#FDE725",
                               "Missing" = "#440154")) +
  coord_flip() +
  theme_bw() +
  theme(axis.title.y = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.text.y=element_text(size=12,face="bold"),
        plot.title = element_text(hjust = 0.5, size=14, face="bold")) +
  scale_x_discrete(limits = positionOrdersOther) +
  ggtitle('BUSCO score of Legumes and the Pan-Transcriptome') + 
  ylab("")

busco_other_species
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(busco_other_species,filename="busco_other_species.png", height=2.5,width=6.5,units="in", path=path_of_file, dpi=300)


########################
# 3-point graph - M09a #
########################

# BUSCO figure
positionOrders3PM09a <- rev(c("Trinity", "DRAP", "Evigene", "Pan-Transcriptome"))
data = as.data.frame(read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/m09a_busco.txt", header = TRUE, sep="\t"))


p1 <- ggplot(data, mapping =aes(fill=Condition, y=Value, x=Assembly)) + 
  geom_bar(position= position_fill(reverse = TRUE), stat="identity", alpha=.8, width=.4) +
  ylab("BUSCO Score") +
  scale_fill_manual(values = c("Complete single-copy" = "#35B779",
                               "Duplicated" = "#31688E",
                               "Fragmented" = "#FDE725",
                               "Missing" = "#440154")) +
  coord_flip() +
  theme(axis.text.y=element_text(size=12,face="bold"), 
        axis.ticks.y = element_blank(), 
        axis.title.y = element_blank(), 
        panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  scale_x_discrete(limits = positionOrders3PM09a)

p1

# Transcript lollipop
data <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/m09a_transcripts.txt", header=TRUE, sep="\t")
aframe = as.data.frame(data)
avector <- aframe[['Genes']]
theme_set(theme_bw())

p2 <- ggplot(data, aes(x=Assembly, y=Genes)) +
  geom_point(size=4, color="#008080") + 
  geom_segment(aes(x=Assembly, 
                   xend=Assembly, 
                   y=0, 
                   yend=Genes), color="#D0D3D4") + 
  #labs(title="Amount of Genes in Each Assembly") +
  ylab("Transcripts") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.ticks.y = element_blank(), 
        axis.title.y = element_blank(), 
        axis.text.y=element_text(size=12,face="bold")) + 
  geom_label_repel(aes(label = avector), box.padding = 0.2,
                   color = 'black', size = 3.5)+ #point.padding = 1,
  #geom_text_repel(aes(label = avector), box.padding = 2,
  #               color = 'black', size = 3.5) +
  coord_flip() +
  scale_x_discrete(limits = positionOrders3PM09a) + scale_y_continuous(expand = c(0, 0))

p2

# BWA violin plot

data <- as.data.frame(read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/m09a_BWA_reformat.txt", header=TRUE, sep="\t"))

data$value <- mapply(`*`,data$value,100)

p3 <- data %>%
  ggplot( aes(x=text, y=value, fill=text, color=text)) +
  geom_violin(width=1, size=0.2, fill='#008080', color="#D0D3D4") +
  #scale_fill_viridis(discrete=TRUE) +
  #scale_color_viridis(discrete=TRUE) +
  scale_x_discrete(limits = positionOrders3PM09a) +
  theme(
    legend.position="none", 
    panel.border = element_blank(),
    axis.line = element_line(colour = "black"),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    axis.ticks.y = element_blank(), 
    axis.title.y = element_blank(), 
    axis.text.y=element_text(size=12,face="bold")) +
  coord_flip() + # This switch X and Y axis and allows to get the horizontal version
  xlab("") +
  ylab("Properly mapped (%) - 65 libraries")
 
p3 


PlotM09a_pipeline <- ggarrange(p2, p3, p1, 
                               labels = c("A", "B", "C"),
                               ncol = 1, nrow = 3)


PlotM09a_pipeline
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(PlotM09a_pipeline ,filename="3PlotM09a_pipeline.png", height=8,width=5,units="in", path=path_of_file, dpi=300)


#########################
# 3-point graph - MODES #
#########################

# BUSCO figure
positionOrders3PM09a <- rev(c("M09a", "ModeE", "ModeEU", "ModeSF"))
data = as.data.frame(read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/modes_busco.txt", header = TRUE, sep="\t"))


p1Modes <- ggplot(data, mapping =aes(fill=Condition, y=Value, x=Assembly)) + 
  geom_bar(position= position_fill(reverse = TRUE), stat="identity", alpha=.8, width=.4) +
  ylab("BUSCO Score") +
  scale_fill_manual(values = c("Complete single-copy" = "#35B779",
                               "Duplicated" = "#31688E",
                               "Fragmented" = "#FDE725",
                               "Missing" = "#440154")) +
  coord_flip() +
  theme(axis.text.y=element_text(size=12,face="bold"), 
        panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.ticks.y = element_blank(), 
        axis.title.y = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  scale_x_discrete(limits = positionOrders3PM09a)

p1Modes

# Transcript lollipop
data <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/modes_transcripts.txt", header=TRUE, sep="\t")
aframe = as.data.frame(data)
avector <- aframe[['Genes']]
theme_set(theme_bw())

p2Modes <- ggplot(data, aes(x=Assembly, y=Genes)) +
  geom_point(size=4, color="#008080") + 
  geom_segment(aes(x=Assembly, 
                   xend=Assembly, 
                   y=0, 
                   yend=Genes), color="#D0D3D4") + 
  #labs(title="Amount of Genes in Each Assembly") +
  ylab("Transcripts") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.ticks.y = element_blank(), 
        axis.title.y = element_blank(), 
        axis.text.y=element_text(size=12,face="bold")) + 
  geom_label_repel(aes(label = avector), box.padding = 0.2,
                   color = 'black', size = 3.5)+ #point.padding = 1,
  #geom_text_repel(aes(label = avector), box.padding = 2,
  #               color = 'black', size = 3.5) +
  coord_flip() +
  scale_x_discrete(limits = positionOrders3PM09a) + scale_y_continuous(expand = c(0, 0))

p2Modes

# BWA violin plot

data <- as.data.frame(read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/modes_BWA_perfect_reformat.txt", header=TRUE, sep="\t"))

data$value <- mapply(`*`,data$value,100)

p3Modes <- data %>%
  ggplot( aes(x=text, y=value, fill=text, color=text)) +
  geom_violin(width=1, size=0.2, fill='#008080', color="#D0D3D4") +
  #scale_fill_viridis(discrete=TRUE) +
  #scale_color_viridis(discrete=TRUE) +
  scale_x_discrete(limits = positionOrders3PM09a) +
  theme(
    legend.position="none", 
    panel.border = element_blank(),
    axis.line = element_line(colour = "black"),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    axis.ticks.y = element_blank(), 
    axis.title.y = element_blank(), 
    axis.text.y=element_text(size=12,face="bold")) +
  coord_flip() + # This switch X and Y axis and allows to get the horizontal version
  xlab("") +
  ylab("Properly mapped (%) - 65 libraries")

p3Modes 


Plot_modes <- ggarrange(p2Modes, p3Modes, p1Modes, 
                               labels = c("A", "B", "C"),
                               ncol = 1, nrow = 3)


Plot_modes
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(Plot_modes, filename="3Plot_modes.png", height=8,width=5,units="in", path=path_of_file, dpi=300)



##############################
# Comparing proper and total #
##############################

data <- as.data.frame(read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/modes_BWA_properly_total_reformat.txt", header=TRUE, sep="\t"))

data$value <- mapply(`*`,data$value,100)

positionOrders3PM09a <- rev(c("M09a", "ModeE", "ModeEU", "ModeSF"))
p3_total_properly <- data %>%
  ggplot( aes(x=text, y=value, fill=Mapping, color=Mapping)) +
  geom_violin(width=1, size=0.2) +
  #scale_fill_viridis(discrete=TRUE) +
  #scale_color_viridis(discrete=TRUE) +
  scale_x_discrete(limits = positionOrders3PM09a) +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    axis.line = element_line(colour = "black"),
    axis.ticks.y = element_blank(), 
    axis.title.y = element_blank(), 
    axis.text.y=element_text(size=12,face="bold")) +
  coord_flip() + # This switch X and Y axis and allows to get the horizontal version
  xlab("") +
  ylab("Remapping (%) - 65 libraries")

p3_total_properly 
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(p3_total_properly, filename="bwa_total_properly_modes.png", height=3,width=5,units="in", path=path_of_file, dpi=300)


##################################################
# Orthofinder Transcripts in Ortogprups Kraken 2 #
##################################################

# Dataset
input <- c(
  "159b" = 175,
  "2378" = 187,
  Hedin = 566,
  Hiverna = 208,
  "159b&2378" = 885,
  "159b&Hedin" = 919,
  "159b&Hiverna" = 831,
  "159b&2378&Hedin" = 1635,
  "159b&2378&Hiverna" = 1996,
  "159b&2378&Hedin&Hiverna" = 70782,
  "159b&Hedin&Hiverna" = 1933,
  "2378&Hedin" = 1277,
  "2378&Hiverna" = 1165,
  "2378&Hedin&Hiverna" = 3175,
  "Hedin&Hiverna" = 1575
)

# Plot
UpSet_TO <- upset(fromExpression(input), 
                     nintersects = 15, 
                     nsets = , 
                     order.by = "freq", 
                     decreasing = T, 
                     mb.ratio = c(0.6, 0.4),
                     number.angles = 0, 
                     #text.scale = 1.1, 
                     point.size = 2.8, 
                     line.size = 1,
                     mainbar.y.label = "Orthogroup Intersections", 
                     sets.x.label = "Orthologous Transcripts Shared", 
                     text.scale = c(1.5, 1.3, 1.2, 1.2, 1.5, 1.3),
                     queries = list(list(query = elements, params = list("159b", 
                                                                         "2378", "Hiverna", "Hedin"), color = "#008080", active = T))
)
UpSet_TO
#8ea0bd #3975d4


###############################################################
# Orthofinder Transcripts in Ortogprups Kraken 2 + Unassgined #
###############################################################

# Dataset
input <- c(
  "159b" = 1311,
  "2378" = 1335,
  Hedin = 2961,
  Hiverna = 1675,
  "159b&2378" = 885,
  "159b&Hedin" = 919,
  "159b&Hiverna" = 831,
  "159b&2378&Hedin" = 1635,
  "159b&2378&Hiverna" = 1996,
  "159b&2378&Hedin&Hiverna" = 70782,
  "159b&Hedin&Hiverna" = 1933,
  "2378&Hedin" = 1277,
  "2378&Hiverna" = 1165,
  "2378&Hedin&Hiverna" = 3175,
  "Hedin&Hiverna" = 1575
)

# Plot
UpSet_TOU <- upset(fromExpression(input), 
                  nintersects = 15, 
                  nsets = , 
                  order.by = "freq", 
                  decreasing = T, 
                  mb.ratio = c(0.6, 0.4),
                  number.angles = 0, 
                  #text.scale = 1.1, 
                  point.size = 2.8, 
                  line.size = 1,
                  mainbar.y.label = "Orthogroup Intersections", 
                  sets.x.label = "Orthologous Transcripts Shared", 
                  text.scale = c(1.5, 1.3, 1.2, 1.2, 1.5, 1.3),
                  queries = list(list(query = elements, params = list("159b", 
                                                                      "2378", "Hiverna", "Hedin"), color = "#008080", active = T))
)
UpSet_TOU
#8ea0bd #3975d4

#########################################
# Orthofinder Multiple species - Bugfree#
#########################################

# Dataset
input <- c(
  "Lotus" = 4632,
  "Medicago" = 10634,
  Faba = 8319,
  Pisum = 17203,
  "Lotus&Medicago" = 1567,
  "Lotus&Faba" = 1160,
  "Lotus&Pisum" = 431,
  "Lotus&Medicago&Faba" = 3194,
  "Lotus&Medicago&Pisum" = 3941,
  "Lotus&Medicago&Faba&Pisum" = 86474,
  "Lotus&Faba&Pisum" = 1964,
  "Medicago&Faba" = 1105,
  "Medicago&Pisum" = 3161,
  "Medicago&Faba&Pisum" = 6798,
  "Faba&Pisum" = 3413
)

# Plot
UpSet_Multi <- upset(fromExpression(input), 
                   nintersects = 15, 
                   nsets = , 
                   order.by = "freq", 
                   decreasing = T, 
                   mb.ratio = c(0.6, 0.4),
                   number.angles = 0, 
                   #text.scale = 1.1, 
                   point.size = 2.8, 
                   line.size = 1,
                   mainbar.y.label = "Orthogroup Intersections", 
                   sets.x.label = "Orthologous Transcripts Shared", 
                   text.scale = c(1.5, 1.3, 1.2, 1.2, 1.5, 1.3),
                   queries = list(list(query = elements, params = list("Lotus", 
                                                                       "Medicago", "Faba", "Pisum"), color = "#008080", active = T))
)
UpSet_Multi

####################
# DRAP - Cleveland #
####################



data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/DRAP_cleveland_reorder_v2.txt", 
  header = TRUE, sep="\t"))

data$Tissue <- factor(data$Tissue, levels = unique(data$Tissue), ordered=TRUE)

right_label <- data %>%
  group_by(Tissue) %>%
  arrange(desc(BUSCO)) %>%
  top_n(1)

left_label <- data %>%
  group_by(Tissue) %>%
  arrange(desc(BUSCO)) %>%
  slice(2)

cleveland_DRAP <- ggplot(data, aes(BUSCO, Tissue)) +
  geom_line(aes(group = Tissue)) +
  geom_point(aes(color = Assembly), size = 1.5) +
  geom_text(data = right_label, aes(color = Assembly, label = round(BUSCO, 1)),
            size = 4, hjust = -.5, show.legend=F) +
  geom_text(data = left_label, aes(color = Assembly, label = round(BUSCO, 1)),
            size = 4, hjust = 1.5, show.legend=F) +
  scale_x_continuous(limits = c(63, 93)) +
  scale_y_discrete(expand = c(.02, 0)) +
  labs(title = "Complete BUSCO's between the assemblies",
       subtitle = "") +
  theme_minimal() +
  theme(axis.title = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        legend.title = element_blank(),
        legend.justification = c(0, 1), 
        legend.position = c(.1, 1.08),
        legend.background = element_blank(),
        legend.direction="horizontal",
        axis.text.y=element_text(size=12,face="bold"),
        plot.title = element_text(size = 20, margin = margin(b = 10)))




cleveland_DRAP
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(cleveland_DRAP, filename="cleveland_DRAP.png", height=5,width=9,units="in", path=path_of_file, dpi=300)


####################
# DRAP - Cleveland #
####################



data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/DRAP_cleveland_reorder.txt", 
  header = TRUE, sep="\t"))

data$Tissue <- factor(data$Tissue, levels = unique(data$Tissue), ordered=TRUE)

right_label <- data %>%
  group_by(Tissue) %>%
  arrange(desc(BUSCO)) %>%
  top_n(1)

left_label <- data %>%
  group_by(Tissue) %>%
  arrange(desc(BUSCO)) %>%
  slice(2)

cleveland_DRAP <- ggplot(data, aes(BUSCO, Tissue)) +
  geom_line(aes(group = Tissue)) +
  geom_point(aes(color = Assembly), size = 1.5) +
  geom_text(data = right_label, aes(color = Assembly, label = round(BUSCO, 1)),
            size = 4, hjust = -.5, show.legend=F) +
  geom_text(data = left_label, aes(color = Assembly, label = round(BUSCO, 1)),
            size = 4, hjust = 1.5, show.legend=F) +
  scale_x_continuous(limits = c(70.5, 95.5)) +
  scale_y_discrete(expand = c(.02, 0)) +
  labs(title = "Complete BUSCO's between assemblies in Hedin",
       subtitle = "") +
  theme_minimal() +
  theme(axis.title = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        legend.title = element_blank(),
        legend.justification = c(0, 1), 
        legend.position = c(.1, 1.08),
        legend.background = element_blank(),
        legend.direction="horizontal",
        axis.text.y=element_text(size=12,face="bold"),
        plot.title = element_text(size = 20, margin = margin(b = 10)))




cleveland_DRAP
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(cleveland_DRAP, filename="cleveland_DRAP.png", height=5,width=9,units="in", path=path_of_file, dpi=300)


#######################
# Cleveland BinPacker #
#######################


data = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/BinPacker_cleveland_reorder.txt", 
  header = TRUE, sep="\t"))

data$Tissue <- factor(data$Tissue, levels = unique(data$Tissue), ordered=TRUE)

right_label <- data %>%
  group_by(Tissue) %>%
  arrange(desc(BUSCO)) %>%
  top_n(1)

left_label <- data %>%
  group_by(Tissue) %>%
  arrange(desc(BUSCO)) %>%
  slice(2)

right_label = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/BinPacker_cleveland_right.txt", 
  header = TRUE, sep="\t"))

left_label = as.data.frame(read.table(
  "C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/BinPacker_cleveland_left.txt", 
  header = TRUE, sep="\t"))

cleveland_BinPacker <- ggplot(data, aes(BUSCO, Tissue)) +
  geom_line(aes(group = Tissue)) +
  geom_point(aes(color = Assembly), size = 1.5) +
  geom_text(data = right_label, aes(color = Assembly, label = round(BUSCO, 1)),
            size = 4, hjust = -.5, show.legend=F) +
  geom_text(data = left_label, aes(color = Assembly, label = round(BUSCO, 1)),
            size = 4, hjust = 1.5, show.legend=F) +
  scale_x_continuous(limits = c(60, 85)) +
  scale_y_discrete(expand = c(.02, 0)) +
  labs(title = "Complete BUSCO's between using BinPacker or Trinity in Hiverna",
       subtitle = "") +
  theme_minimal() +
  theme(axis.title = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        legend.title = element_blank(),
        legend.justification = c(0, 1), 
        legend.position = c(.1, 1.14),
        legend.background = element_blank(),
        legend.direction="horizontal",
        axis.text.y=element_text(size=12,face="bold"),
        plot.title = element_text(size = 20, margin = margin(b = 10)))




cleveland_BinPacker
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(cleveland_BinPacker, filename="cleveland_BinPacker.png", height=4,width=9,units="in", path=path_of_file, dpi=300)


####

# BUSCO figure


data <- as.data.frame(read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/path_BWA_properly_total_reformat.txt", header=TRUE, sep="\t"))

data$value <- mapply(`*`,data$value,100)

positionOrders3PM09a <- rev(c("Combined", "M09st", "M02st_CD","M09a", "M02a_CD", "Hiverna", "2378", "159b", "Hedin", "M02a_Evigene", "M10"))


path_total_properly <- data %>%
  ggplot( aes(x=text, y=value, fill=Mapping, color=Mapping)) +
  geom_violin(width=1, size=0.2, alpha=0.8) +
  #scale_fill_viridis(discrete=TRUE) +
  #scale_color_viridis(discrete=TRUE) +
  scale_x_discrete(limits = positionOrders3PM09a) +
  scale_fill_manual(values = c("Properly mapped" = "#ffa600",
                               "Total mapped" = "#003f5c")) +
  theme_bw() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    axis.line = element_line(colour = "black"),
    axis.ticks.y = element_blank(), 
    axis.title.y = element_blank(), 
    axis.text.y=element_text(size=12,face="bold")) +
  coord_flip() + # This switch X and Y axis and allows to get the horizontal version
  xlab("") +
  ylab("Remapping (%) - 65 libraries")

path_total_properly 
path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Thesis/Figures/Self_Made/Results/"
ggsave(path_total_properly, filename="bwa_total_properly_path.png", height=4,width=5,units="in", path=path_of_file, dpi=300)

