library(forecast)

ex8_2b <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex8_2b.txt")
ex8_2b.ts <- ts(ex8_2b)
plot(ex8_2b.ts)
acf(ex8_2b.ts)
pacf(ex8_2b.ts)

# 차분 실시
ndiffs(ex8_2b.ts)             # 단위근 검정 결과는 0차 차분

# 1차 차분된 자료 : 백색잡음과정, 원자료 : 확률보행과정
# 함수 arima()는 d>=1 인 경우 절편의 추정 및 검정은 불가능.

# Arima(x, order=c(0,0,0,), include.mean=TRUE, include.drift=FALSE, fixed=NULL)
# x <- 시계열 자료.
# order(0,0,0) <-  ARIMA(p,d,q)의 차수 지정.
# include.mean <- d=0의 자료에 대하여 모형의 평균 포함 여부.
# include.drift <- d=1의 자료에 대하여 절편 포함 여부.
# fixed <- 비유의적 모수 제거.

Arima(ex8_2b, order=c(1,0,0), include.drift=TRUE)
(fit <- Arima(ex8_2b,order=c(1,0,0)))

tsdiag(fit, gof.lag=24)     # 잔차 분석.

(fit2 <- Arima(ex8_2b,order=c(1,0,2)))
tsdiag(fit2,gof.lag = 24)

# auto.arima(z, stepwise=FALSE)
# 모든 모형이 비교 대상
# 속도가 느리다. 특히 계절형 모형의 경우.
