# 패키지 호출
library(tidyverse)


# versicolor 품종을 제외
iris2 <- subset(iris, Species != "versicolor")


# 품종 변수를 요인 변수로 변환
iris2$Species <- factor(iris2$Species)


# 시드 고정
set.seed(417)


# 각 품종별 랜덤으로 40개씩 총 80개 추출
idx1 <- sample(1:50, size = 40)
idx2 <- sample(51:100, size = 40)
idx <- c(idx1, idx2)


# 추출한 80개 데이터를 Train으로, 나머지 20개를 Test 데이터로 분리
train <- iris2[idx,]
test <- iris2[-idx,]


# 로지스틱 회귀모형 적합 (설명변수는 Sepal.Length 만 사용)
result <- glm(Species ~ Sepal.Length, data = train, family = binomial(link="logit"))
summary(result)


# 오분류표(Concordance Matrix)
fitted(result)
fit <- ifelse(fitted(result) < 0.5, "setosa", "versicolor")
table(train$Species, fit)


# Test 데이터의 오분류표
prob <- predict(result, newdata = test, type="response")
fit <- ifelse(prob < 0.5, "setosa", "versicolor")
table(test$Species, fit)


# Train 데이터의 조건부분포표
cdplot(Species ~ Sepal.Length, data = train)


# rattle 사용하기
library(rattle)
rattle()


# iris data 사용하기
data(iris)


# 일반적으로 Data에 대한 수정은 R에서 수행



