library(forecast)

ex8_2a <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex8_2a.txt")
ex8_2a.ts <- ts(ex8_2a)
plot(ex8_2a.ts)
acf(ex8_2a.ts)
pacf(ex8_2a.ts)

# 잠정모형 :  AR(4), MA(3), ARMA

# 차분 실시
ndiffs(ex8_2a.ts)             # 단위근 검정 결과는 0차 차분

arima(ex8_2a, order=c(4,0,0))$aic
arima(ex8_2a, order=c(0,0,3))$aic
arima(ex8_2a, order=c(1,0,1))$aic
arima(ex8_2a, order=c(1,0,2))$aic
arima(ex8_2a, order=c(2,0,1))$aic
arima(ex8_2a, order=c(2,0,2))$aic

Arima(ex8_2a, order=c(0,0,3), include.drift=TRUE)       # 358.6589/2.8061 이므로 절편이 유의적이다.
fit <- Arima(ex8_2a,order=c(0,0,3))
tsdiag(fit, gof.lag=24)         # 잔차 분석.

# 과대 적합 실시
fit1 <- Arima(ex8_2a, order=c(3,0,2), include.drift=TRUE)
confint(fit1)     # 추가된 모수가 비유의적.
fit2 <- Arima(ex8_2a, order=c(2,0,3), include.drift=TRUE)
confint(fit2)     # 추가된 모수가 비유의적.
