# 단일 모집단 비율 검정

# 표본 데이터
n = 600    # 표본 크기
x = 29     # 표본에서 사건 발생 횟수
# 비율 t-test
prop.test(x=x, n=n, p=0.0041, alternative="greater")   # 검정 결과 p-value=0.0483 으로 귀무가설을 기각!


################################################################################################################


# 단일 모집단 평균 검정
speed = scan("../Velocity/Michelson1.dat")  # 데이터 불러오기
plot(speed, type="b")  # 시계열 데이터의 그래프
abline(h=mean(speed))  # 평균선 표시

# 차분 그래프
library(astsa)
lag1.plot(speed, 1)

# Run Test
library(randtests)
runs.test(speed)        # 검정 결과 p-value=0.404 이므로 귀무가설을 채택!

# 정규성 검정
shapiro.test(speed)     # Shapiro Test
qqnorm(speed)           # QQ plot

# 실제 빛의속도와의 평균 차이 검정
t.test(speed, mu=792.458)            # p-value가 2.02e-11 로 귀무가설을 강하게 기각! 마이켈슨의 실험이 빛의 속도와 차이가 있는 것으로 나타남.

# BoxPlot
michelson1 = scan("../Velocity/Michelson1.dat")  # 데이터 불러오기
newcomb1 = scan("../Velocity/Newcomb1.dat")      # 데이터 불러오기
newcomb2 = scan("../Velocity/Newcomb2.dat")      # 데이터 불러오기
newcomb3 = scan("../Velocity/Newcomb3.dat")      # 데이터 불러오기
michelson2 = scan("../Velocity/Michelson2.dat")  # 데이터 불러오기
Velocity <- data.frame(group=c(rep("michelson1",each=length(michelson1)),
                               rep("newcomb1",each=length(newcomb1)),
                               rep("newcomb2",each=length(newcomb2)),
                               rep("newcomb3",each=length(newcomb3)),
                               rep("michelson2",each=length(michelson2))),
                       value=c(michelson1,newcomb1,newcomb2,newcomb3,michelson2))
library(tidyverse)
Velocity %>% ggplot(aes(x=group,y=value)) + 
             scale_x_discrete(limits=c("michelson1", "newcomb1", "newcomb2", "newcomb3", "michelson2")) +
             geom_boxplot()

boxplot(value ~ group, data=Velocity)


################################################################################################################


# 두 모집단에 대한 추론

# 두 비율 차이 검정
prop.test(x=c(17,11), n=c(18,18), alternative="greater")

# 약의 효과에 대한 실험험
placebo = c(0,0,0,2,4,5,13,14,14,14,13,15,17,17)
ephedra = c(0,6,7,9,11,13,16,16,16,17,18,20,21)

# 두 약의 효과에 대한 박스플랏랏
boxplot(list(placebo,ephedra),names=c("placebo","ephedra"),col="grey")

# 두 집단의 분포
plot(density(placebo),main="densities of drug, placebo", ylim=c(0,0.07))
lines(density(ephedra),lty = 2)

# 등분산성 검사
var.test(placebo, ephedra)

# 등분산성 가정 하에 평균차에 대한 검정
t.test(placebo, ephedra, var.equal = T)

# 만약, 등분산 가정에 위배된다면...?
t.test(placebo, ephedra) # default: var.equal = F


################################################################################################################


# 대응표본 평균 차이 검정
foster = c(80, 88, 75, 113, 95, 82, 97, 94, 132, 108)
biological = c(90, 91, 79, 97, 97, 82, 87, 94, 131, 115)
t.test(foster, biological, paired = TRUE)

# 위의 검정에서 차이가 없다고 나왔지만 분포를 보면 명확한 차이가 있는 것으로 나타남.
boxplot(list(foster,biological),names=c("foster","biological"))

# 대응표본 차이 검정
t.test(foster-biological)


################################################################################################################

# ANOVA CRD 

# Data
abrasion <- c(14,14,12,10,13,14,11,9,17,8,12,13,13,13,9,11)
brand <- as.factor(rep(c("A", "B", "C", "D"),4))
tire <- data.frame(abrasion, brand)

