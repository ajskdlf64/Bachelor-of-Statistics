library(forecast)
gas <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/gas.txt")

gas_1 <- diff(gas)
plot(as.ts(gas_1))
acf(gas_1)
pacf(gas_1)

fit3 <- arima(gas,order=c(3,1,0))
confint(fit3)
tsdiag(fit3, gof.lag=24, type="Ljung-Box")

fit3_1 <- arima(gas,order=c(4,1,0))                                # AR차수 1 추가.
confint(fit3_1)

fit3_2 <- arima(gas,order=c(3,1,1))                                # MA차수 1 추가.
confint(fit3_2)
tsdiag(fit3_2, gof.lag=24, type="Ljung-Box")
Box.test(fit5$resid,lag=15, type="Ljung-Box",fitdf=4)

arima(gas,order=c(1,1,1))$aic
arima(gas,order=c(1,1,2))$aic
arima(gas,order=c(2,1,1))$aic
arima(gas,order=c(2,1,2))$aic

fit3_3 <- arima(gas,order=c(2,1,1))
confint(fit3_3)
tsdiag(fit3_3,gof.lag=24)

fit3_3 <- arima(gas,order=c(3,1,1))

fit3_4 <- arima(gas,order=c(2,2,1))
confint(fit3_4)

fit5 <- auto.arima(gas)
fit5

fit5_1 <- arima(gas,order=c(4,1,1))

fit6 <- arima(gas,order=c(1,0,4))
confint(fit6)

# 결론 - ARMA(1,4)이 가장 적합한 최종모형이다.