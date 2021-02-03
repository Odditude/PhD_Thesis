setwd("/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/
      20170917_Trinity_rep_Pacbio_CondA_I/RSEM/All_Assemblies_AI.okay.cds/Sample_Name/")
getwd()
library("data.table")
Ta_TMM_All_assemblies = read.table(file = "RSEM.Named.TMM.EXPR.matrix", sep = '' )
Df_TMM_All_assemblies = as.data.frame(Ta_TMM_All_assemblies)
Df_TMM_All_assemblies = t(Df_TMM_All_assemblies)

Tissue <- c("Flower", "Flower", "Flower", "Stem", "Stem", "Stem", "Leaf (young)", "Leaf (young)", "Leaf (young)", 
            "Leaf (mature)", "Leaf (mature)", "Leaf (mature)", "Pods (expansion)", "Pods (expansion)", "Pods (expansion)",
            "Seeds (expansion)", "Seeds (expansion)", "Seeds (expansion)", "Pods (filling)", "Pods (filling)", 
            "Pods (filling)","Seeds (filling - embryo)", "Seeds (filling - embryo)", "Seeds (filling - embryo)", 
            "Mixture of all tissue", "Mixture of all tissue")

Df_TMM_All_assemblies <- cbind(Tissue, Df_TMM_All_assemblies)


# Test_subset1 <- Df_TMM_All_assemblies[,c(1:7)] put Test_sunset1 instead of Df_TMM_All_assemblies when running the test. 
# rownames(Test_subset1) <- NULL


SubsetTest1 <- Df_TMM_All_assemblies[c(1:3),]
SubsetTest1 <- SubsetTest1[,c(2:228272)]
SubsetTest1 <- data.table(SubsetTest1)
b <- data.matrix(SubsetTest1, rownames.force = NA)
b <- data.table(b)
b <- b[,lapply(.SD, mean, na.nr = TRUE)]
b <- as.data.frame(b)
tissue <- c("Flower")
b <- cbind(tissue, b)
total <- b


SubsetTest1 <- Df_TMM_All_assemblies[c(4:6),]
SubsetTest1 <- SubsetTest1[,c(2:7)]
SubsetTest1 <- data.table(SubsetTest1)
b <- data.matrix(SubsetTest1, rownames.force = NA)
b <- data.table(b)
b <- b[,lapply(.SD, mean, na.nr = TRUE)]
b <- as.data.frame(b)
tissue <- c("Stem")
b <- cbind(tissue, b)
total <- rbind(total, b)


SubsetTest1 <- Df_TMM_All_assemblies[c(7:9),]
SubsetTest1 <- SubsetTest1[,c(2:7)]
SubsetTest1 <- data.table(SubsetTest1)
b <- data.matrix(SubsetTest1, rownames.force = NA)
b <- data.table(b)
b <- b[,lapply(.SD, mean, na.nr = TRUE)]
b <- as.data.frame(b)
tissue <- c("Leaf_(young)")
b <- cbind(tissue, b)
total <- rbind(total, b)


SubsetTest1 <- Df_TMM_All_assemblies[c(10:12),]
SubsetTest1 <- SubsetTest1[,c(2:7)]
SubsetTest1 <- data.table(SubsetTest1)
b <- data.matrix(SubsetTest1, rownames.force = NA)
b <- data.table(b)
b <- b[,lapply(.SD, mean, na.nr = TRUE)]
b <- as.data.frame(b)
tissue <- c("Leaf_(mature)")
b <- cbind(tissue, b)
total <- rbind(total, b)


SubsetTest1 <- Df_TMM_All_assemblies[c(13:15),]
SubsetTest1 <- SubsetTest1[,c(2:7)]
SubsetTest1 <- data.table(SubsetTest1)
b <- data.matrix(SubsetTest1, rownames.force = NA)
b <- data.table(b)
b <- b[,lapply(.SD, mean, na.nr = TRUE)]
b <- as.data.frame(b)
tissue <- c("Pods_(expansion)")
b <- cbind(tissue, b)
total <- rbind(total, b)


SubsetTest1 <- Df_TMM_All_assemblies[c(16:18),]
SubsetTest1 <- SubsetTest1[,c(2:7)]
SubsetTest1 <- data.table(SubsetTest1)
b <- data.matrix(SubsetTest1, rownames.force = NA)
b <- data.table(b)
b <- b[,lapply(.SD, mean, na.nr = TRUE)]
b <- as.data.frame(b)
tissue <- c("Seeds_(expansion)")
b <- cbind(tissue, b)
total <- rbind(total, b)


SubsetTest1 <- Df_TMM_All_assemblies[c(19:21),]
SubsetTest1 <- SubsetTest1[,c(2:7)]
SubsetTest1 <- data.table(SubsetTest1)
b <- data.matrix(SubsetTest1, rownames.force = NA)
b <- data.table(b)
b <- b[,lapply(.SD, mean, na.nr = TRUE)]
b <- as.data.frame(b)
tissue <- c("Pods_(filling)")
b <- cbind(tissue, b)
total <- rbind(total, b)


SubsetTest1 <- Df_TMM_All_assemblies[c(22:24),]
SubsetTest1 <- SubsetTest1[,c(2:7)]
SubsetTest1 <- data.table(SubsetTest1)
b <- data.matrix(SubsetTest1, rownames.force = NA)
b <- data.table(b)
b <- b[,lapply(.SD, mean, na.nr = TRUE)]
b <- as.data.frame(b)
tissue <- c("Seeds_(filling - embryo)")
b <- cbind(tissue, b)
total <- rbind(total, b)


SubsetTest1 <- Df_TMM_All_assemblies[c(25:26),]
SubsetTest1 <- SubsetTest1[,c(2:7)]
SubsetTest1 <- data.table(SubsetTest1)
b <- data.matrix(SubsetTest1, rownames.force = NA)
b <- data.table(b)
b <- b[,lapply(.SD, mean, na.nr = TRUE)]
b <- as.data.frame(b)
tissue <- c("Mixture_of_all_tissue")
b <- cbind(tissue, b)
total <- rbind(total, b)

total = t(total)
colnames(total) = total[1, ]
total <- total[-c(1), ]


total <- as.data.frame(total)

total$Ratio_1 <- paste(as.numeric(as.character(total$'Seeds_(expansion)'))
                       /as.numeric(as.character(total$'Seeds_(filling - embryo)')))
total$Ratio_2 <- paste((as.numeric(as.character(total$'Seeds_(expansion)')))/
                         (((as.numeric(as.character(total$Flower))) + (as.numeric(as.character(total$Stem))) + (as.numeric(as.character(total$'Leaf_(young)')))
                          + (as.numeric(as.character(total$'Leaf_(mature)'))) + (as.numeric(as.character(total$'Pods_(expansion)'))) + (as.numeric(as.character(total$'Pods_(filling)')))
                          + (as.numeric(as.character(total$'Seeds_(filling - embryo)'))))/7))


write.table(total, "/faststorage/project/norfab/20170615_RNAseq/C101HW17040828/raw_data/trinity_out_play/
              20170917_Trinity_rep_Pacbio_CondA_I/RSEM/All_Assemblies_AI.okay.cds/Sample_Name/total.txt", sep="\t")
