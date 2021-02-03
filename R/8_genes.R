# Library
library(viridis)
library(ggplot2)
library(tidyr)
library(tibble)
library(hrbrthemes)
library(dplyr)
vc1 = as.data.frame(read.table("C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/VC1/5_genes_heatmap.txt", header = TRUE))
vc1_log = vc1
vc1_log[,3] <- log(vc1_log[,3],2)

textcol <- "grey40"
PlotLog <- ggplot(vc1_log, aes(Tissue, Gene, fill= Expression)) + 
  geom_tile() +
  geom_tile(colour="white",size=0.25)+
  scale_y_discrete(expand=c(0,0))+
  #guides(fill=guide_legend(title="Log2 expression"))+
  labs(x="",y="", title="Gene expression in vc interval")+
  scale_x_discrete(expand=c(0,0)) +
  scale_fill_viridis(discrete=FALSE, name="Log2 \nExpression") +
  theme_grey(base_size=10)+
  #theme_ipsum() +
  theme(legend.position="right",legend.direction="vertical",
        legend.title=element_text(colour=textcol),
        legend.margin=margin(grid::unit(0,"cm")),
        legend.text=element_text(colour=textcol,size=7,face="bold"),
        legend.key.height=grid::unit(0.8,"cm"),
        legend.key.width=grid::unit(0.2,"cm"),
        axis.text.x=element_text(size=10,colour=textcol, angle=90, vjust=0.2, hjust=1),
        axis.text.y=element_text(vjust=0.2,colour=textcol, size=10),
        axis.ticks=element_line(size=0.4),
        plot.background=element_blank(),
        panel.border=element_blank(),
        plot.margin=margin(0.7,0.4,0.1,0.2,"cm"),
        plot.title=element_text(colour=textcol,hjust=0,size=14,face="bold")) + coord_fixed()
PlotLog

path_of_file="C:/Users/au338462/OneDrive/Dokumenter/PhD/Articles/VC1/"

ggsave(PlotLog,filename="5_genes_heatmap_square.png",height=7.67,width=8.06,units="in", path=path_of_file, dpi=300)

