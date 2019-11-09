# 문제 1번 - a
t <- qt(p=0.975, df=52, lower.tail = TRUE)
X_mean = 88
X_var = 361.4
X_n = 53
lower_limit = X_mean - t * (sqrt(X_var)/sqrt(X_n))
lower_limit
upper_limit = X_mean + t * (sqrt(X_var)/sqrt(X_n))
upper_limit

# 문제 1번 - b
set.seed(1234)
x <- rnorm(53,88,sqrt(361.4))
y <- rnorm(52,109,sqrt(709.7))
var.test(x,y)
boxplot(x,y)

# 문제 1번 - c
t.test(x,y, var.equal = TRUE)

# 문제 2번 - a
library(vcd)
data <- matrix(c(339,149,198,351), nrow=2, ncol=2, dimnames=list(E=c("YES","NO"),D=c("YES","NO")))
chisq.test(data)

# 문제 2번 - b
prop.test(x = c(339,149), n = c(537,500), alternative = "greater")

# 문제 3번 - a
data <- read.csv("./absorbdata.csv")
library(tidyverse)
a <- data %>% filter(treat == "Capsule-fasting") %>% select(absorb)
b <- data %>% filter(treat == "Capsule-nonfasting") %>% select(absorb)
c <- data %>% filter(treat == "Enteric-Coated") %>% select(absorb)
test = as.data.frame(matrix(c(3.5,4.0,3.5,3.0,3.5,3.0,4.0,3.5,3.5,3.0,4.5,
                              4.5,4.5,4.5,4.5,5.0,5.5,4.0,4.5,5.0,4.5,6.0,
                              2.5,3.0,3.0,3.0,3.5,3.5,2.5,3.0,3.5,3.5,3.0), ncol = 3, byrow=T))
names(test) = c("Capsule(fasting)", "Capsule(nonfasting)", "Enteric-Coated")
test$subject=as.factor(1:11)
# a
library(ICSNP)
HotellingsT2(test, test="f")
# b
diff = test$V1 - test$V2
t.test(diff)
library(ICSNP)
HotellingsT2(diff, test="f")
