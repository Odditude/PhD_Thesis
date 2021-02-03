setwd("\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/SNP_Calling/")
getwd()

library(stringr)
library(dplyr)

Ta_VCF = read.table(file = "faba_HIM_18072018.filtered.20180906.vcf", sep = '')
colnames(Ta_VCF) <- c("CHROM","POS","ID","REF","ALT","QUAL","FILTER","INFO","FORMAT","Hedin","ILB938","Melodie")
Df_VCF = as.data.frame(Ta_VCF)

#########
# Hedin #
#########
Df_VCF_Pass <- Df_VCF %>%
  filter(str_detect(FILTER, "PASS"))

Hedin00 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "0/0"))

Hedin01 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "0/1"))

Hedin02 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "0/2"))

Hedin03 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "0/3"))

Hedin10 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "1/0"))

Hedin11 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "1/1"))

Hedin12 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "1/2"))

Hedin13 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "1/3"))

Hedin22 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "2/2"))

HedinMiss1 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "./.:0,0,0"))
HedinMiss2 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "./.:0,0,0,0,0,0"))
HedinMiss3 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "./.:0,0,0,0,0,0,0,0,0,0"))

##########
# ILB938 #
##########
ILB00 <- Df_VCF_Pass %>%
  filter(str_detect(ILB938, "0/0"))

ILB01 <- Df_VCF_Pass %>%
  filter(str_detect(ILB938, "0/1"))

ILB02 <- Df_VCF_Pass %>%
  filter(str_detect(ILB938, "0/2"))

ILB10 <- Df_VCF_Pass %>%
  filter(str_detect(ILB938, "1/0"))

ILB11 <- Df_VCF_Pass %>%
  filter(str_detect(ILB938, "1/1"))

ILBMiss1 <- Df_VCF_Pass %>%
  filter(str_detect(ILB938, "./.:0,0,0"))
ILBMiss2 <- Df_VCF_Pass %>%
  filter(str_detect(ILB938, "./.:0,0,0,0,0,0"))
ILBMiss3 <- Df_VCF_Pass %>%
  filter(str_detect(ILB938, "./.:0,0,0,0,0,0,0,0,0,0"))

###########
# Melodie #
###########
Melodie00 <- Df_VCF_Pass %>%
  filter(str_detect(Melodie, "0/0"))

Melodie01 <- Df_VCF_Pass %>%
  filter(str_detect(Melodie, "0/1"))

Melodie02 <- Df_VCF_Pass %>%
  filter(str_detect(Melodie, "0/2"))

Melodie10 <- Df_VCF_Pass %>%
  filter(str_detect(Melodie, "1/0"))

Melodie11 <- Df_VCF_Pass %>%
  filter(str_detect(Melodie, "1/1"))

MelodieMiss1 <- Df_VCF_Pass %>%
  filter(str_detect(Melodie, "./.:0,0,0"))
MelodieMiss2 <- Df_VCF_Pass %>%
  filter(str_detect(Melodie, "./.:0,0,0,0,0,0"))
MelodieMiss3 <- Df_VCF_Pass %>%
  filter(str_detect(Melodie, "./.:0,0,0,0,0,0,0,0,0,0"))

####################
# Table Generation #
####################

c(nrow(Hedin00), nrow(Hedin01)+nrow(Hedin10), nrow(Hedin11), nrow(HedinMiss))
c(nrow(ILB00), nrow(ILB01)+nrow(ILB10), nrow(ILB11), nrow(ILBMiss))
c(nrow(Melodie00), nrow(Melodie01)+nrow(Melodie10), nrow(Melodie11), nrow(MelodieMiss))

c(nrow(Hedin00)+nrow(Hedin01)+nrow(Hedin02)+nrow(Hedin10)+nrow(Hedin11)+nrow(Hedin12)+nrow(Hedin13)+nrow(Hedin22)+nrow(HedinMiss1)+nrow(HedinMiss2)+nrow(HedinMiss3))
c(nrow(ILB00)+nrow(ILB01)+nrow(ILB02)+nrow(ILB10)+nrow(ILB11)+nrow(ILBMiss1)+nrow(ILBMiss2)+nrow(ILBMiss3))
c(nrow(Melodie00)+nrow(Melodie01)+nrow(Melodie02)+nrow(Melodie10)+nrow(Melodie11)+nrow(MelodieMiss1)+nrow(MelodieMiss2)+nrow(MelodieMiss3))



