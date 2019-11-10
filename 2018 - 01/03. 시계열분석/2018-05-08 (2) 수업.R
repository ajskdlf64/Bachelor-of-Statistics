library(forecast)

ex7_5d <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex7_5d.txt")
ex7_5d.ts <- ts(ex7_5d)
plot(ex7_5d.ts)
acf(ex7_5d.ts)
pacf(ex7_5d.ts)


# 차분 실시
ndiffs(ex7_5d.ts)             # 단위근 검정 결과는 1차 차분
ex7_5d2 <- diff(ex7_5d)
ex7_5d2.ts <- ts(ex7_5d2)
plot(ex7_5d2.ts)
acf(ex7_5d2)
pacf(ex7_5d2)


# 잠정모형 : ARIMA(1,1,1), ARIMA(2,1,1), ARIMA(1,1,2), ARIMA(2,1,2)
Arima(ex7_5d,order=c(1,1,1),include.drift = TRUE)$aic
Arima(ex7_5d,order=c(1,1,2),include.drift = TRUE)$aic
Arima(ex7_5d,order=c(2,1,1),include.drift = TRUE)$aic
Arima(ex7_5d,order=c(2,1,2),include.drift = TRUE)$aic
# include.drift = TRUE은 d가1 일 때, include.mean = TRUE은 d가 0 일 때.


fit5 <- Arima(ex7_5d,order=c(2,1,1),include.drift = TRUE)
confint(fit5)


fit5.1 <- Arima(ex7_5d,order=c(2,1,1),include.drift = TRUE, fixed=c(0,NA,NA,NA))
confint(fit5.1)


# 과대적합해도 추가된 모수가 모두 비유의적 따라서 최종모형 ARIMA(2,1,1) 이다.
fit5.2 <- Arima(ex7_5d,order=c(3,1,1),include.drift = TRUE, fixed=c(0,NA,NA,NA,NA))
confint(fit5.2)
fit5.3 <- Arima(ex7_5d,order=c(2,1,2),include.drift = TRUE, fixed=c(0,NA,NA,NA,NA))
confint(fit5.3)


auto.arima(ex7_5d, ic="bic")
# auto arima 는 디폴트값이 aic가 최소가 되는 값을 찾는건데, ic="bic"를 쓰면 기준값이 bic 이다.


auto.arima(ex7_5d, stepwise = FALSE)
fit5.4 <- Arima(ex7_5d,order=c(1,1,3),include.drift = TRUE, fixed=c(NA,NA,0,NA,NA))
confint(fit5.4)
# ARIMA(1,1,3) wiht ma2=0 이 최종모형.



# 시작점에 따라 최종모형이 여러개가 나오는데, 결국에는 BIC와 AIC 값을 비교해서 최종적인 모형을 선택한다.