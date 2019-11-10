library(forecast)

# 자료 불러오기.
depart <- scan("C:/Users/user/Desktop/학교수업/시게열분석/수업 자료/depart.txt")
depart.ts <- ts(depart,start=c(1984),frequency=12) 

# 시계열 그래프 그리기.
plot(depart.ts)
acf(depart.ts)
pacf(depart.ts)

# 분산 안정화를 위한 로그 변환.
log_depart.ts <- log(depart.ts)
plot(log_depart.ts)

# 굉장한게 나옴.
ggseasonplot(log_depart.ts)
ggseasonplot(depart.ts, polar=TRUE)

# 차분 차수 확인.
Acf(log_depart.ts, lag.max=48)
ndiffs(log_depart.ts)        # 차분을 시도하고 그 결과를 확인할 필요가 있음.
nsdiffs(log_depart.ts)

# d=1 인 경우. 더 굉장한게 나옴.
log_depart_d_1.ts <- diff(log_depart.ts)
ggtsdisplay(log_depart_d_1.ts,lag.max=48)

# 계절차분 실시.
log_depart_D_1.ts <- diff(log_depart.ts,lag=12)
ggtsdisplay(log_depart_D_1.ts,lag.max=48)

# 일반차분(d=1) 실시 후 계절차분(D=12) 실시.
log_depart_d_1_D_1.ts <- diff(log_depart_d_1.ts,lag=12)
ggtsdisplay(log_depart_d_1_D_1.ts,lag.max=48)

# 모형 인식.
Acf(log_depart_d_1_D_1.ts, lag=48)    # 비계절형 요소는 AR(2)로 판단. p=2, q=0
Pacf(log_depart_d_1_D_1.ts, lag=48)   # 계절형 요소는 12 24 36 48 모두 비유의적 P=0,Q=0

# 따라서 잠정 모형은 AIRMA(0,1,1)(0,1,0)[12], AIRMA(2,1,0)(0,1,0)[12]

# 모수 추정.
fit1 <- Arima(log_depart.ts, order=c(0,1,1), seasonal=list(order=c(0,1,0), period=12))

# 모형 검정.
checkresiduals(fit1)   # 잔차분석까지는 통과.

# 과대적합.
fit2 <- Arima(log_depart.ts, order=c(1,1,1), seasonal=list(order=c(0,1,0), period=12))
confint(fit2)          # 추가된 모수가 비유의적.
fit3 <- Arima(log_depart.ts, order=c(0,1,2), seasonal=list(order=c(0,1,0), period=12))
confint(fit3)          # 추가된 모수가 비유의적.

# 따라서 ARIMA(0,1,1)(0,1,0)[12] 으로 예측 가능.
# AIRMA(2,1,0)(0,1,0)[12]도 모형 분석 통과.
fit5 <- Arima(log_depart.ts, order=c(2,1,0), seasonal=list(order=c(0,1,0), period=12))

# 따라서 AIC 값과 BIC 값으로 판단.

# auto.arima를 돌려보자.
fit4 <- auto.arima(log_depart.ts,d=1,D=1)
fit4

# (0,1,1)(0,1,1)와 (2,1,0)(0,1,0)와 (0,1,1)(0,1,0) 을 비교.
fit1$aic
fit5$aic
fit4$aic

fit1$bic
fit5$bic
fit4$bic

# 최종모형 ARIMA(0,1,1)(0,1,1)으로 결정.

# 예측.
summary(forecast(fit4))
plot(forecast(fit4,h=12,level=95))

fit4_1 <- Arima(depart.ts, order=c(0,1,1), seasonal=list(order=c(0,1,1), period=12),lambda=0)
summary(forecast(fit4_1))
plot(forecast(fit4_1,h=12,level=95))