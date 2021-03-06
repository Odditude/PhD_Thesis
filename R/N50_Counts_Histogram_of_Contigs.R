setwd("\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/")
getwd()
N1 = read.table(file = "20171012_condI_contigLenghts.txt", sep = '' )
N1 = unlist(N1)
#N2 = read.table(file = "20170912_condE_v2_contigLenghts.txt", sep = '' )
#N2 = unlist(N2)

NameOfRunN1 <- "Cond I Trinity w/ Pacbio"
#NameOfRunN2 <- "Cond E Trinity w/ Pacbio"

N1 = as.data.frame.matrix(N1)
SortedN1 <- sort(N1$V1, decreasing = TRUE)
View(SortedN1)

#N2 = as.data.frame.matrix(N2)
#SortedN2 <- sort(N2$V1, decreasing = TRUE)
#View(SortedN2)

###########################################################################################
## Compute N50 values for Assembly Results and Plot their Cumulative Length Distribution ##
###########################################################################################
## Author: Thomas Girke
## Last update: January 28, 2010
## Taken from https://gist.github.com/jlhg/4642041
## Utilities: Compute N50 and plot cumulative length distribution.
## More details can be found here: http://manuals.bioinformatics.ucr.edu/home/ht-seq#TOC-Analyzing-Assembly-Results

## Overview:
## The N50 is a weighted median statistic such that 50% of the entire assembly 
## is contained in contigs equal to or larger than this value. It can be calculated 
## as follows: store the lengths of all contigs in a vector L of positive integers. 
## Create a vector Lr where each integer is repeated as many times as defined by 
## the sum its values in L. After this the N50 value is computed as the median of Lr. 
## For example: if L = c(2, 2, 3, 3, 5, 7), then Lr consists of four 2's, six 3's, 
## five 5's, and seven 7's; the N50 of L is the median of Lr, which is 5. 
## In R the N50 according to this definition can be computed like this:
##      L <- c(2, 2, 3, 3, 5, 7)
##      Lr <- unlist(tapply(L, L, function(x) rep(x[1], sum(x))))
##      median(Lr)
## 
## With very large contig sizes the above implementation for computing the N50
## value can become inefficient. A much more efficient approach is to sort L
## decreasingly, compute for it the cumulative sum and then identify the length
## value for which the cumulative sum covers at least 50% of the combined length 
## of all contigs or the length of a known target/reference sequence. Note, 
## comparisons among N50 values from different assemblies are only meaningful 
## when using for their calculation the same combined length value. Thus, a known 
## target length value can be often a good solution for comparing assembly results.

