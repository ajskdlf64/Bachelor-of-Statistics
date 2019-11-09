library(forecast)

# R에서의 예측

# forecast(object, h=, level=)
# object = arima(), Arima()로 생성되는 객체
# h =  예측하고자 하는 선행시차.
# level = 신뢰수준.

set.seed(1234)

ar <- arima.sim(model=list(order=c(1,0,0),ar=0.7),n=200)
plot(ar)

ar1 <- window(ar,end=180)        # Test 데이터
plot(ar1)

ar2 <- window(ar,start=181)      # Test 데이터를 통해 예측할 데이터 
plot(ar2)fit_ar1 <- arima(ar1,order=c(1,0,0),include.mean=FALSE)     # 값 예측.



fore_ar1 <- forecast(fit_ar1, h=20)
summary(fore_ar1)
accuracy(fore_ar1,ar3)           # 예측 정확도 로 예측된값과 실제 값 비교.

plot(fore_ar1)
lines(181:200,ar2,col='red')       # 예측값은 자료의 평균의 0으로 수렴, 예측구간은 점차 넓어지다 일정한 간격유지.
