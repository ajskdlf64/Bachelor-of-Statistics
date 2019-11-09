library(forecast)

interest <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/interest.txt")
interest.ts <- ts(interest)
plot(interest.ts)
acf(interest.ts)
pacf(interest.ts)

ndiffs(interest)
interest2 <- diff(interest)
interest2.ts <- ts(interest2)
plot(interest2.ts)
acf(interest2)
pacf(interest2)

# 잠정모형 : ARIMA(0,1,1) 으로 결정.

fit6.1 <- Arima(interest,order=c(0,1,1),include.drift = FALSE)
confint(fit6.1)           # 절편이 비유의적.

fit6 <- Arima(interest,order=c(0,1,2),include.drift = FALSE)
confint(fit6)             # MA(2)의 모수가 비유의적.

fit6.2 <- Arima(interest,order=c(1,1,1),include.drift = FALSE)
confint(fit6.2)           # 추가된 모수가 비유의적.

# 최종모형 : ARIMA(0,1,1) 으로 결정. ARIMA(1,1,0) 도 가능
# 이럴 경우 AIC(or BIC)가 작은 값을 판단. 따라서 ARI(1,1) 모형 최종모형으로 결정.

Arima(interest, order=c(1,1,0))$aic      # AIC = 249.5485
Arima(interest, order=c(0,1,1))$aic      # AIC = 251.3015
