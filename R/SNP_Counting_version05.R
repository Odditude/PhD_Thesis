setwd("Z:/Work/NorfabShare/SNP_Calling/Donald_draft2/")
getwd()

library(stringr)
library(dplyr)

Ta_VCF = read.table(file = "faba_HIM_18072018.12H.filtered.20190305.vcf", sep = '')
colnames(Ta_VCF) <- c("CHROM","POS","ID","REF","ALT","QUAL","FILTER","INFO","FORMAT","Hedin","ILB938","Melodie", "A159b", "A2378", "Hiverna")
Df_VCF = as.data.frame(Ta_VCF)

#########
# Hedin #
#########
Df_VCF_Pass <- Df_VCF %>%
  filter(str_detect(FILTER, "PASS"))

Hedin00 <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "0/0"))



#####
# Experiment
#####

HedinTest <- Df_VCF_Pass %>%
  filter(str_detect(Hedin, "0/0"))
ILB938Test <- HedinTest %>%
  filter(str_detect(ILB938, paste(c("0/0","1/1","2/2","3/3","4/4"), collapse = '|')))
MelodieTest <- ILB938Test %>%
  filter(str_detect(Melodie, paste(c("0/0","1/1","2/2","3/3","4/4"), collapse = '|')))
HivernaTest <- MelodieTest %>%
  filter(str_detect(Hiverna, paste(c("0/0","1/1","2/2","3/3","4/4"), collapse = '|')))
A159bTest <- HivernaTest %>%
  filter(!str_detect(A159b, "./.:0,0,0"))
A2378Test <- A159bTest %>%
  filter(!str_detect(A2378, "./.:0,0,0"))



#############
# How many? #
#############
Df_CHROM <- select(A2378Test, CHROM)
Snowflake <- unique(Df_CHROM)
#27616


library(dplyr)
HeCounts <- count(Df_CHROM, CHROM)
hist(HeCounts$n, breaks = 30, main = 'Frequence of SNPs in each Locus', xlab = 'Frequencey')

'''

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
'''
################
# Write Tables #
################
write.table(Df_VCF_Pass, "Z:/Work/NorfabShare/SNP_Calling/Donald_draft2/VCF_Pass.txt", sep="\t")
write.table(A2378Test, "Z:/Work/NorfabShare/SNP_Calling/Donald_draft2/Hedin00Filter.txt", sep="\t")
#write.table(Ta_He00, "Z:/Work/NorfabShare/SNP_Calling/Donald_draft2/Summary.txt", sep="\t")
write.table(HeCounts, "Z:/Work/NorfabShare/SNP_Calling/Donald_draft2/FrequencyCounts.txt", sep="\t")
