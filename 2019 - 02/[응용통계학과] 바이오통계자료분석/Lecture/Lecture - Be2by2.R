crossover <- read.csv(file = "j:/Lectures/BioStatistics/Data/longRTTR.csv", header = T)
GRP <- factor(ifelse(crossover$seq == 1, "RT", "TR"))

BEdata <- with(crossover, data.frame(sub, AUC, period, formula, GRP))
names(BEdata) <- c("SUBJ", "AUC", "PRD", "TRT", "GRP")
str(BEdata)



library(BE)
be2x2(BEdata, Columns = c("AUC"))
#test2x2(BEdata, c("AUC"))


