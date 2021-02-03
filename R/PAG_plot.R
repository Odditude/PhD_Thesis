specie <- c(rep("sorgho" , 3) , rep("poacee" , 3) , rep("banana" , 3) , rep("triticum" , 3) )
condition <- rep(c("normal" , "stress" , "Nitrogen") , 4)
value <- abs(rnorm(12 , 0 , 15))
data <- data.frame(specie,condition,value)


library(ggplot2)
library(viridis)
library(hrbrthemes)
library(formattable)
library(dplyr)
library(tidyverse)
library("htmltools")
library(tidyr)
library(forcats)
library(viridis)
library(plotly)
library(knitr)
library(rmdformats)


BUSCO_data <- read.table(file = "C:/Users/au338462/OneDrive/Dokumenter/PhD/Conferences/PAG/BUSCO_scores.txt", header = TRUE)
df_BUSCO <- as.data.frame(BUSCO_data)
df_BUSCO$BUSCO <- factor(df_BUSCO$BUSCO, levels = df_BUSCO$BUSCO)
df_BUSCO$Value = percent(df_BUSCO$Value)
ggplot(df_BUSCO, aes(fill=BUSCO, y=Value, x=BUSCO)) + 
  geom_bar(position="dodge", stat="identity") +
  geom_text(aes(label=Value), vjust=-0.3, size=3.5) +
  scale_fill_viridis(discrete = T, option = "E") +
  ggtitle("Quality Accessment via BUSCO") +
  facet_wrap(~Condition) +
  theme_classic() + 
  theme(legend.position="none") +
  xlab("")



data <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Dijon/BWA_for_Box_1.txt", header=TRUE)


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


data <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Conferences/PAG/MelILB.txt", header=TRUE)


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
  ylab("Remapping (%) - 21 libraries")

p <- p + theme(axis.title.x = element_text(size = 15))
p <- p + theme(axis.text.x = element_text(size=14),
          axis.text.y = element_text(face="bold", size=14))
p <- ggplotly(p)
p


hedin_cluster <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Conferences/PAG/clust_hedin.txt", header=TRUE)
df_hedin <- as.data.frame(hedin_cluster)

p <- ggplot(df_hedin, aes(fill=Transcripts, y=Transcripts, x=Tissues
)) + 
  geom_bar(position="dodge", stat="identity") +
  ggtitle("Hedin - Transcripts from 1 member clusters") +
  geom_text(aes(label=Transcripts), vjust=1.6, color="white", size = 5) +
  theme_classic() + 
  theme(legend.position="none") +
  xlab("")

p <- p + theme(axis.text.y=element_blank())
p <- p + theme(axis.text.x = element_text(size=14), axis.title.y = element_text(size = 14))
p

hiverna_cluster <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Conferences/PAG/clust_hiverna.txt", header=TRUE)
df_hiverna <- as.data.frame(hiverna_cluster)

p <- ggplot(df_hiverna, aes(fill=Transcripts, y=Transcripts, x=Tissues
)) + 
  geom_bar(position="dodge", stat="identity") +
  ggtitle("Hiverna - Transcripts from 1 member clusters") +
  geom_text(aes(label=Transcripts), vjust=1.6, color="white", size = 5) +
  theme_classic() + 
  theme(legend.position="none") +
  xlab("")

p <- p + theme(axis.text.y=element_blank())
p <- p + theme(axis.text.x = element_text(size=14), axis.title.y = element_text(size = 14))
p

A159b_cluster <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Conferences/PAG/clust_159b.txt", header=TRUE)
df_159b <- as.data.frame(A159b_cluster)

p <- ggplot(df_159b, aes(fill=Transcripts, y=Transcripts, x=Tissues
)) + 
  geom_bar(position="dodge", stat="identity") +
  ggtitle("159b - Transcripts from 1 member clusters") +
  geom_text(aes(label=Transcripts), vjust=1.6, color="white", size = 5) +
  theme_classic() + 
  theme(legend.position="none") +
  xlab("")

p <- p + theme(axis.text.y=element_blank())
p <- p + theme(axis.text.x = element_text(size=14), axis.title.y = element_text(size = 14))
p

A2378_cluster <- read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Conferences/PAG/cluster_23.txt", header=TRUE)
df_2378 <- as.data.frame(A2378_cluster)

p <- ggplot(df_2378, aes(fill=Transcripts,y=Transcripts, x=Tissues)) + 
  geom_bar(position="dodge", stat="identity") +
  ggtitle("2378 - Transcripts from 1 member clusters") +
  geom_text(aes(label=Transcripts), vjust=1.6, color="white", size = 5) +
  theme_classic() + 
  theme(legend.position="none") +
  xlab("")

p <- p + theme(axis.text.y=element_blank())
p <- p + theme(axis.text.x = element_text(size=14), axis.title.y = element_text(size = 14))
p
