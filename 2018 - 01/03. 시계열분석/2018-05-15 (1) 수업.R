library(forecast)

# R에서의 예측

# forecast(object, h=, level=)
# object = arima(), Arima()로 생성되는 객체
# h =  예측하고자 하는 선행시차.
# level = 신뢰수준.

set.seed(1234)

z <- arima.sim(model=list(order=c(1,1,1), ar=0.7, ma=-0.7), n = 200)
z <- as.ts(z[-1])              # d=1 이면 자료 1개 뺴줘야 함.

nobs <- length(z)
z <- z + 0.1*(1:nobs)
z6 <- window(z,end=180)
t6 <- window(z,start=181)

fit_z6 <- Arima(z6,order=c(1,1,1), include.drift=TRUE)

fore_z6 <- forecast(fit_z6, h=20)
summary(fore_z6)
accuracy(fore_z6,t6)           # 예측 정확도 로 예측된값과 실제 값 비교.

plot(fore_z6)
lines(181:200,t6,col='red') 