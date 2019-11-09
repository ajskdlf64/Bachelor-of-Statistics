library(forecast)

female <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/female.txt")
female.ts <- ts(female)
plot(female.ts)
acf(female.ts)
pacf(female.ts)

# 차분 실시
ndiffs(female.ts)             # 단위근 검정 결과는 1차 차분
female2 <- diff(female)
female2.ts <- ts(female2)
plot(female2.ts)
acf(female2)
pacf(female2)

# 1차 차분된 자료 : 백색잡음과정, 원자료 : 확률보행과정
# 함수 arima()는 d>=1 인 경우 절편의 추정 및 검정은 불가능.

# Arima(x, order=c(0,0,0,), include.mean=TRUE, include.drift=FALSE, fixed=NULL)
# x <- 시계열 자료.
# order(0,0,0) <-  ARIMA(p,d,q)의 차수 지정.
# include.mean <- d=0의 자료에 대하여 모형의 평균 포함 여부.
# include.drift <- d=1의 자료에 대하여 절편 포함 여부.
# fixed <- 비유의적 모수 제거.

Arima(female, order=c(0,1,0), include.drift=TRUE)       # 4.215/1.093 이므로 절편이 유의적이다.
(fit <- Arima(female,order=c(0,1,0)))

tsdiag(fit, gof.lag=24)     # 잔차 분석.

# 과대 적합 실시
fit1 <- Arima(female, order=c(1,1,0), include.drift=TRUE)
confint(fit1)     # 추가된 모수가 비유의적.
fit2 <- Arima(female, order=c(0,1,1), include.drift=TRUE)
confint(fit2)     # 추가된 모수가 비유의적.
