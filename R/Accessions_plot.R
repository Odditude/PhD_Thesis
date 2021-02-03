setwd("Z:\\Work\\NorfabShare\\R\\ICLGG\\")
getwd()
library(ggplot2)
library(scales)

Data = read.table("Mapped_Ass.txt", header = TRUE, sep = '\t')
df_Data = as.data.frame(Data, header = TRUE)


######################
# Total Mapped Reads #
######################

Total_plot = ggplot(df_Data,aes(x = Accessions,  y = Total_mapped_reads, fill = Accessions)) +
  geom_col(position = position_dodge2(width = 0.9, preserve = "single")) + 
  scale_fill_manual(values=c("#E69F00", "#56B4E9", "#009E73", "#0072B2", "#D55E00", "#CC79A7")) +
  theme_bw() + ggtitle("Percentage of total mapped reads") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 26)) +
  theme(axis.text.x = element_text(size = 15, face = "bold")) +
  theme(title = element_text(size = 18, face = "bold")) +
  guides(fill=FALSE) +
  labs(y = "Total mapped reads") +
  scale_y_continuous(labels = scales::percent, limits=c(0,1), expand = c(0, 0)) +
  theme(axis.text.y  = element_text(size = 14, face = "bold"))
Total_plot
ggsave("Total_plot.pdf", plot = Total_plot, width = 25, height = 20, unit = "cm")
ggsave("Total_plot.png", plot = Total_plot, width = 25, height = 20, unit = "cm")   

#########################
# Properly Mapped Reads #
#########################

Properly_plot = ggplot(df_Data,aes(x = Accessions,  y = Properly_mapped, fill = Accessions)) +
  geom_col(position = position_dodge2(width = 0.9, preserve = "single")) + 
  scale_fill_manual(values=c("#E69F00", "#56B4E9", "#009E73", "#0072B2", "#D55E00", "#CC79A7")) +
  theme_bw() + ggtitle("Percentage of total mapped reads") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 26)) +
  theme(axis.text.x = element_text(size = 15, face = "bold")) +
  theme(title = element_text(size = 18, face = "bold")) +
  guides(fill=FALSE) +
  labs(y = "Total mapped reads") +
  scale_y_continuous(labels = scales::percent, limits=c(0,1), expand = c(0, 0)) +
  theme(axis.text.y  = element_text(size = 14, face = "bold"))
Properly_plot
ggsave("Properly_plot.pdf", plot = Properly_plot, width = 25, height = 20, unit = "cm")
ggsave("Properly_plot.png", plot = Properly_plot, width = 25, height = 20, unit = "cm")
