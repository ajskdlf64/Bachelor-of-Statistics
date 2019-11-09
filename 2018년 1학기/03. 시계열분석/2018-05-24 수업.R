library(forecast)

# 자료 불러오기.
tourist <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/tourist.txt")
tourist.ts <- ts(tourist,start=c(1981),frequency=12) 

# 시계열 그래프 그리기.
plot(tourist.ts)
acf(tourist.ts)
pacf(tourist.ts)

# 분산 안정화를 위한 로그 변환.
log_tourist.ts <- log(tourist.ts)
plot(log_tourist.ts)

# 굉장한게 나옴.
ggseasonplot(log_tourist.ts)
ggseasonplot(tourist.ts, polar=TRUE)

# 차분 차수 확인.
Acf(log_tourist.ts, lag.max=48)
ndiffs(log_tourist.ts)        # 차분을 시도하고 그 결과를 확인할 필요가 있음.
nsdiffs(log_tourist.ts)

# d=1 인 경우. 더 굉장한게 나옴.
log_tourist_d_1.ts <- diff(log_tourist.ts)
ggtsdisplay(log_tourist_d_1.ts,lag.max=48)

# 계절차분 실시.
log_tourist_D_1.ts <- diff(log_tourist.ts,lag=12)
ggtsdisplay(log_tourist_D_1.ts,lag.max=48)

# 일반차분(d=1) 실시 후 계절차분(D=12) 실시.
log_tourist_d_1_D_1.ts <- diff(log_tourist_d_1.ts,lag=12)
ggtsdisplay(log_tourist_d_1_D_1.ts,lag.max=48)

# 모형 인식.
Acf(log_tourist_d_1_D_1.ts, lag=48)    # 비계절형 요소는 AR(2) or MA(1) 판단. p=2, q=0 or p=0, q=1
Pacf(log_tourist_d_1_D_1.ts, lag=48)   # 계절형 요소는 P=1,Q=0 or P=0,Q=1

# 따라서 잠정 모형은 AIRMA(0,1,1)(0,1,1)[12], AIRMA(0,1,1)(1,1,0)[12]
# 따라서 잠정 모형은 AIRMA(2,1,0)(0,1,1)[12], AIRMA(2,1,0)(1,1,0)[12]

# 모수 추정.
fit1 <- Arima(log_tourist.ts, order=c(0,1,1), seasonal=list(order=c(0,1,1), period=12))

# 모형 검정.
checkresiduals(fit1)   # 잔차분석까지는 통과.

# 과대적합.
fit2 <- Arima(log_tourist.ts, order=c(1,1,1), seasonal=list(order=c(0,1,1), period=12))
confint(fit2)          # 추가된 모수가 유의적.
checkresiduals(fit2)   # 잔차분석까지는 통과.

fit2_1 <- Arima(log_tourist.ts, order=c(2,1,1), seasonal=list(order=c(0,1,1), period=12))
confint(fit2_1)          # 추가된 모수가 비유의적.
checkresiduals(fit2_1)   

fit2_2 <- Arima(log_tourist.ts, order=c(1,1,2), seasonal=list(order=c(0,1,1), period=12))
confint(fit2_2)          # 추가된 모수가 비유의적.
checkresiduals(fit2_2)

fit3 <- Arima(log_tourist.ts, order=c(0,1,2), seasonal=list(order=c(0,1,1), period=12))
confint(fit3)          # 추가된 모수가 유의적.
checkresiduals(fit3)   # 잔차분석까지는 통과.

fit3_1 <- Arima(log_tourist.ts, order=c(1,1,2), seasonal=list(order=c(0,1,1), period=12))
confint(fit3_1)          # 추가된 모수가 비유의적.
checkresiduals(fit3_1)   

fit3_2 <- Arima(log_tourist.ts, order=c(0,1,3), seasonal=list(order=c(0,1,1), period=12))
confint(fit3_2)          # 추가된 모수가 비유의적.
checkresiduals(fit3_2)


# 따라서 ARIMA(1,1,1)(0,1,1)[12], ARIMA(0,1,2)(0,1,1)[12] 으로 잠정모형으로 예측 가능.

# 이렇게 마찬가지로 다 해보면, AIRMA(1,1,1)(1,1,0)[12], AIRMA(0,1,2)(1,1,0)[12] 도 잠정 모형 가능.

fit4 <- Arima(log_tourist.ts, order=c(2,1,0), seasonal=list(order=c(0,1,1), period=12))
checkresiduals(fit4)
fit4_1 <- Arima(log_tourist.ts, order=c(3,1,0), seasonal=list(order=c(0,1,1), period=12))
checkresiduals(fit4_1)
confint(fit4_1)     # 추가된 모수가 비유의적.
fit4_2 <- Arima(log_tourist.ts, order=c(2,1,1), seasonal=list(order=c(0,1,1), period=12))
checkresiduals(fit4_2)
confint(fit4_2)     # 추가된 모수가 비유의적.


fit5 <- Arima(log_tourist.ts, order=c(2,1,0), seasonal=list(order=c(1,1,0), period=12))
checkresiduals(fit5)
fit5_1 <- Arima(log_tourist.ts, order=c(3,1,0), seasonal=list(order=c(1,1,0), period=12))
checkresiduals(fit5_1)
confint(fit5_1)     # 추가된 모수가 비유의적.
fit5_2 <- Arima(log_tourist.ts, order=c(2,1,1), seasonal=list(order=c(1,1,0), period=12))
checkresiduals(fit5_2)
confint(fit5_2)     # 추가된 모수가 비유의적.

# 따라서 ARIMA(2,1,0)(0,1,1)[12], ARIMA(2,1,0)(1,1,0)[12] 으로 잠정모형으로 예측 가능.


# 최종 잠정 모형 6개 :
# ARIMA(1,1,1)(0,1,1)[12]
# ARIMA(0,1,2)(0,1,1)[12]
# AIRMA(1,1,1)(1,1,0)[12]
# AIRMA(0,1,2)(1,1,0)[12]
# ARIMA(2,1,0)(0,1,1)[12]
# ARIMA(2,1,0)(1,1,0)[12]

# 여기서 AIC값과 BIC값이 가장 작은 값을 사용.

# ARIMA(2,1,0)(1,1,0)[12] 을 최종 모델로 결정.

summary(forecast(fit5_2))
plot(forecast(fit5_2,h=12,level=95))

fit5_2_1 <- Arima(tourist.ts, order=c(2,1,0), seasonal=list(order=c(1,1,0), period=12),lambda=0)
summary(forecast(fit5_2_1))
plot(forecast(fit5_2_1,h=12,level=95))

tour92 <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/tour92.txt")
tour92 <- ts(tour92,start=1992, freq=12)

new_t <- seq(1992, by=1/12,length=12)
lines(new_t,tour92,col='red')

# 확대하기.
plot(forecast(fit5_2_1, xlim=c(1992,1993), ylim=c(2e+5,4.5e+5)))
lines(new_t,tour92,col="red",lwd=2)
legend("topleft",c("Observed Data","Forecaast"),lwd=2,col=c("red","blue"), bty='n')
