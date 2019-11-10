

library(forecast)


elecstock <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/elecstock.txt")
elecstock.ts <- ts(elecstock)
plot(elecstock.ts)
acf(elecstock.ts)
pacf(elecstock.ts)
ndiffs(elecstock)               # 차분(d)을 결정.
auto.arima(elecstock.ts)        # 차수(p,q)를 결정.


WWWusage
WWWusage.ts <- ts(WWWusage)
ndiffs(WWWusage.ts)
auto.arima(WWWusage.ts)
plot(WWWusage.ts)
acf(WWWusage.ts)
pacf(WWWusage.ts)


gas <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/gas.txt")
gas.ts <- ts(gas)
plot(gas.ts)
acf(gas.ts)
pacf(gas.ts)
# ARIMA(2,1,0) 인거 같음.


ndiffs(gas.ts)
auto.arima(gas.ts)
tsdiag(arima(gas.ts,c(3,0,0)))


fit <- arima(gas, order=c(3,0,0), include.mean=FALSE)
fit
confint(fit)
tsdiag(fit)
tsdiag(fit, gof.lag=24)
Box.test(fit$resid, lag=4, type="Ljung-Box")
Box.test(fit$resid, lag=4, type="Ljung-Box", fitdf=3)


fit2 <- arima(gas.ts, c(4,0,0),fixed=c(NA,NA,0,NA),include.mean=FALSE)
confint(fit2)
tsdiag(fit2, gof.lag=24)


fit2.2 <- arima(gas.ts, c(5,0,0),include.mean=FALSE)
confint(fit2.2)
tsdiag(fit2.2, gof.lag=24)


fit2.1 <- arima(gas.ts, c(4,0,1),fixed=c(NA,NA,0,NA,NA),include.mean=FALSE)
confint(fit2.1)
tsdiag(fit2.1, gof.lag=24)


fit3 <- arima(gas.ts, c(3,0,1),include.mean=FALSE)
confint(fit3)
tsdiag(fit3, gof.lag=24)
Box.test(fit3$resid,lag=5,type='Ljung-Box')
Box.test(fit3$resid,lag=5,type='Ljung-Box',fitdf=4)


fit3.1 <- arima(gas.ts, c(3,0,2),include.mean=FALSE)
confint(fit3.1)
tsdiag(fit3.1, gof.lag=24)


arima(gas,order=c(1,0,1),include.mean = FALSE)$aic
arima(gas,order=c(1,0,2),include.mean = FALSE)$aic
arima(gas,order=c(2,0,1),include.mean = FALSE)$aic
arima(gas,order=c(2,0,2),include.mean = FALSE)$aic


fit4 <- arima(gas.ts, c(2,0,2), include.mean = FALSE)
confint(fit4)
fit4.1 <- arima(gas.ts, c(3,0,2), include.mean = FALSE)
confint(fit4.1)
fit4.2 <- arima(gas.ts, c(2,0,3), include.mean = FALSE)
confint(fit4.2)
tsdiag(fit4.2, gof.lag=24, type='Ljung-Box')
Box.test(fit4.2$resid,lag=19, type="Ljung-Box", fitdf=5)


fit5 <- arima(gas,order=c(1,0,4), include.mean = FALSE)
confint(fit5)
tsdiag(fit5, gof.lag=24, type="Ljung-Box")
Box.test(fit5$resid,lag=24, type="Ljung-Box",fitdf=5)


fit5.1 <- arima(gas,order=c(1,0,5), include.mean = FALSE)
confint(fit5.1)
