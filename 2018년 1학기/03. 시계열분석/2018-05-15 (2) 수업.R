library(forecast)

# R에서의 예측

# forecast(object, h=, level=)
# object = arima(), Arima()로 생성되는 객체
# h =  예측하고자 하는 선행시차.
# level = 신뢰수준.

ex8_2a <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex8_2a.txt")
ex8_2a.ts <- ts(ex8_2a)

fit_a <- Arima(ex8_2a, order=c(0,0,3), include.drift=FALSE, fixed=c(NA,0,NA,NA))     
summary(forecast(fit_a))
plot(forecast(fit_a))





ex8_2b <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex8_2b.txt")
ex8_2b.ts <- ts(ex8_2b)

fit_b <- arima(ex8_2b, order=c(1,0,2), include.mean=TRUE, fixed=c(NA,0,NA,NA))    
summary(forecast(fit_b))
plot(forecast(fit_b))





ex7_5d <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/ex7_5d.txt")
ex7_5d.ts <- ts(ex7_5d)
fit_d <- Arima(ex7_5d, order=c(1,1,2), include.drift=TRUE, fixed=c(NA,NA,0,NA))    
summary(forecast(fit_d))
plot(forecast(fit_d))





rate <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/interest.txt")
fit_r <- Arima(rate, order=c(1,1,0))
summary(forecast(fit_r))
plot(forecast(fit_r))
