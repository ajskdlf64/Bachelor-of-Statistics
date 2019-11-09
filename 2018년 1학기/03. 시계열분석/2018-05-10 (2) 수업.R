library(forecast)

# R에서의 예측

# forecast(object, h=, level=)
# object = arima(), Arima()로 생성되는 객체
# h =  예측하고자 하는 선행시차.
# level = 신뢰수준.

set.seed(1234)

ma <- arima.sim(model=list(order=c(0,0,1),ma=0.7),n=200)
plot(ma)

ma1 <- window(ma,end=180)        # Test 데이터
plot(ma1)

ma2 <- window(ma,start=181)      # Test 데이터를 통해 예측할 데이터 
plot(ma2)

fit_ma1 <- arima(ma1,order=c(0,0,1),include.mean=FALSE)     # 값 예측.

fore_ma1 <- forecast(fit_ma1, h=20)
summary(fore_ma1)
accuracy(fore_ma1,ma2)           # 예측 정확도 로 예측된값과 실제 값 비교.

plot(fore_ma1)
lines(181:200,ma2,col='red')     # 1 시차 후 예측만 유효간 결과이며, 그 이후에는 그냥 평균이 됨,
                                 # MA(q) 모형은 q-시차 후 예측까지만 가능.