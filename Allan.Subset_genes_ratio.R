setwd("Z:/Work/NorfabShare")
getwd()
library("data.table", lib.loc="\\\\uni.au.dk/Users/AU338462/Documents/R/win-library/3.4")
Ta_TMM_All_assemblies = read.table(file = "Allan.RSEM.isoform.TMM.EXPR.matrix", sep = '' )
Df_TMM_All_assemblies = as.data.frame(Ta_TMM_All_assemblies)
Re_TMM_All_assemblies = Df_TMM_All_assemblies[,c(2,4,6,8,10,18,1,11,13,15,17,20,3,5,7,9,19,12,14,16,21)]
names(Re_TMM_All_assemblies) <- c("Low_Core_p1C", "Low_Core_p2C", "Low_Core_p3C", "Low_Core_p4C", "Low_Core_p5C", 
                                  "Low_Core_pAC", "High_Core_p10C", "High_Core_p6C", "High_Core_p7C", "High_Core_p8C", 
                                  "High_Core_p9C", "High_Core_pBC", "Low_Testa_p1T", "Low_Testa_p2T", "Low_Testa_p3T", 
                                  "Low_Testa_p4T", "Low_Testa_pAT", "High_Testa_p6T", "High_Testa_p7T", 
                                  "High_Testa_p8T", "High_Testa_pBT")




total = Re_TMM_All_assemblies

total$Total <- paste(total$Low_Core_p1C + total$Low_Core_p2C + total$Low_Core_p3C + total$Low_Core_p4C + 
                      total$Low_Core_p5C + total$Low_Core_pAC + total$High_Core_p10C + total$High_Core_p6C +
                      total$High_Core_p7C + total$High_Core_p8C + total$High_Core_p9C + total$High_Core_pBC +
                      total$Low_Testa_p1T + total$Low_Testa_p2T + total$Low_Testa_p3T + total$Low_Testa_p4T +
                      total$Low_Testa_pAT + total$High_Testa_p6T + total$High_Testa_p7T + total$High_Testa_p8T +
                      total$High_Testa_pBT)

#write.table(total, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/Allan_expression_total.txt", sep="\t")

'''
total$Ratio_total <- paste(((total$Low_Testa_p1T + total$Low_Testa_p2T + total$Low_Testa_p3T + total$Low_Testa_p4T +
                              total$Low_Testa_pAT + total$High_Testa_p6T + total$High_Testa_p7T + total$High_Testa_p8T +
                              total$High_Testa_pBT)/9)/((total$Low_Core_p1C + total$Low_Core_p2C + total$Low_Core_p3C + 
                              total$Low_Core_p4C + total$Low_Core_p5C + total$Low_Core_pAC + total$High_Core_p10C + 
                              total$High_Core_p6C + total$High_Core_p7C + total$High_Core_p8C + total$High_Core_p9C + 
                              total$High_Core_pBC)/12))

total$Ratio_low <- paste(((total$Low_Testa_p1T + total$Low_Testa_p2T + total$Low_Testa_p3T + total$Low_Testa_p4T +
                            total$Low_Testa_pAT)/5)/((total$Low_Core_p1C + total$Low_Core_p2C + total$Low_Core_p3C + 
                            total$Low_Core_p4C + total$Low_Core_p5C + total$Low_Core_pAC)/6))

total$Ratio_high <- paste(((total$High_Testa_p6T + total$High_Testa_p7T + total$High_Testa_p8T + total$High_Testa_pBT)
                          /4)/((total$High_Core_p10C + total$High_Core_p6C + total$High_Core_p7C + 
                          total$High_Core_p8C + total$High_Core_p9C + total$High_Core_pBC)/6))


R_total <- subset(total, Ratio_total > 5)
R_total <- subset(R_total, !Ratio_total == "NaN")
R_total <- subset(R_total, Total > 1)
R_total <- R_total[order(R_total$Ratio_total, decreasing = TRUE), ]

write.table(R_total, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/R_total_Allan.txt", sep="\t")

R_low <- subset(total, Ratio_low > 5)
R_low <- subset(R_low, !Ratio_low == "NaN")
R_low <- subset(R_low, Total > 1)
R_low <- R_low[order(R_low$Ratio_low, decreasing = TRUE), ]

write.table(R_low, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/R_low_Allan.txt", sep="\t")

R_high <- subset(total, Ratio_high > 5)
R_high <- subset(R_high, !Ratio_high == "NaN")
R_high <- subset(R_high, Total > 1)
R_high <- R_high[order(R_high$Ratio_high, decreasing = TRUE), ]

write.table(R_high, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/R_high_Allan.txt", sep="\t")
'''

T1 <- subset(total, Total >= 1)
write.table(T1, "Z:/Work/NorfabShare/Alan_T1_17062019.txt", sep="\t")
RNames <- rownames(T1)
write.table(RNames, "\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/RNames.txt", sep=" ", row.names = F, col.names = F, quote = F)
