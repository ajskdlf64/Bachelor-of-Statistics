# 패키지 호출
library(tidyverse)

# 데이터 호출
data <- read.csv("daily_88101_2014.csv")

# 데이터 구조 파악
str(data)
summary(data)

# 데이터 미리보기
head(data)
tail(data)

# Date.Local 변수에서 월을 추출하여 새로운 변수로 지정하기
data <- data %>% mutate(month=months(as.POSIXlt(data$Date.Local)) )

# group_by() 함수를 이용하여 층(strata) 구성하여 AQI 평균 구하기
data %>% group_by(County.Code, month) %>% summarise(AQI_mean=mean(AQI,na.rm=TRUE))

# 전체 월별 평균
data %>% group_by(month) %>% 
  summarise(AQI_mean=mean(AQI,na.rm=TRUE))

# County.Code와 month와의 관계
with(data,table(County.Code,month))

# 전체 월별 평균 막대그래프
data %>% group_by(County.Code, month) %>% 
  summarise(AQI_mean=mean(AQI,na.rm=TRUE)) %>% 
  ggplot(aes(x=month,y=AQI_mean,fill=month)) + 
  geom_bar(stat="identity") + 
  labs(title="County.Code = All")

# County.Code=1 경우의 월별 평균 막대그래프
data %>% filter(County.Code==1) %>% 
  group_by(County.Code, month) %>% 
  summarise(AQI_mean=mean(AQI,na.rm=TRUE)) %>% 
  ggplot(aes(x=month,y=AQI_mean,fill=month)) + 
  geom_bar(stat="identity") + 
  labs(title="County.Code=1")
