airport <- scan("C:/Users/user/Desktop/학교수업/시계열분석/조별과제/airport.txt")
airport.ts<-ts(airport,start=2002,freq=12)
plot(airport.ts)
library(forecast)
ggtsdisplay(airport.ts)

log_airport <- log(airport.ts)
d_airport <- diff(log(airport.ts))
plot(d_airport)
ggtsdisplay(d_airport)
sd_airport<-diff(d_airport,lag=12)
ggtsdisplay(sd_airport,lag.max = 48)

port_1 <- diff(log_airport)
ggtsdisplay(port_1,lag.max=48)  #arima(0,1,1),arima(4,1,0) ,(1,1,1)(2,1,1)(1,1,2),(2,1,2)
port_12 <- diff(log_airport,lag=12)
ggtsdisplay(port_12,lag.max = 48)  #arima(2,0,0)(0,1,1) 
port_1_12 <- diff(port_1,lag=12)
ggtsdisplay(port_1_12,lag.max = 48)

fit1.1 <- Arima(log_airport,order=c(0,1,1),include.drift =FALSE)
fit1.1
confint(fit1.1)
fit1.1.1 <- Arima(log_airport,order=c(1,1,1),include.drift = FALSE)  #o
fit1.1.1
fit1.1.2 <- Arima(log_airport,order=c(0,1,2),include.drift = FALSE)  #o
fit1.1.2
confint(Arima(log_airport,order=c(2,1,1),include.drift = FALSE))  #x 추가된모수 비유의적
confint(Arima(log_airport,order=c(1,1,2),include.drift = FALSE))  #x ma1 비유의적 빼고보면 1,1,1됨
confint(Arima(log_airport,order=c(0,1,3),include.drift = FALSE))  #x 추가된 모수가 비유의저
#aic bic 비교했을떄 1,1,1이 제일 작음

fit2.1 <- Arima(log_airport,order=c(2,0,0),seasonal = list(order=c(0,1,1),period=12))
fit2.1
confint(fit2.1)
checkresiduals(fit2.1)  #ㅇㅋ 확인 가능

Acf(port_12,lag.max = 48)
Pacf(port_12,lag.max = 48)
#(2,0,0)(0,1,1)에 대한 과대적합
confint(Arima(log_airport,order=c(2,0,1),seasonal = list(order=c(0,1,1),period=12)))#  추가된 모수는 유의적,ar2모수가 비유의적  ar2제거  
#ar2제거하고 (1,0,1)(0,1,1)로 확인
fit2.1.1.9 <- Arima(log_airport,order=c(1,0,1),seasonal = list(order=c(0,1,1),period=12))
confint(fit2.1.1.9)
checkresiduals(fit2.1.1.9)  #0
#(1,0,1)(0,1,1) 과대적합
confint(Arima(log_airport,order=c(1,0,2),seasonal = list(order=c(0,1,1),period=12))) #ma1 모수가 비유의적
confint(Arima(log_airport,order=c(1,0,2),fixed=c(NA,0,NA,NA),seasonal = list(order=c(0,1,1),period=12)))#0

confint(Arima(log_airport,order=c(1,0,3),fixed=c(NA,0,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #0
confint(Arima(log_airport,order=c(2,0,2),fixed=c(NA,NA,0,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #0

confint(Arima(log_airport,order=c(2,0,3),fixed=c(NA,NA,0,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #0
confint(Arima(log_airport,order=c(1,0,4),fixed=c(NA,0,NA,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #X
confint(Arima(log_airport,order=c(3,0,2),fixed=c(NA,NA,NA,0,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #X

confint(Arima(log_airport,order=c(3,0,3),fixed=c(NA,NA,NA,0,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12)))  #X
confint(Arima(log_airport,order=c(2,0,4),fixed=c(NA,NA,0,NA,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12),method="ML"))  #왜 안돌아가는지 모르겟음 ;; 

#잠정모형.
fit2.1.1.1.5 <- Arima(log_airport,order=c(2,0,3),fixed=c(NA,NA,0,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12))  #0
checkresiduals(fit2.1.1.1.5)


fit2.1.2 <- Arima(log_airport,order=c(3,0,0),seasonal = list(order=c(0,1,1),period=12))
confint(fit2.1.2)
checkresiduals(fit2.1.2)  #일단만족

#(3,0,0)(0,1,1)에 대한 과대적합
fit2.1.2.1 <- Arima(log_airport,order=c(4,0,0),seasonal = list(order=c(0,1,1),period=12))
confint(fit2.1.2.1)  #x
fit2.1.2.2 <- Arima(log_airport,order=c(3,0,1),seasonal = list(order=c(0,1,1),period=12))
confint(fit2.1.2.2)
checkresiduals(fit2.1.2.2)  #0

#(3,0,1)(0,1,1)에 대한 과대적합
confint(Arima(log_airport,order=c(4,0,1),seasonal = list(order=c(0,1,1),period=12)))  #x
confint(Arima(log_airport,order=c(3,0,2),seasonal = list(order=c(0,1,1),period=12)))  #x
#잠정모형

pred <- scan("C:/Users/user/Desktop/학교수업/시계열분석/조별과제/airport17.txt")
port17 <- ts(pred,start=2017,freq=12)

fit2.1.1.1.5 <- Arima(airport.ts,order=c(2,0,3),fixed=c(NA,NA,0,NA,NA,NA),seasonal = list(order=c(0,1,1),period=12),lambda = 0)
port17 <- ts(pred,start=2017,freq=12)
fore_arima1 <- forecast(fit2.1.1.1.5,h=12,level=95)
plot(fore_arima1)
lines(port17,col="red")
new_t <- seq(2017,by=1/12,length=12)
lines(new_t,port17,col="red")
plot(fore_arima1,xlim=c(2017,2018),ylim=c(3000000,8000000))
accuracy(forecast(fit2.1.1.1.5),port17)


fit2.1.2.2 <- Arima(airport.ts,order=c(3,0,1),seasonal = list(order=c(0,1,1),period=12),lambda=0)
port17 <- ts(pred,start=2017,freq=12)
fore_arima <- forecast(fit2.1.2.2,h=12,level=95)
plot(fore_arima)
lines(port17,col="red")
new_t <- seq(2017,by=1/12,length=12)
lines(new_t,port17,col="red")
plot(fore_arima,xlim=c(2017,2018),ylim=c(3000000,8000000))
accuracy(forecast(fit2.1.2.2),port17)
