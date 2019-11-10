# 패키지 호출
library(rattle)
library(RGtk2)
library(car)
library(tidyverse)
library(GGally)


# 데이터 로딩 및 탐색
data(Mroz)
str(Mroz)
summary(Mroz)

# rattle 실행
rattle()

# 시각화
data <- data.frame(n=c(1:10),AUC=c(0.72,0.72,0.71,0.65,0.69,0.69,0.5,0.83,0.82,0.69),
                   correct=c(0.70,0.70,0.68,0.64,0.65,0.70,0.40,0.71,0.70,0.69))
data %>% ggplot(aes(x=n,y=AUC)) + geom_line(col='blue',size=2) + 
  geom_point(size=3,col="red") + labs(title="Grid Search : Hidden Layer")
data %>% ggplot(aes(x=n,y=correct)) + geom_line(col='green',size=2) + 
  geom_point(size=3,col="red") + labs(title="Grid Search : Hidden Layer")
data %>% ggplot() + geom_line(aes(x=n,y=AUC),col='blue',size=2) + geom_point(aes(x=n,y=AUC),size=3,col="red") + 
  geom_line(aes(x=n,y=correct),col='darkgreen',size=2) + geom_point(aes(x=n,y=correct),size=3,col="red") 



