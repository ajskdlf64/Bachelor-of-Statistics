# 라이브러리 호출
library(tidyverse)

# 데이터 로딩
breast <- read.csv("C:/Users/user/Desktop/University/빅데이터분석실습/Data/breast.csv", header = T, na.strings = "?")

# 데이터 정렬
breast$tumor.size <- ordered(breast$tumor.size)
breast$inv.nodes <- ordered(breast$inv.nodes)

# 결측값 제거
breast <- breast[complete.cases(breast),]

# 데이터 탐색
str(breast)
head(breast)
summary(breast)

# nnet
library(nnet)
nn.breast <- nnet(Class ~ ., data = breast, size = 3)
summary(nn.breast)

# 시각화
library(clusterGeneration)
library(scales)
library(reshape)
plot(nn.breast)

# rattle
library(rattle)
rattle()