#############
# How many? #
#############
Df_CHROM <- select(Df_VCF_Pass, CHROM)
Snowflake <- unique(Df_CHROM)
#42234 locus
Df_HeChrom <- select(Hedin00, CHROM)
HeSnowflake <- unique(Df_HeChrom)
#32244 locus
HeTest <- table(Df_HeChrom)

library(plyr)
HeCounts <- count(Df_HeChrom, 'CHROM')
hist(HeCounts$freq, breaks = 30, main = 'Frequence of SNPs in each Locus', xlab = 'Frequencey')


#####Hedin00
#####271794 SNP calls total
#####
HILB00 <- Hedin00 %>%
  filter(str_detect(ILB938, "0/0"))         #81477
HMel00 <- Hedin00 %>%
  filter(str_detect(Melodie, "0/0"))        #77679
HILB01 <- Hedin00 %>%
  filter(str_detect(ILB938, "0/1"))         #61517
HMel01 <- Hedin00 %>%
  filter(str_detect(Melodie, "0/1"))        #92024
HILB11 <- Hedin00 %>%
  filter(str_detect(ILB938, "1/1"))         #109167
HMel11 <- Hedin00 %>%
  filter(str_detect(Melodie, "1/1"))        #89061
HILBMiss <- Hedin00 %>%
  filter(str_detect(ILB938, "./.:0,0,0"))   #18622
HMelMiss <- Hedin00 %>%
  filter(str_detect(Melodie, "./.:0,0,0"))  #11722


#####Hedin01
#####437683 SNP calls total
H01ILB00 <- Hedin01 %>%
  filter(str_detect(ILB938, "0/0"))         #110996
H01Mel00 <- Hedin01 %>%
  filter(str_detect(Melodie, "0/0"))        #114235
H01ILB01 <- Hedin01 %>%
  filter(str_detect(ILB938, "0/1"))         #72602
H01Mel01 <- Hedin01 %>%
  filter(str_detect(Melodie, "0/1"))        #92191
H01ILB11 <- Hedin01 %>%
  filter(str_detect(ILB938, "1/1"))         #44199
H01Mel11 <- Hedin01 %>%
  filter(str_detect(Melodie, "1/1"))        #43691
H01ILBMiss <- Hedin01 %>%
  filter(str_detect(ILB938, "./.:0,0,0"))   #208696
H01MelMiss <- Hedin01 %>%
  filter(str_detect(Melodie, "./.:0,0,0"))  #186133

#####Hedin11
#####28300 SNP calls total
H11ILB00 <- Hedin11 %>%
  filter(str_detect(ILB938, "0/0"))         #2151
H11Mel00 <- Hedin11 %>%
  filter(str_detect(Melodie, "0/0"))        #2146
H11ILB01 <- Hedin11 %>%
  filter(str_detect(ILB938, "0/1"))         #2437
H11Mel01 <- Hedin11 %>%
  filter(str_detect(Melodie, "0/1"))        #2904
H11ILB11 <- Hedin11 %>%
  filter(str_detect(ILB938, "1/1"))         #10489
H11Mel11 <- Hedin11 %>%
  filter(str_detect(Melodie, "1/1"))        #11575
H11ILBMiss <- Hedin11 %>%
  filter(str_detect(ILB938, "./.:0,0,0"))   #13107
H11MelMiss <- Hedin11 %>%
  filter(str_detect(Melodie, "./.:0,0,0"))  #11559

Ta_He00 <- rbind(Hedin00 = as.numeric(c("81477", "77679", "61517", "92024", "109167", "89061", "18622", "11722", "271794")),
      Hedin01 = as.numeric(c("110996", "114235", "72602", "92191", "44199", "43691", "208696", "186133", "437683")),
      Hedin11 = as.numeric(c("2151", "2146", "2437", "2904", "10489", "11575", "13107", "11559", "28300")))
colnames(Ta_He00) <- c("ILB00","Mel00","ILB01","Mel01","ILB11","Mel11","ILBMiss","MelMiss","Total")

################
# Write Tables #
################
write.table(Df_VCF_Pass, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/SNP_Calling/Donald_draft1/VCF_Pass.txt", sep="\t")
write.table(Hedin00, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/SNP_Calling/Donald_draft1/Hedin00.txt", sep="\t")
write.table(Ta_He00, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/SNP_Calling/Donald_draft1/Summary.txt", sep="\t")
write.table(HeCounts, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/SNP_Calling/Donald_draft1/FrequencyCounts.txt", sep="\t")
