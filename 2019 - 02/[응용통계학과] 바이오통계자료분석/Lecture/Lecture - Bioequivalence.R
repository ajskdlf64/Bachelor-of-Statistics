bioeq = read.csv("./drug13a.csv", header=T, skip = 7)
str(bioeq)

boxplot(CMAX ~ TRT, data=bioeq)

attach(bioeq) 
plot(density(CMAX[TRT==levels(TRT)[1]]), main = "Densities of CMAX (TRT A: solid, TRT B: dotted)")
lines(density(CMAX[TRT==levels(TRT)[2]]), lty = 2)

logCMAX = log(CMAX)
boxplot(logCMAX ~ TRT)
plot(density(logCMAX[TRT==levels(TRT)[1]]), main = "Densities of log(CMAX) (TRT A: solid, TRT B: dotted)")
lines(density(logCMAX[TRT==levels(TRT)[2]]), lty = 2)

var.test(logCMAX ~ TRT)
TOST = t.test(logCMAX ~ TRT, conf.level = 0.90, var.equal = T)
TOST

TOST$conf.int

bound = log(1.25) * c(-1,1)


( bound[1] < TOST$conf.int[1]) & ( bound[2] > TOST$conf.int[2])  #  TOST test 


library(equivalence)
tost(logCMAX[TRT == levels(TRT)[1]], logCMAX[TRT == levels(TRT)[2]], conf.level = 0.95, var.equal = T, epsilon = log(1.25))


# RTTR
cross <- read.csv("../RTTR.csv", header = T, row.names = NULL)
data1 <- data2 <- cross[,1:2]
data1$AUC <- cross[,3]
data1$period <- 1
data1$formula <- ifelse(data1$seq == 1, "R", "T")
data2$AUC <- cross[,4]
data2$period <- 2
data2$formula <- ifelse(data2$seq == 1, "T", "R")
crossover <- merge(data1, data2, all = T)
crossover$sub <- factor(crossover$sub)
crossover$seq <- factor(crossover$seq)
crossover$period <- factor(crossover$period)
crossover$formula <- factor(crossover$formula)
str(crossover)

BEdata <- with(crossover, data.frame(sub, period, formula, log(AUC)))
names(BEdata) <- c("SUBJ", "PRD", "TRT", "AUC")
BEdata$GRP <- ifelse(crossover$seq == 1, "RT", "TR")
str(BEdata)

library(BE)
be2x2(BEdata, Columns = c("AUC"))
test2x2(BEdata, c("AUC"))


library(lme4)
equ <- lmer(log(AUC) ~ formula + period + seq + (1 | sub)%in%seq , REML = F, data = crossover)
summary(equ)
anova(equ)
confint(equ, method="profile", parm = c("formulaT"), level = 0.90)
confint(equ, method="Wald", parm = c("formulaT"), level = 0.90)





