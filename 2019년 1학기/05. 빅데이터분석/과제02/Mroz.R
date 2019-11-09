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
ggpairs(Mroz)


# 데이터 생성 및 선택
Mroz2 <- Mroz %>% mutate(lwg2=lwg * lwg) 
Mroz2 <- Mroz2 %>% select(-hc)


# 데이터 분리
set.seed(1234)
id= sample(1:753, size = 500) 
train_data= Mroz2[id,]
test_data= Mroz2[-id,]
str(train_data)
summary(train_data)
str(test_data)
summary(test_data)
table = data.frame(group=c("Train_No","Train_Yes","Test_No","Test_Yes"),
                   class=c("Train","Train","Test","Test"),
                   lfp=c("no","yes","no","yes"),
                   count=c(217,283,108,145))
ggplot(table, aes(x=class,y=count,fill=lfp)) + 
  geom_bar(stat="identity",position="dodge") + 
  labs(title="Data Split")
ggplot(table, aes(x=class,y=count,fill=lfp)) + 
  geom_bar(stat="identity") + 
  labs(title="Data Split")


# rattle 실행
rattle()

