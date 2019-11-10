# 라이브러리 호출
library(sorar)
library(mlbench)
library(rattle)

# 데이터 불러오기
data(Sonar)

# 데이터 살펴보기
str(Sonar)
head(Sonar)
summary(Sonar)

# rattle 실행하기
rattle()