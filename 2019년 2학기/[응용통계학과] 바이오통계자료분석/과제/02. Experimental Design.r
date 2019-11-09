# 데이터 입력
abrasion = c(17,14,12,13,14,14,12,11,13,13,10,11,13,8,9,9)
brand=as.factor(rep(c("A", "B", "C", "D"),4))
car = as.factor(rep(1:4, each=4))
tire = data.frame(abrasion, brand, car)

# Boxplot
boxplot(abrasion ~ brand, data=tire)

# Anova
abrasion.aov=aov(abrasion~car+brand,data=tire)
summary(abrasion.aov)

# glm
abrasion.glm=glm(abrasion~car+brand,data=tire)
summary(abrasion.glm)


##########################################################################3

stay <-c(20,25,24,28, 25,30,28,31, 22,29,24,26, 27,28,25,29, 21,30,30,32,
         30,30,39,40, 45,29,42,45, 30,31,36,50, 35,30,42,45, 36,30,40,60,
         31,32,41,42, 30,35,45,50, 40,30,40,40, 35,40,40,55, 30,30,35,45,
         20,23,24,29, 21,25,25,30, 20,28,30,28, 20,30,26,27, 19,31,23,30)
TypePatient <- factor(rep(c("Cardiac","Cancer","C.V.A.","Tubercu"), each = 20))
AgeGroup <- factor(rep(rep(1:4, times = 5), times = 4)) # rep(1:4, times = 20)
NurseStay <- data.frame(TypePatient, AgeGroup, stay)
stay.aov = aov(stay ~ TypePatient*AgeGroup, data=NurseStay)
summary(stay.aov)