## The following contigStats function calculates the N50 values according to the more 
## efficient second method. In addition, it creates a distribution plot of the 
## cumulative contig lengths, which is a very effective way for comparing assembly 
## results. 
contigStats <- function(N=N, 
                        reflength, 
                        style="base", 
                        pch=20, 
                        cex=1, 
                        xlab="Percentage of Assembly Covered by Contigs of Size >=Y", 
                        ylab="Contig Size [bp]", 
                        main="Cumulative Length of Contigs", 
                        sizetitle=14, 
                        sizex=12, 
                        sizey=12, 
                        sizelegend=9, 
                        poslegend="topright", 
                        xlim, 
                        ylim) {
  ## Compute cumulative length vectors for contig sets
  Nl <- lapply(names(N), function(x) rev(sort(N[[x]]))); names(Nl) <- names(N)
  Nlcum <- lapply(names(Nl), function(x) cumsum(Nl[[x]])); names(Nlcum) <- names(Nl)
  
  ## Compute N50 values
  N50 <- sapply(seq(along=N), function(x) Nl[[x]][which(Nlcum[[x]] - reflength[x]/2 >= 0)[1]]); names(N50) <- names(N)
  
  ## Return only data (no plot)
  if(style=="data") {
    N75 <- sapply(seq(along=N), function(x) Nl[[x]][which(Nlcum[[x]] - reflength[x] * 0.75 >= 0)[1]]); names(N50) <- names(N)
    N25 <- sapply(seq(along=N), function(x) Nl[[x]][which(Nlcum[[x]] - reflength[x] * 0.25 >= 0)[1]]); names(N50) <- names(N)
    stats <- cbind(N25, N50, N75, Longest=sapply(N, max), Mean=sapply(N, mean), Median=sapply(N, median), Shortest=sapply(N, min), N_Contigs=sapply(N, length))
    return(c(Nlcum, Contig_Stats=list(stats)))
  }
  ## Plot cumulative contig length with base graphics
  if(style=="base") {
    if(missing(xlim)) xlim <- c(0, 100)
    if(missing(ylim)) ylim <- c(0, max(unlist(N))) 
    split.screen(c(1,1))
    for(i in seq(along=Nl)) {
      if(i==1) {
        plot(Nlcum[[i]]/reflength[[i]] * 100, Nl[[i]], col=i, pch=pch, cex=cex, xlim=xlim, ylim=ylim, xlab=xlab, ylab=ylab, main=main)  
      } 
      screen(1, new=FALSE)
      plot(Nlcum[[i]]/reflength[[i]] * 100, Nl[[i]], col=i, pch=pch, cex=cex, xlim=xlim, ylim=ylim, xaxt="n", yaxt="n", ylab="", xlab="", main="", bty="n")  
    }
    legend(poslegend, legend=paste(names(N50), ": N50 = ", N50, sep=""), cex=1.2, bty="n", pch=15, pt.cex=1.8, col=seq(along=Nl)) 
    close.screen(all=TRUE)
  } 
  ## Plot cumulative contig length with ggplot2
  ## Note: ggplot2 plotting options can be looked up with theme_get()
  if(style=="ggplot2") {
    require("ggplot2")
    plotdf <- data.frame(Samples=rep(names(Nlcum), sapply(Nlcum, length)), length=unlist(Nl), perc=unlist(lapply(names(Nlcum), function(x) Nlcum[[x]]/reflength[[x]]*100)))
    counts <- table(plotdf[,1]); counts <- counts[names(N50)]
    N50rep <- paste(plotdf[,1], ": N50=", unlist(lapply(as.character(unique(plotdf[,1])), function(x) rep(N50[x], counts[names(N50[x])]))), sep="")
    plotdf[,1] <- N50rep
    ggplot(plotdf, aes(perc, length, color=Samples)) + 
      geom_point() + 
      scale_x_continuous(xlab) + 
      scale_y_continuous(ylab) + 
      labs(title = main) +                                                                                                                         
      labs(plot.title = element_text(size = sizetitle)) +                                                                                          
      labs(axis.title.x = element_text(size = sizex)) +                                                                                            
      labs(axis.title.y = element_text(size = sizey, angle = 90)) +                                                                                
      labs(legend.text = element_text(size = sizelegend)) +                                                                                        
      labs(legend.title = element_text(size = 0))  
  }
}
## Usage of contigStats function
## Test sample of simulated contig length values provided in list
##N1 <- sample(1:500, 100)
##N2 <- sample(1:480, 50)
N <- list(N1=N1) # , N2=N2 

## Run contigStats function
reflength <- sapply(N, sum)
N50 <- contigStats(N=N, reflength=reflength, pch=20, xlab="Percentage of Assembly Covered by Contigs of Size >=Y", ylab="Contig Size", main="Cumulative Plot of N Statistic") 

## Create histogram for N1
h = hist(N1,
     main=paste("Histogram of contigs lenghts", NameOfRunN1) ,
     xlab="Lenghts" ,
     col="cadetblue1"
     )
d <- density(N1)
lines(x = d$x, y = d$y * length(N1) * diff(h$breaks)[1], col = "lightsteelblue4", lwd = 2)


## Create histogram for N2
#h = hist(N2,
#         main=paste("Histogram of contigs lenghts", NameOfRunN2) ,
#         xlab="Lenghts" ,
#         col="cadetblue1"
#)
#d <- density(N1)
#lines(x = d$x, y = d$y * length(N1) * diff(h$breaks)[1], col = "lightsteelblue4", lwd = 2)
###


## Number of contigs
ContigLenght <- length(N1)
paste(NameOfRunN1,":", "Lenght of Contigs =", ContigLenght)

### Number of contigs
#ContigLenght <- length(N2)
#paste(NameOfRunN2,":", "Lenght of Contigs =", ContigLenght)

