z <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/eg8_7.txt")
z.ts <- ts(z)
plot(z.ts)
acf(z.ts)
pacf(z.ts)

fit1 <- arima(z,order=c(0,0,4))
confint(fit1)

fit2 <- arima(z,order=c(1,0,0))
confint(fit2)

qqnorm(fit2$resid); qqline(fit2$resid)
