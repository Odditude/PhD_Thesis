setwd("Z:/Work/NorfabShare/Transcriptomics/Clusters")
#getwd()

library(dplyr)
library("formattable")

clusters = read.table("Cluster_Only_M02.txt")
df_clusters = as.data.frame(table(clusters))
df_clusters_count = as.data.frame(table(df_clusters$Freq))

df_clusters_count$Var1 = as.numeric(as.character(df_clusters_count$Var1))


filtered_cluster = df_clusters %>% filter(Freq == 1)

write.table(filtered_cluster$clusters, file = "1_Member_Clusters_M02.txt", row.names=F, col.names=F, quote=F)


