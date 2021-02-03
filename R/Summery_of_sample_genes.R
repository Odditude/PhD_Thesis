setwd("\\\\uni.au.dk/Users/au338462/Desktop/NorfabShare/")
getwd()
VPC = read.table(file = "VicinePathwayCandidates_20171214.txt", sep = '' )
VPC = as.data.frame(VPC)
VPC = t(VPC)
VPC_1 = summarySE(data = VPC, evgLocus_1236937, groupvars = a.vector, na.rm = FALSE, conf.interval = 0.95, .drop = TRUE)


Tissue <- c("flower", "flower", "flower", "stem", "stem", "stem", "leaf (young)", "leaf (young)", "leaf (young)", 
  "leaf (mature)", "leaf (mature)", "leaf (mature)", "pods (expansion)", "pods (expansion)", "pods (expansion)",
  "seeds (expansion)", "seeds (expansion)", "seeds (expansion)", "pods (filling)", "pods (filling)", "pods (filling)",
  "seeds (filling - embryo)", "seeds (filling - embryo)", "seeds (filling - embryo)", 
  "mixture of all tissue", "mixture of all tissue")

test <- c("flower", "flower", "flower", "stem", "stem", "stem", "leaf(young)", "leaf(young)", "leaf(young)", 
          "leaf(mature)", "leaf(mature)", "leaf(mature)", "pods(expansion)", "pods(expansion)", "pods(expansion)",
          "seeds(expansion)", "seeds(expansion)", "seeds(expansion)", "pods(filling)", "pods(filling)", "pods(filling)",
          "seeds(filling-embryo)", "seeds(filling-embryo)", "seeds(filling-embryo)", "mix", "mix")

flower <- c("flower", "flower", "flower")
stem <- c("stem", "stem", "stem")
leaf_young <- c("leaf(young)", "leaf(young)", "leaf(young)")
leaf_mature <- c("leaf(mature)", "leaf(mature)", "leaf(mature)")
pods_expansion <- c("pods(expansion)", "pods(expansion)", "pods(expansion)")
seeds_expansion <- c("seeds(expansion)", "seeds(expansion)", "seeds(expansion)")
pods_filling <- c("pods(filling)", "pods(filling)", "pods(filling)")
seeds_filling_embryo <- c("seeds(filling-embryo)", "seeds(filling-embryo)", "seeds(filling-embryo)")
mix <- c("mix", "mix")

tissue = list(flower, stem, leaf_young, leaf_mature, pods_expansion, seeds_expansion, pods_filling, seeds_filling_embryo, mix)


Tissue = tissue
VPC <- cbind(VPC, Tissue)
View(VPC)
tissue = Tissue

VPC_1 = summarySE(data = VPC, measurevar = "evgLocus_1236937", groupvars = ("Tissue"), na.rm = FALSE, conf.interval = 0.95, .drop = TRUE)
a.vector = c("flower", "stem", "leaf(young)", "leaf(mature)", "pods(expansion)", "seeds(expansion)", 
             "pods(filling)", "seeds(filling-embryo)", "mix")
