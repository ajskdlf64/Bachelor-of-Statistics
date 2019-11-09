library(forecast)

# R에서의 예측

# forecast(object, h=, level=)
# object = arima(), Arima()로 생성되는 객체
# h =  예측하고자 하는 선행시차.
# level = 신뢰수준.

set.seed(1234)

arma <- arima.sim(model=list(order=c(1,0,1),ar=0.7, ma=0.5),n=200)
plot(arma)

arma1 <- window(arma,end=180)        # Test 데이터
plot(arma1)

arma2 <- window(arma,start=181)      # Test 데이터를 통해 예측할 데이터 
plot(arma2)

fit_arma1 <- arima(arma1,order=c(1,0,1),include.mean=FALSE)     # 값 예측.

fore_arma1 <- forecast(fit_arma1, h=20)
summary(fore_arma1)
accuracy(fore_arma1,arma2)           # 예측 정확도 로 예측된값과 실제 값 비교.

plot(fore_arma1)
lines(181:200,arma2,col='red')     