# ANOVA MODEL
abrasion.aov <- aov(abrasion ~ brand, data = tire)
summary(abrasion.aov)
abrasion.glm <- glm(abrasion ~ brand, data = tire)
summary(abrasion.glm)

# BOXPLOT
boxplot(abrasion ~ brand, data=tire)


################################################################################################################

# ANOVA RBD
abrasion = c(17,14,12,13,14,14,12,11,13,13,10,11,13,8,9,9)
brand=as.factor(rep(c("A", "B", "C", "D"),4))
car = as.factor(rep(1:4, each=4))
tire = data.frame(abrasion, brand, car)

# BOXPLOT
boxplot(abrasion ~ brand, data=tire)

# ANOVA MODEL
abrasion.aov=aov(abrasion~car+brand,data=tire)
summary(abrasion.aov)
abrasion.glm=glm(abrasion~car+brand,data=tire)
summary(abrasion.glm)


################################################################################################################


# 2-WAY ANOVA

# DATA
stay <-c(20,25,24,28, 25,30,28,31, 22,29,24,26, 27,28,25,29, 21,30,30,32,
         30,30,39,40, 45,29,42,45, 30,31,36,50, 35,30,42,45, 36,30,40,60,
         31,32,41,42, 30,35,45,50, 40,30,40,40, 35,40,40,55, 30,30,35,45,
         20,23,24,29, 21,25,25,30, 20,28,30,28, 20,30,26,27, 19,31,23,30)
TypePatient <- factor(rep(c("Cardiac","Cancer","C.V.A.","Tubercu"), each = 20))
AgeGroup <- factor(rep(rep(1:4, times = 5), times = 4)) # rep(1:4, times = 20)
NurseStay <- data.frame(TypePatient, AgeGroup, stay)

# ANOVA MODEL
stay.aov = aov(stay ~ TypePatient*AgeGroup, data=NurseStay)
summary(stay.aov)
stay.glm = glm(stay ~ TypePatient*AgeGroup, data=NurseStay)
summary(stay.glm)


################################################################################################################


# Nest ANOVA

# DATA
gunData <- c(20.2, 26.2, 23.8, 22.0, 22.6, 22.9, 23.1, 22.9, 21.8,
             24.1, 26.9, 24.9, 23.5, 24.6, 25.0, 22.9, 23.7, 23.5,
             14.2, 18.0, 12.5, 14.1, 14.0, 13.7, 14.1, 12.2, 12.7,
             16.2, 19.1, 15.4, 16.1, 18.1, 16.0, 16.1, 13.8, 15.1)
method <- factor(rep(1:2, each = 18))
group <- factor(rep(rep(1:3, e65ach = 3), times = 4))
team <- factor(rep(1:3, times = 12))
canonloading <- data.frame(gunData, method, group, team)

# ANOVA MODEL
library(EMSaov)
result <- EMSanova(gunData ~ method + group + team, type = c("F", "F", "R"), nested = c(NA, NA, "G"), data = canonloading)
result


################################################################################################################

data <- c(130,155,74,180,150,188,159,126,138,110,168,160,
          34,40,80,75,136,122,106,115,174,120,150,139,
          20,70,82,58,25,70,58,45,96,104,82,60)
temperature <- factor(rep(1:3, each = 12))
material <- factor(rep(rep(1:3, each = 4), times=3))
car <- data.frame(data, temperature, material)
library(EMSaov)
result <- EMSanova(data ~ temperature + material, type = c("R", "F"), nested = c(NA, NA), data = car)
result


################################################################################################################


data <- c(33,35,36,40,31,35,36,38,32,32,36,36)
B <- factor(rep(c("TV","신문","RADIO"), each = 4))
A <- factor(rep(1:4, times=3))
ad_data <- data.frame(data, A, B)

ad_data.aov = aov(data ~ A*B, data=ad_data)
summary(ad_data.aov)
ad_data.glm = glm(data ~ A*B, data=ad_data)
summary(ad_data.glm)

